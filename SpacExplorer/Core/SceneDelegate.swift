//
//  SceneDelegate.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 01.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	var navigationController: UINavigationController?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let winScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: winScene)

		navigationController = UINavigationController(rootViewController: LaunchesViewController())

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}
