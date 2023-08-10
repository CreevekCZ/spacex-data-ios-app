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
	var launchesViewModel: LaunchesViewModel!
	
	private var tableView: UITableView!
	private var searchController: UISearchController!
	private var refreshControl: UIRefreshControl!
	private var rightBarButton: UIBarButtonItem!
	
	private var subscriptions = Set<AnyCancellable>()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		launchesViewModel = LaunchesViewModel()
		
		launchesViewModel.delegateView = self
		
		setupViews()
		
		subscribe()
		
		loadLaunches()
	}
	
	@objc func showFilterActionSheet() {
		searchController.searchBar.endEditing(true)
		
		let actionSheet = UIAlertController(title: "Filter", message: nil, preferredStyle: .actionSheet)

		let allAction = UIAlertAction(title: "All", style: .default) { [weak self] _ in
			self?.applyFilter(.all)
		}
		let upcomingAction = UIAlertAction(title: "Upcoming", style: .default) { [weak self] _ in
			self?.applyFilter(.upcoming)
		}
		let pastAction = UIAlertAction(title: "Past", style: .default) { [weak self] _ in
			self?.applyFilter(.past)
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		actionSheet.addAction(allAction)
		actionSheet.addAction(upcomingAction)
		actionSheet.addAction(pastAction)
		actionSheet.addAction(cancelAction)

		present(actionSheet, animated: true, completion: nil)
	}
	
	internal func applyFilter(_ option: LaunchesFilter.LaunchFilterOption) {
		launchesViewModel.updateFilterOption(option)
		rightBarButton.title =
			launchesViewModel.launchesFilter.filterOption.rawValue
		
		tableView.reloadData()
	}

	func updateSearchResults(for searchController: UISearchController) {
		if let searchText = searchController.searchBar.text, !searchText.isEmpty {
			launchesViewModel.updateFilterSearchTerm(searchText)
		} else {
			launchesViewModel.updateFilterSearchTerm(nil)
		}
		
		tableView.reloadData()
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		searchController.isActive = false
	}
	
	@objc func loadLaunches() {
		Task { [weak self] in
			await self?.launchesViewModel.loadLaunches()
			self?.refreshControl.endRefreshing()
		}
	}

	func showDetailScreen(_ launch: Launch) {
		let detailScreenHostingViewController = UIHostingController(rootView: LaunchDetailView(launch: launch).environmentObject(launchesViewModel))

		navigationController?.pushViewController(detailScreenHostingViewController, animated: true)
	}

	private func subscribe() {
		launchesViewModel.objectWillChange.sink { [weak self] in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
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
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCell", for: indexPath) as? LaunchTableViewCell else {
			fatalError("The dequeued cell is not an instance of LaunchTableViewCell.")
		}
		
		cell.configure(launch: launch)
		
		return cell
	}

	func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
		searchController.searchBar.endEditing(true)
		
		let launch = launchesViewModel.launches[indexPath.row]

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
		searchController = UISearchController()
		searchController.searchResultsUpdater = self
		searchController.hidesNavigationBarDuringPresentation = false
		
		searchController.searchBar.delegate = self
		searchController.searchBar.searchBarStyle = .minimal
		
		tableView.tableHeaderView = searchController.searchBar
	}
	
	private func setupRefreshControl() {
		refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(loadLaunches), for: .valueChanged)
		tableView.refreshControl = refreshControl
	}
	
	private func setupTableView() {
		let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: "LaunchTableViewCell")
		
		tableView.keyboardDismissMode = .onDrag
		
		tableView.dataSource = self
		tableView.delegate = self
		
		view.addSubview(tableView)
		
		self.tableView = tableView
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
		])
	}
	
	private func setupRightBarButton() {
		rightBarButton =
			UIBarButtonItem(title: launchesViewModel.launchesFilter.filterOption.rawValue, style: .plain, target: self, action: #selector(showFilterActionSheet))
		
		navigationItem.rightBarButtonItem = rightBarButton
	}
}
