//
//  BaseViewController.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 04.08.2023.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		setupBackgroundColor()
	}

	func setPrefersLargeTitles(_ value: Bool) {
		navigationController?.navigationBar.prefersLargeTitles = value
	}

	fileprivate func setupBackgroundColor() {
		view.backgroundColor = UIColor.systemBackground
	}
}
