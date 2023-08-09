//
//  LaunchRepository.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 07.08.2023.
//

import Foundation

class LaunchRepository: BaseRepository<Launch> {
	override init(host: URL) {
		super.init(host: host)
	}

	func getLaunch(launchId: String, completion: @escaping (Result<Launch, Error>) -> Void) {
		readOne(uri: launchId) { result in
			switch result {
			case .success(let launch):
				print(launch.id)
				completion(.success(launch))
				return
			case .failure(let error):
				completion(.failure(error))
				return
			}
		}
	}

	func getAll(completion: @escaping (Result<[Launch], Error>) -> Void) {
		readAll(uri: "") { result in
			switch result {
			case .success(let launches):
				completion(.success(launches))
				return
			case .failure(let error):
				completion(.failure(error))
				return
			}
		}
	}
}
