//
//  LaunchesRepositoryMock.swift
//  SpacExplorerTests
//
//  Created by Jan Kožnárek on 15.08.2023.
//

import Foundation
@testable import SpacExplorer

class MockLaunchRepository: LaunchRepository {
	func getLaunch(launchId: String) async throws -> Launch {
		return MockLaunchesData.singleLaunch
	}

	func getAll() async throws -> [Launch] {
		return MockLaunchesData.multipleLaunches
	}
}
