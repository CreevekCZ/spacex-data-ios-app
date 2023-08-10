//
//  Constants.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 10.08.2023.
//

import Foundation

struct Constants {
	static let apiAddress = URL(string: "https://api.spacexdata.com/v4")!

	enum Endpoints {
		case launches
		case singleLaunch(id: String)
	}
}
