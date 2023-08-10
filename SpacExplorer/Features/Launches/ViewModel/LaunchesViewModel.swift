//
//  LaunchesViewModel.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 08.08.2023.
//

import Foundation
import UIKit

protocol LaunchesViewModelDelegate {
	func showError(errorMessage: String)
}

class LaunchesViewModel: ObservableObject {
	private let launchRepository: LaunchRepository
	private(set) var launchesFilter: LaunchesFilter!

	@Published private(set) var launches: [Launch] = []

	var delegateView: LaunchesViewModelDelegate?

	var filteredLaunches: [Launch] {
		return launchesFilter.filterLaunches(launches)
	}

	init(launchRepository: LaunchRepository = ImplLaunchRepository(host: Constants.apiAddress)) {
		self.launchRepository = launchRepository
		launchesFilter = LaunchesFilter()
	}

	private func cacheFilter() {}

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
		launchesFilter.searchTerm = searchTerm
	}

	func updateFilterOption(_ filterOption: LaunchesFilter.LaunchFilterOption) {
		launchesFilter.filterOption = filterOption
	}
}
