//
//  BaseViewController.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 04.08.2023.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, LaunchesViewModelDelegate {
	weak var coordinator: MainCoordinator?

	override func viewDidLoad() {
		super.viewDidLoad()

		setupBackgroundColor()
	}

	func showError(errorMessage: String) {
		DispatchQueue.main.sync { [weak self] in
			let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)

			alert.addAction(UIAlertAction(title: "OK", style: .cancel))

			self?.present(alert, animated: true)
		}
	}

	func setPrefersLargeTitles(_ value: Bool) {
		navigationController?.navigationBar.prefersLargeTitles = value
	}

	fileprivate func setupBackgroundColor() {
		view.backgroundColor = UIColor.systemBackground
	}
}
