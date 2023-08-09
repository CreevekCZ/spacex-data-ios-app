//
//  BaseRepository.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 07.08.2023.
//

import Foundation

class BaseRepository<T: Codable> {
	var host: URL

	init(host: URL) {
		self.host = host
	}

	private func composeUrl(uri: String) -> URL? {
		let finalUrl = host.absoluteString + uri

		return URL(string: finalUrl)
	}

	private func getDecoder() -> JSONDecoder {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601

		return decoder
	}

	func readAll(uri: String, completion: @escaping (Result<[T], Error>) -> Void) {
		guard let url = composeUrl(uri: uri) else {
			completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
			return
		}

		let request = URLRequest(url: url)

		URLSession.shared.dataTask(with: request) { data, _, error in

			if let error = error {
				completion(.failure(error))
				return
			}

			guard let data = data else {
				completion(.failure(NSError(domain: "No data", code: 0)))
				return
			}

			do {
				let decoder = self.getDecoder()

				let result = try decoder.decode([T].self, from: data)

				completion(.success(result))
			} catch {
				completion(.failure(error))
			}
		}.resume()
	}

	func readOne(uri: String, completion: @escaping (Result<T, Error>) -> Void) {
		guard let url = composeUrl(uri: uri) else {
			completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
			return
		}

		let request = URLRequest(url: url)

		URLSession.shared.dataTask(with: request) { data, _, error in
			print("TEST")
			if let error = error {
				completion(.failure(error))
			}

			guard let data = data else {
				completion(.failure(NSError(domain: "No data", code: 0)))
				return
			}

			do {
				let decoder = self.getDecoder()

				let result = try decoder.decode(T.self, from: data)

				completion(.success(result))
			} catch {
				completion(.failure(error))
			}
		}.resume()
	}
}
