//
//  CrewTest.swift
//  SpacExplorerTests
//
//  Created by Jan Kožnárek on 18.08.2023.
//

@testable import SpacExplorer
import XCTest

final class CrewTest: XCTestCase {
	let crewJson =
		"""
		{
			"name": "Robert Behnken",
			"agency": "NASA",
			"image": "https://imgur.com/0smMgMH.png",
			"wikipedia": "https://en.wikipedia.org/wiki/Robert_L._Behnken",
			"launches": [
				"5eb87d46ffd86e000604b388"
			],
			"status": "active",
			"id": "5ebf1a6e23a9a60006e03a7a"
		}
		"""

	func testJsonDecode() throws {

		let jsonData = crewJson.data(using: .utf8)!
		let crew = try JSONDecoder().decode(Crew.self, from: jsonData)

		XCTAssertEqual(crew.name, "Robert Behnken")
		XCTAssertEqual(crew.agency, "NASA")
		XCTAssertEqual(crew.image, URL(string: "https://imgur.com/0smMgMH.png"))
		XCTAssertEqual(crew.wikipedia, URL(string: "https://en.wikipedia.org/wiki/Robert_L._Behnken"))
		XCTAssertEqual(crew.launches, ["5eb87d46ffd86e000604b388"])
		XCTAssertEqual(crew.status, "active")
		XCTAssertEqual(crew.id, "5ebf1a6e23a9a60006e03a7a")

	}
}
