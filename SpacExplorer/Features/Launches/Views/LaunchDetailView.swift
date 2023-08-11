//
//  LaunchDetailView.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 07.08.2023.
//

import SwiftUI

struct LaunchDetailView: View {
	let launch: Launch

	var body: some View {
		ScrollView {
			VStack {
				HStack(alignment: .top) {
					RoundedRectangle(cornerRadius: 8)
						.fill(.gray.opacity(0.2))
						.aspectRatio(1, contentMode: .fit)
						.frame(maxHeight: 100)
						.overlay(
							VStack(alignment: .center) {
								if launch.smallPatchUrl == nil {
									Image(systemName: "photo")
								} else {
									NetworkImage(imageUrl: launch.smallPatchUrl!)
								}
							}
							.padding()
						)

					VStack(alignment: .trailing) {
						Text(launch.name)
							.font(.largeTitle)
							.fontWeight(.bold)
							.multilineTextAlignment(.leading)
					}

					Spacer()
				}

				TableItem(title: "ID", value: launch.id)
				TableItem(title: "Date", value: launch.dateLocal.formatted(date: .abbreviated, time: .shortened))
				TableItem(title: "Detail", value: launch.details)

				Spacer()
			}
			.navigationTitle("Launch detail")
			.padding()
		}
	}
}

struct LaunchDetailView_Previews: PreviewProvider {
	static var previews: some View {
		let launch = Launch(
			id: "5eb87cd9ffd86e000604b32b",
			name: "Starlink-1",
			upcoming: false,
			dateLocal: Date(),
			success: true,
			details: "This is another test launch",
			links: Launch.Links(patch: Launch.Patch(small: URL(string: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"), large: URL(string: "https://example.com/large_patch2.png")))
		)

		NavigationView {
			LaunchDetailView(launch: launch)
				.navigationBarTitleDisplayMode(.inline)
		}
	}
}
