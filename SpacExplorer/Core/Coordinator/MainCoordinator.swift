//
//  MainCoordinator.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 17.08.2023.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator, ObservableObject {
	var childCoordinators = [Coordinator]()

	var navigationController: UINavigationController
	private var window: UIWindow

	private var launchesViewModel: LaunchesViewModel
	private var crewViewModel: CrewViewModel

	init(
		navigationController: UINavigationController,
		window: UIWindow,
		launchesViewModel: LaunchesViewModel = LaunchesViewModel(),
		crewViewModel: CrewViewModel = CrewViewModel()
	) {
		self.navigationController = navigationController
		self.window = window
		self.launchesViewModel = launchesViewModel
		self.crewViewModel = crewViewModel
	}

	func start() {
		let launchesViewController = LaunchesViewController(launchesViewModel: launchesViewModel)
		launchesViewController.coordinator = self

		let crewViewController = CrewViewController(crewViewModel: crewViewModel)
		crewViewController.coordinator = self

		let mainTapViewController = MainTabBarViewController(
			launchesListViewController: launchesViewController,
			crewViewController: crewViewController
		)

		navigationController.pushViewController(mainTapViewController, animated: true)
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
					.environmentObject(self)
			}
		)

		navigationController.pushViewController(detailScreenHostingViewController, animated: true)
	}

	func goToCrewDetail(crew: Crew) {
		let crewDetailHostingController = HostingController {
			CrewDetailView(crew: crew)
				.environmentObject(launchesViewModel)
				.environmentObject(self)
		}

		navigationController.pushViewController(crewDetailHostingController, animated: true)
	}
}
