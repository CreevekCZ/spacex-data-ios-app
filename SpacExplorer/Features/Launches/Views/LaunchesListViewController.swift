//
//  LaunchesListViewController.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 03.08.2023.
//

import Combine
import Foundation
import SwiftUI
import UIKit

class LaunchesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
	private let launchesViewModel: LaunchesViewModel
	private let tableView: UITableView
	private let searchController: UISearchController
	private let refreshControl: UIRefreshControl
	private var rightBarButton: UIBarButtonItem
	private var subscriptions: Set<AnyCancellable>
	
	init(
		launchesViewModel: LaunchesViewModel = LaunchesViewModel()
	) {
		self.launchesViewModel = launchesViewModel
		self.tableView = UITableView(frame: .zero, style: .insetGrouped)
		self.searchController = UISearchController()
		self.refreshControl = UIRefreshControl()
		self.rightBarButton = UIBarButtonItem()
		self.subscriptions = Set<AnyCancellable>()
		
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		launchesViewModel.delegateView = self
		
		setupViews()
		
		subscribe()
		
		loadLaunches()
	}
	
	@objc private func showFilterActionSheet() {
		searchController.searchBar.endEditing(true)
		
		let actionSheet = UIAlertController(title: "Filter", message: nil, preferredStyle: .actionSheet)

		let allAction = UIAlertAction(title: "All", style: .default) { [weak self] _ in
			self?.launchesViewModel.updateFilterOption(.all)
		}
		let upcomingAction = UIAlertAction(title: "Upcoming", style: .default) { [weak self] _ in
			self?.launchesViewModel.updateFilterOption(.upcoming)
		}
		let pastAction = UIAlertAction(title: "Past", style: .default) { [weak self] _ in
			self?.launchesViewModel.updateFilterOption(.past)
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		actionSheet.addAction(allAction)
		actionSheet.addAction(upcomingAction)
		actionSheet.addAction(pastAction)
		actionSheet.addAction(cancelAction)

		present(actionSheet, animated: true, completion: nil)
	}
	
	func updateSearchResults(for searchController: UISearchController) {
		if let searchText = searchController.searchBar.text, !searchText.isEmpty {
			launchesViewModel.updateFilterSearchTerm(searchText)
		} else {
			launchesViewModel.updateFilterSearchTerm(nil)
		}
	}
	
	@objc private func loadLaunches() {
		Task { [weak self] in
			await self?.launchesViewModel.loadLaunches()
			self?.refreshControl.endRefreshing()
		}
	}

	private func showDetailScreen(_ launch: Launch) {
		let detailScreenHostingViewController = UIHostingController(
			rootView: LaunchDetailView(launch: launch)
		)
		
		navigationController?.pushViewController(detailScreenHostingViewController, animated: true)
	}

	private func subscribe() {
		launchesViewModel.objectWillChange.sink { [weak self] in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
				
				self?.searchController.searchBar.text = self?.launchesViewModel.launchesFilter.searchTerm
				
				self?.rightBarButton.title =
					self?.launchesViewModel.currentFilterLabel
			}
		}
		.store(in: &subscriptions)
	}
}

// MARK: TableView methods

extension LaunchesViewController {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return launchesViewModel.filteredLaunches.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let launch = launchesViewModel.filteredLaunches[indexPath.row]
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCell") as? LaunchTableViewCell else {
			fatalError("The dequeued cell is not an instance of LaunchTableViewCell.")
		}
		
		cell.configure(launch: launch)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
		let launch = launchesViewModel.filteredLaunches[indexPath.row]
		
		searchController.searchBar.endEditing(true)
		
		showDetailScreen(launch)
	}
}

// MARK: SETUP methods

extension LaunchesViewController {
	private func setupViews() {
		title = "Launches"
		
		setupTableView()
		setupRightBarButton()
		setupRefreshControl()
		setupSearchController()
	}
	
	private func setupSearchController() {
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		
		searchController.searchBar.searchBarStyle = .minimal
		searchController.searchBar.delegate = self
		searchController.searchBar.placeholder = "Search Launches"

		definesPresentationContext = true
		
		tableView.tableHeaderView = searchController.searchBar
	}
	
	private func setupRefreshControl() {
		refreshControl.addTarget(self, action: #selector(loadLaunches), for: .valueChanged)
		refreshControl.backgroundColor = UIColor.systemBackground
		tableView.refreshControl = refreshControl
	}
	
	private func setupTableView() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: "LaunchTableViewCell")
		
		tableView.keyboardDismissMode = .onDrag
		
		tableView.dataSource = self
		tableView.delegate = self
		
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
		])
	}
	
	@objc func unfocusAll() {
		print("unfocusAll")
		searchController.searchBar.endEditing(true)
	}
	
	private func setupRightBarButton() {
		rightBarButton =
			UIBarButtonItem(title: launchesViewModel.launchesFilter.filterOption.rawValue, style: .plain, target: self, action: #selector(showFilterActionSheet))
		
		navigationItem.rightBarButtonItem = rightBarButton
	}
}
