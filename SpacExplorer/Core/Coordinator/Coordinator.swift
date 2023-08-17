//
//  Coordinator.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 17.08.2023.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
	var childCoordinators: [Coordinator] { get set }
	var navigationController: UINavigationController { get set }

	func start()
}
