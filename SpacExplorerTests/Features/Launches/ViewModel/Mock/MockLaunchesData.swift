//
//  MockLaunchesData.swift
//  SpacExplorerTests
//
//  Created by Jan Kožnárek on 16.08.2023.
//

import Foundation

enum MockLaunchesData {
	static let singleLaunch = Launch(
		id: "5eb87cd9ffd86e000604b32b",
		name: "Starlink-1",
		upcoming: false,
		dateLocal: Date().addingTimeInterval(-86400),
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

//	MARK: - ----------------------------------------------------------------

	static let multipleLaunches = [
		Launch(
			id: "5eb87cd9ffd86e000604b32b",
			name: "Starlink-1",
			upcoming: false,
			dateLocal: Date().addingTimeInterval(-86400),
			success: true,
			details: "This is another test launch",
			links: Launch.Links(
				patch: Launch.Patch(
					small: URL(string: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"),
					large: URL(string: "https://example.com/large_patch2.png")
				),
				wikipedia: URL(string: "https://en.wikipedia.org/wiki/DemoSat"),
				article: URL(string: "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html")
			)
		),

		Launch(
			id: "5eb87cd9ffd86e000604b32c",
			name: "Starlink-2",
			upcoming: false,
			dateLocal: Date().addingTimeInterval(-86400),
			success: true,
			details: "This is another test launch",
			links: Launch.Links(
				patch: Launch.Patch(
					small: URL(string: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"),
					large: URL(string: "https://example.com/large_patch2.png")
				),
				wikipedia: URL(string: "https://en.wikipedia.org/wiki/DemoSat"),
				article: URL(string: "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html")
			)
		),

		Launch(
			id: "5eb87cd9ffd86e000604b32d",
			name: "Starlink-3",
			upcoming: false,
			dateLocal: Date().addingTimeInterval(-86400),
			success: true,
			details: "This is another test launch",
			links: Launch.Links(
				patch: Launch.Patch(
					small: URL(string: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"),
					large: URL(string: "https://example.com/large_patch2.png")
				),
				wikipedia: URL(string: "https://en.wikipedia.org/wiki/DemoSat"),
				article: URL(string: "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html")
			)
		),

		Launch(
			id: "5eb87cd9ffd86e000604b32e",
			name: "Starlink-4",
			upcoming: true,
			dateLocal: Date().addingTimeInterval(86400),
			success: true,
			details: "This is another test launch",
			links: Launch.Links(
				patch: Launch.Patch(
					small: URL(string: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"),
					large: URL(string: "https://example.com/large_patch2.png")
				),
				wikipedia: URL(string: "https://en.wikipedia.org/wiki/DemoSat"),
				article: URL(string: "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html")
			)
		),

		Launch(
			id: "5eb87cd9ffd86e000604b32f",
			name: "DART",
			upcoming: true,
			dateLocal: Date().addingTimeInterval(86400),
			success: true,
			details: "This is another test launch",
			links: Launch.Links(
				patch: Launch.Patch(
					small: URL(string: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"),
					large: URL(string: "https://example.com/large_patch2.png")
				),
				wikipedia: URL(string: "https://en.wikipedia.org/wiki/DemoSat"),
				article: URL(string: "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html")
			)
		)
	]
}
