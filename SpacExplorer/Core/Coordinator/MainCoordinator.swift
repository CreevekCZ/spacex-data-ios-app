//
//  MainCoordinator.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 17.08.2023.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
	var childCoordinators = [Coordinator]()

	var navigationController: UINavigationController
	var window: UIWindow

	init(
		navigationController: UINavigationController,
		window: UIWindow
	) {
		self.navigationController = navigationController
		self.window = window
	}

	func start() {
		let launchesViewController = LaunchesViewController()
		launchesViewController.coordinator = self

		navigationController.pushViewController(launchesViewController, animated: true)
	}

	func goBackToRoot() {
		navigationController.popToRootViewController(animated: true)
	}

	func goBack() {
		navigationController.popViewController(animated: true)
	}

	func goToLaunchDetail(launch: Launch) {
		let detailScreenHostingViewController = HostingController(
			rootView: {
				LaunchDetailView(launch: launch)
			}, coordinator: self
		)

		navigationController.pushViewController(detailScreenHostingViewController, animated: true)
	}
}
