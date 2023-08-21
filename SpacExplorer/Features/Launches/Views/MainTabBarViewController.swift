//
//  MainTabBarViewController.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 18.08.2023.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
	var launchesListViewController: LaunchesViewController
	var crewViewController: CrewViewController

	init(
		launchesListViewController: LaunchesViewController,
		crewViewController: CrewViewController
	) {
		self.launchesListViewController = launchesListViewController
		self.crewViewController = crewViewController

		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		viewControllers = [
			launchesListViewController,
			crewViewController,
		]
	}
}
