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
	override init(host: URL, session: URLSession = .shared) {
		super.init(host: host, session: session)
	}

	func getLaunch(launchId: String) async throws -> Launch {
		do {
			let launch = try await readOne(uri: "/launches/" + launchId)
			print(launch.id)
			return launch
		} catch {
			throw error
		}
	}

	func getAll() async throws -> [Launch] {
		do {
			let launches = try await readAll(uri: "/launches")
			return launches
		} catch {
			throw error
		}
	}
}
