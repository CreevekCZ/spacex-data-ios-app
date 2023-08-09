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

class LaunchesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
	var launchesViewModel: LaunchesViewModel!

	private var tableView: UITableView!

	private var subscriptions = Set<AnyCancellable>()

	override func viewDidLoad() {
		super.viewDidLoad()

		launchesViewModel = LaunchesViewModel()

		setupTableView()

		subscribe()

		title = "Launches"

		navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add,
		                                                 target: self, action: #selector(addLaunch)), animated: true)
	}

	@objc func addLaunch() {
		print("addLaunch")
		print(launchesViewModel.launches.count)
		launchesViewModel.addLaunch()
		print(launchesViewModel.launches.count)
	}

	override func viewWillAppear(_ animated: Bool) {
		setPrefersLargeTitles(true)
	}

	override func viewWillDisappear(_ animated: Bool) {
		setPrefersLargeTitles(false)
	}

	private func setupTableView() {
		let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
		tableView.translatesAutoresizingMaskIntoConstraints = false

		tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: "LaunchTableViewCell")

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

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return launchesViewModel.launches.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let launch = launchesViewModel.launches[indexPath.row]

		guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCell", for: indexPath) as? LaunchTableViewCell else {
			fatalError("The dequeued cell is not an instance of LaunchTableViewCell.")
		}

		cell.configure(launch: launch)

		return cell
	}

	func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
		let launch = launchesViewModel.launches[indexPath.row]

		showDetailScreen(launch)
	}

	func showDetailScreen(_ launch: Launch) {
		print(launch.id)

		let detailScreenHostingViewController = UIHostingController(rootView: LaunchDetailView(launch: launch))

		navigationController?.pushViewController(detailScreenHostingViewController, animated: true)
	}

	private func subscribe() {
		launchesViewModel.$launches.sink { _ in
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
		.store(in: &subscriptions)
	}
}
