//
//  FavoritsViewController.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 18.08.2023.
//

import Foundation
import SwiftUI
import UIKit

final class CrewViewController: BaseViewController {
	private var crewViewModel: CrewViewModel
	private var crewListHostingController: HostingController<CrewList>?

	init(crewViewModel: CrewViewModel) {
		self.crewViewModel = crewViewModel
		super.init(nibName: nil, bundle: nil)

		title = "Crew"
		tabBarItem = UITabBarItem(title: title, image: "🧑‍🚀".emojiToImage(), tag: 1)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		Task(priority: .userInitiated) {
			await crewViewModel.loadCrew()
		}

		setupCrewListView()
	}

	private func setupCrewListView() {
		crewListHostingController = HostingController(
			rootView: {
				CrewList(
					crewViewModel: crewViewModel,
					coordinator: coordinator
				)
			}
		)

		guard let crewView = crewListHostingController?.view else {
			fatalError("crewListHostingController cannot be initialized!")
		}

		crewView.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(crewView)

		NSLayoutConstraint.activate([
			crewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			crewView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			crewView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			crewView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
		])
	}
}
