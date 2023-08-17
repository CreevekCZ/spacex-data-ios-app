//
//  MockUserDefaults.swift
//  SpacExplorerTests
//
//  Created by Jan Kožnárek on 17.08.2023.
//

import Foundation

class MockUserDefault: UserDefaults {
	var data = [String: Any?]()

	override func set(_ value: Any?, forKey defaultName: String) {
		data[defaultName] = value
	}

	override func data(forKey defaultName: String) -> Data? {
		return data[defaultName] as? Data
	}
}
