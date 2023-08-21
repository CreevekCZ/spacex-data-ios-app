//
//  CrewList.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 21.08.2023.
//

import SwiftUI

struct CrewList: View {
	@ObservedObject var crewViewModel: CrewViewModel
	weak var coordinator: MainCoordinator?

	init(crewViewModel: CrewViewModel, coordinator: MainCoordinator? = nil) {
		self.crewViewModel = crewViewModel
		self.coordinator = coordinator
	}

	var body: some View {
		VStack {
			List(crewViewModel.crew) { crew in

				HStack {
					NetworkImage(imageUrl: crew.image)
						.clipShape(Circle())
						.frame(width: 60, height: 60)

					Text(crew.name)
				}
				.onTapGesture {
					coordinator?.goToCrewDetail(crew: crew)
				}
				.listRowInsets(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 5))
			}
		}
	}
}

struct CrewList_Previews: PreviewProvider {
	static var previews: some View {
		let viewModel = CrewViewModel()

		CrewList(crewViewModel: viewModel)
			.environmentObject(viewModel)
	}
}
