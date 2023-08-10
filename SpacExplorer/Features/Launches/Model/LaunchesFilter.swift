//
//  LaunchesFilter.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 10.08.2023.
//

import Foundation

class LaunchesFilter: Codable {
	var searchTerm: String?
	var filterOption: LaunchFilterOption = .all

	enum LaunchFilterOption: String, Codable {
		case past = "Past"
		case upcoming = "Upcoming"
		case all = "All"
	}

	private enum CodingKeys: String, CodingKey {
		case searchTerm
		case filterOption
	}

	func filterLaunches(_ launches: [Launch]) -> [Launch] {
		var filteredLaunches = launches

		switch filterOption {
		case .past:
			filteredLaunches = filteredLaunches.filter { $0.dateLocal < Date() }
		case .upcoming:
			filteredLaunches = filteredLaunches.filter { $0.upcoming == true }
		case .all:
			break
		}

		if let searchTerm = searchTerm?.lowercased(), !searchTerm.isEmpty {
			filteredLaunches = filteredLaunches.filter {
				$0.name.lowercased().contains(searchTerm) ||
					$0.id.contains(searchTerm)
			}
		}

		return filteredLaunches
	}
}
