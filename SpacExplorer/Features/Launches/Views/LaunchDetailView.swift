//
//  LaunchDetailView.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 07.08.2023.
//

import SafariServices
import SwiftUI

struct LaunchDetailView: View {
	let launch: Launch

	@State private var isWikipediaSheetOpen = false
	@State private var isArticleSheetOpen = false

	var body: some View {
		List {
			Section {
				LaunchDetailHeader(launch: launch)

				TableItem(title: "Date", value: launch.dateLocal.formatted(date: .abbreviated, time: .shortened))
			}
			Section(header: Text("Details")) {
				TableItem(title: "Status", value: launch.successLable)

				Visibility(visible: launch.details != nil) {
					Text(launch.details ?? "")
				}

				Visibility(visible: launch.links.wikipedia != nil) {
					ActionTableItem(title: "Wikipedia", actionTitle: "Open") {
						isWikipediaSheetOpen.toggle()
					}
				}

				Visibility(visible: launch.links.article != nil) {
					ActionTableItem(title: "Article", actionTitle: "Open") {
						isArticleSheetOpen.toggle()
					}
				}
			}
		}
		.listStyle(.insetGrouped)
		.navigationTitle("Launch detail")
		.navigationBarTitleDisplayMode(.inline)
		.sheet(isPresented: $isWikipediaSheetOpen) {
			InAppSafariView(url: launch.links.wikipedia!)
		}
		.sheet(isPresented: $isArticleSheetOpen) {
			InAppSafariView(url: launch.links.article!)
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
			links: Launch.Links(
				patch: Launch.Patch(
					small: URL(
						string: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"
					), large: URL(
						string: "https://example.com/large_patch2.png"
					)
				), wikipedia: URL(
					string: "https://en.wikipedia.org/wiki/DemoSat"
				), article: URL(
					string: "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html"
				)
			)
		)

		NavigationView {
			LaunchDetailView(launch: launch)
		}
	}
}
