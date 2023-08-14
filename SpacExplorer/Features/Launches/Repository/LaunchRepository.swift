//
//  LaunchRepository.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 07.08.2023.
//

import Foundation

protocol LaunchRepository {
	func getLaunch(launchId: String) async throws -> Launch
	func getAll() async throws -> [Launch]
}

class ImplLaunchRepository: BaseRepository<Launch>, LaunchRepository {
	enum Endpoints {
		case launches
		case singleLaunch(id: String)

		var path: String {
			switch self {
			case .launches:
				return "/launches"
			case .singleLaunch(let id):
				return "/launches/\(id)"
			}
		}
	}

	override init(host: URL, session: URLSession = .shared) {
		super.init(host: host, session: session)
	}

	func getLaunch(launchId: String) async throws -> Launch {
		do {
			let launch = try await readOne(uri: Endpoints.singleLaunch(id: launchId).path)
			return launch
		} catch {
			throw error
		}
	}

	func getAll() async throws -> [Launch] {
		do {
			let launches = try await readAll(uri: Endpoints.launches.path)
			return launches
		} catch {
			throw error
		}
	}
}
