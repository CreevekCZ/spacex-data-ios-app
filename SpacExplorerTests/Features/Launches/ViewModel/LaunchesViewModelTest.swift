//
//  LaunchesViewModel.swift
//  SpacExplorerTests
//
//  Created by Jan Kožnárek on 15.08.2023.
//

@testable import SpacExplorer
import XCTest

final class LaunchesViewModelTests: XCTestCase {
	var launchesViewModel: LaunchesViewModel!

	override func setUp() async throws {
		launchesViewModel = await getPreparedLaunchesViewModel()
	}

	func getPreparedLaunchesViewModel() async -> LaunchesViewModel {
		let launchesViewModel = LaunchesViewModel(
			launchRepository: MockLaunchRepository(),
			userDefaults: MockUserDefault()
		)

		await launchesViewModel.loadLaunches()

		return launchesViewModel
	}

	func testLoadLaunches() async throws {
		XCTAssertEqual(launchesViewModel.launches.count, 5)
		XCTAssertEqual(launchesViewModel.launches.first, MockLaunchesData.multipleLaunches.first)
		XCTAssertEqual(launchesViewModel.launches.last, MockLaunchesData.multipleLaunches.last)
	}

	func testSearchTermFilter() async throws {
		launchesViewModel.updateFilterSearchTerm("Star")

		XCTAssertEqual(launchesViewModel.filteredLaunches.count, 4)
		XCTAssertFalse(launchesViewModel.filteredLaunches.contains(MockLaunchesData.multipleLaunches.last!))
	}

	func testFilterByUpcomingOption() async throws {
		let launchesViewModel = await getPreparedLaunchesViewModel()

		launchesViewModel.updateFilterOption(.upcoming)

		XCTAssertEqual(launchesViewModel.filteredLaunches.count, 2)
		XCTAssertEqual(launchesViewModel.currentFilterLabel, LaunchesFilter.LaunchFilterOption.upcoming.rawValue)

		for launch in launchesViewModel.filteredLaunches {
			XCTAssertTrue(launch.upcoming)
		}
	}

	func testFilterByPastOption() async throws {
		let launchesViewModel = await getPreparedLaunchesViewModel()

		launchesViewModel.updateFilterOption(.past)

		XCTAssertEqual(launchesViewModel.filteredLaunches.count, 3)
		XCTAssertEqual(launchesViewModel.currentFilterLabel, LaunchesFilter.LaunchFilterOption.past.rawValue)

		for launch in launchesViewModel.filteredLaunches {
			XCTAssertFalse(launch.upcoming)
		}
	}

	func testFilterByAllOption() async throws {
		let launchesViewModel = await getPreparedLaunchesViewModel()

		launchesViewModel.updateFilterOption(.all)

		XCTAssertEqual(launchesViewModel.filteredLaunches.count, 5)
		XCTAssertEqual(launchesViewModel.currentFilterLabel, LaunchesFilter.LaunchFilterOption.all.rawValue)
	}
}
