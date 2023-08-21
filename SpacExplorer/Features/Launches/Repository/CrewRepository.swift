//
//  CrewRepository.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 18.08.2023.
//

import Foundation

protocol CrewRepository {
	func getAll() async throws -> [Crew]
	func getCrew(crewId: String) async throws -> Crew
}

final class ImplCrewRepository: BaseRepository<Crew>, CrewRepository {
	enum Endpoints {
		case crew
		case singleCrew(id: String)

		var path: String {
			switch self {
			case .crew:
				return "/crew"
			case .singleCrew(let id):
				return "/crew/\(id)"
			}
		}
	}

	override init(host: URL, session: URLSession = .shared) {
		super.init(host: host, session: session)
	}

	func getCrew(crewId: String) async throws -> Crew {
		do {
			let crew = try await readOne(uri: Endpoints.singleCrew(id: crewId).path)
			return crew
		} catch {
			throw error
		}
	}

	func getAll() async throws -> [Crew] {
		do {
			let crews = try await readAll(uri: Endpoints.crew.path)
			return crews
		} catch {
			throw error
		}
	}
}
