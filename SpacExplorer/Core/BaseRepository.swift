//
//  BaseRepository.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 07.08.2023.
//

import Foundation

class BaseRepository<T: Codable> {
	private let host: URL
	private let session: URLSession

	init(host: URL, session: URLSession = .shared) {
		self.host = host
		self.session = session
	}

	private func composeUrl(uri: String) -> URL? {
		let finalUrl = self.host.absoluteString + uri

		return URL(string: finalUrl)
	}

	private func getDecoder() -> JSONDecoder {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601

		return decoder
	}

	func readAll(uri: String) async throws -> [T] {
		guard let url = composeUrl(uri: uri) else {
			throw RepositoryError.invalidUrl
		}

		let request = URLRequest(url: url)

		do {
			let (data, _) = try await session.data(for: request)

			let decoder = self.getDecoder()

			let result = try decoder.decode([T].self, from: data)

			return result
		} catch {
			switch error {
			case let urlError as URLError:
				throw RepositoryError.networkError(urlError)
			case let decodingError as DecodingError:
				throw RepositoryError.decodingError(decodingError)
			default:
				throw error
			}
		}
	}

	func readOne(uri: String) async throws -> T {
		guard let url = composeUrl(uri: uri) else {
			throw RepositoryError.invalidUrl
		}

		let request = URLRequest(url: url)

		do {
			let (data, _) = try await session.data(for: request)

			let decoder = self.getDecoder()

			let result = try decoder.decode(T.self, from: data)

			return result
		} catch {
			switch error {
			case let urlError as URLError:
				throw RepositoryError.networkError(urlError)
			case let decodingError as DecodingError:
				throw RepositoryError.decodingError(decodingError)
			default:
				throw error
			}
		}
	}
}
