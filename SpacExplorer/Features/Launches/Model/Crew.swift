//
//  Crew.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 18.08.2023.
//

import Foundation

struct Crew: Codable, Identifiable, Equatable {
	let id: String
	let name: String
	let agency: String
	let image: URL?
	let wikipedia: URL?
	let status: String?
	let launches: [String]

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case agency
		case image
		case wikipedia
		case status
		case launches
	}

	static func == (lhs: Crew, rhs: Crew) -> Bool {
		return lhs.id == rhs.id &&
			lhs.name == rhs.name &&
			lhs.agency == rhs.agency &&
			lhs.image == rhs.image &&
			lhs.wikipedia == rhs.wikipedia &&
			lhs.status == rhs.status &&
			lhs.launches == rhs.launches
	}
}
