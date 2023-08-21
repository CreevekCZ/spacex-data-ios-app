//
//  Launch.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 04.08.2023.
//

import Combine
import Foundation

struct Launch: Codable, Identifiable, Equatable {
	let id: String
	let name: String
	let upcoming: Bool
	let dateLocal: Date
	let success: Bool?
	let details: String?
	let links: Links

	var successLable: String {
		switch success {
		case true:
			return "Success"
		case false:
			return "Failed"
		default:
			return "–"
		}
	}

	var smallPatchUrl: URL? {
		return links.patch.small
	}

	var largePatchUrl: URL? {
		return links.patch.large
	}

	struct Links: Codable {
		let patch: Patch
		let wikipedia: URL?
		let article: URL?
	}

	struct Patch: Codable {
		let small: URL?
		let large: URL?
	}

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case upcoming
		case dateLocal = "date_local"
		case success
		case details
		case links
	}

	static func == (lhs: Launch, rhs: Launch) -> Bool {
		return lhs.id == rhs.id &&
			lhs.name == rhs.name &&
			lhs.upcoming == rhs.upcoming &&
			lhs.dateLocal == rhs.dateLocal &&
			lhs.success == rhs.success &&
			lhs.details == rhs.details
	}
}
