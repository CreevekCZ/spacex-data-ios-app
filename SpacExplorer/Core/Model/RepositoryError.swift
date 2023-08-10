//
//  RepositoryError.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 10.08.2023.
//

import Foundation

enum RepositoryError: Error {
	case invalidUrl
	case networkError(Error)
	case decodingError(Error)

	var errorMessage: String {
		switch self {
		case .invalidUrl:
			return "Invalid URL"
		case .decodingError(let error):
			return "Unxpected server response. \(error.localizedDescription)"
		case .networkError:
			return "Connection to the internet is not awailable."
		}
	}
}
