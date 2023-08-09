//
//  LaunchesViewModel.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 08.08.2023.
//

import Foundation

class LaunchesViewModel: ObservableObject {
	private let launchRepository: LaunchRepository

	init() {
		self.launchRepository = LaunchRepository(host: URL(string: "https://api.spacexdata.com/v4/launches/")!)
	}

	func addLaunch() {
		launches.append(Launch(
			id: "5eb87cd9ffd86e000604fasf",
			name: "Kobra",
			upcoming: false,
			dateLocal: Date(),
			success: true,
			details: "Test",
			links: Launch.Links(patch: Launch.Patch(small: URL(string: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"), large: URL(string: "https://images2.imgbox.com/5b/02/QcxHUb5V_o.png")))
		)
		)
	}

	@Published private(set) var launches: [Launch] = [
		Launch(
			id: "5eb87cd9ffd86e000604b32b",
			name: "Starlink-1",
			upcoming: false,
			dateLocal: Date(),
			success: true,
			details: "This is another test launch",
			links: Launch.Links(patch: Launch.Patch(small: URL(string: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"), large: URL(string: "https://images2.imgbox.com/5b/02/QcxHUb5V_o.png")))
		),
		Launch(
			id: "5eb87cd9ffd86e000604b32c",
			name: "CRS-20",
			upcoming: false,
			dateLocal: Date(),
			success: true,
			details: "This is a third test launch",
			links: Launch.Links(patch: Launch.Patch(small: URL(string: "https://example.com/small_patch3.png"), large: URL(string: "https://example.com/large_patch3.png")))
		),
		Launch(
			id: "5eb87cd9ffd86e000604b32d",
			name: "GPS III SV03 (Columbus)",
			upcoming: true,
			dateLocal: Date(),
			success: false,
			details: nil,
			links: Launch.Links(patch: Launch.Patch(small: URL(string: "https://example.com/small_patch4.png"), large: URL(string: "https://example.com/large_patch4.png")))
		),
		Launch(
			id: "5eb87cd9ffd86e000604b32e",
			name: "Crew-1",
			upcoming: false,
			dateLocal: Date(),
			success: true,
			details: "This is a fourth test launch",
			links: Launch.Links(patch: Launch.Patch(small: URL(string: "https://example.com/small_patch5.png"), large: URL(string: "https://example.com/large_patch5.png")))
		),
	]
}
