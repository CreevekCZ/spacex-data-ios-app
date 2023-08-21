//
//  CrewDetailView.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 21.08.2023.
//

import SwiftUI

struct CrewDetailView: View {
	@EnvironmentObject private var launchesViewModel: LaunchesViewModel
	@EnvironmentObject private var coordinator: MainCoordinator

	@State private var isWikipediaSheetOpen = false
	@State private var isLaunchesListExpanded = false

	let crew: Crew

	var body: some View {
		VStack {
			List {
				AsyncImage(url: crew.image) { image in
					image
						.resizable()
						.aspectRatio(contentMode: .fit)
				} placeholder: {
					ProgressView()
				}
				.cornerRadius(10)
				.frame(maxWidth: .infinity)
				.padding(0)

				Text(crew.name)
					.font(.title)
					.padding()

				Section(header: Text("Details")) {
					TableItem(title: "Agency", value: crew.agency)

					Visibility(visible: crew.status != nil) {
						TableItem(title: "Status", value: crew.status?.uppercased())
					}

					Visibility(visible: crew.wikipedia != nil) {
						ActionTableItem(title: "Wikipedia", actionTitle: "Open") {
							isWikipediaSheetOpen.toggle()
						}
					}

					Visibility(visible: !crew.launches.isEmpty) {
						DisclosureGroup(isExpanded: $isLaunchesListExpanded) {
							ForEach(launchesViewModel.getLaunches(by: crew.launches), id: \.id) { launch in
								HStack {
									NetworkImage(imageUrl: launch.largePatchUrl)
										.frame(width: 40, height: 40)

									Text(launch.name)

									Spacer()

									Image(systemName: "chevron.right")
										.foregroundColor(.gray)
								}
								.onTapGesture {
									coordinator.goToLaunchDetail(launch: launch)
								}
							}
						} label: {
							Text("Launches")
						}
					}
				}
			}
		}
		.navigationTitle("Crew member detail")
		.sheet(isPresented: $isWikipediaSheetOpen) {
			InAppSafariView(url: crew.wikipedia!)
		}
	}
}

struct CrewDetailView_Previews: PreviewProvider {
	static var previews: some View {
		let crew = Crew(id: "fpajsfoiahsoigfasiohgfh", name: "John Doe", agency: "NASA", image: nil, wikipedia: nil, status: "ACTIVE", launches: ["DASFFAS", "FSAFSAFGSA"])

		CrewDetailView(crew: crew)
	}
}
