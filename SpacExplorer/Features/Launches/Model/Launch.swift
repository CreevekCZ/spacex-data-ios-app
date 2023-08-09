//
//  Launch.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 04.08.2023.
//

import Foundation

struct Launch: Codable, Identifiable {
	let id: String
	let name: String
	let upcoming: Bool
	let dateLocal: Date
	let success: Bool?
	let details: String?
	let links: Links

	var smallPatchUrl: URL? {
		return links.patch.small
	}

	var largePatchUrl: URL? {
		return links.patch.large
	}

	struct Links: Codable {
		let patch: Patch
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
}
