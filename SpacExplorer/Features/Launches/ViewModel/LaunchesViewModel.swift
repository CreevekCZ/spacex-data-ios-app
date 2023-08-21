//
//  LaunchesViewModel.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 08.08.2023.
//

import Foundation
import UIKit

protocol ViewModelErrorDelegate {
	func showError(errorMessage: String)
}

class LaunchesViewModel: ObservableObject {
	private let launchRepository: LaunchRepository
	private(set) var launchesFilter: LaunchesFilter
	private var userDefaults: UserDefaults

	@Published private(set) var launches: [Launch] = []

	var delegateView: ViewModelErrorDelegate?

	var filteredLaunches: [Launch] {
		return launchesFilter.filterLaunches(launches)
	}

	var currentFilterLabel: String {
		return launchesFilter.filterOption.rawValue
	}

	init(
		launchRepository: LaunchRepository = ImplLaunchRepository(host: Constants.apiAddress),
		userDefaults: UserDefaults = UserDefaults.standard,
		launchesFilter: LaunchesFilter = LaunchesFilter()
	) {
		self.launchRepository = launchRepository
		self.userDefaults = userDefaults
		self.launchesFilter = launchesFilter

		loadFilter()
	}

	private func saveFilter() {
		do {
			let data = try JSONEncoder().encode(launchesFilter)
			userDefaults.set(data, forKey: Constants.UserDefaultsKey.launchesFilter.rawValue)
		} catch {
			delegateView?.showError(errorMessage: "Error encoding launches filter: \(error.localizedDescription)")
		}

		objectWillChange.send()
	}

	private func loadFilter() {
		if let data = userDefaults.data(forKey: Constants.UserDefaultsKey.launchesFilter.rawValue) {
			do {
				launchesFilter = try JSONDecoder().decode(LaunchesFilter.self, from: data)
			} catch {
				delegateView?.showError(errorMessage: "Error decoding launches filter: \(error.localizedDescription)")
			}
		}
	}

	func loadLaunches() async {
		do {
			launches = try await launchRepository.getAll()
		} catch where error is RepositoryError {
			delegateView?.showError(errorMessage: (error as! RepositoryError).errorMessage)
		} catch {
			delegateView?.showError(errorMessage: error.localizedDescription)
		}
	}

	func updateFilterSearchTerm(_ searchTerm: String?) {
		if launchesFilter.searchTerm == searchTerm {
			return
		}

		launchesFilter.searchTerm = searchTerm

		saveFilter()
	}

	func updateFilterOption(_ filterOption: LaunchesFilter.LaunchFilterOption) {
		if launchesFilter.filterOption == filterOption {
			return
		}

		launchesFilter.filterOption = filterOption

		saveFilter()
	}

	func getLaunches(by ids: [String]) -> [Launch] {
		return launches.filter { launch in
			ids.contains(launch.id)
		}
	}
}
