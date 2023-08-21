//
//  CrewViewModel.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 18.08.2023.
//

import Foundation

final class CrewViewModel: ObservableObject {
	private let crewRepository: CrewRepository

	@Published private(set) var crew: [Crew] = []

	var delegateView: ViewModelErrorDelegate?

	init(
		crewRepository: CrewRepository = ImplCrewRepository(host: Constants.apiAddress)
	) {
		self.crewRepository = crewRepository
	}

	func loadCrew() async {
		do {
			let crewData = try await crewRepository.getAll()

			DispatchQueue.main.sync {
				crew = crewData
			}

		} catch where error is RepositoryError {
			delegateView?.showError(errorMessage: (error as! RepositoryError).errorMessage)
		} catch {
			delegateView?.showError(errorMessage: error.localizedDescription)
		}
	}
}
