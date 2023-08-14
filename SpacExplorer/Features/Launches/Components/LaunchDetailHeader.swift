//
//  LaunchDetailHeader.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 12.08.2023.
//

import Foundation
import SwiftUI

struct LaunchDetailHeader: View {
	let launch: Launch

	var body: some View {
		HStack {
			HStack(alignment: .center) {
				Circle()
					.fill(.gray.opacity(0.2))
					.aspectRatio(1, contentMode: .fit)
					.frame(maxHeight: 80)
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

				VStack(alignment: .leading) {
					Text(launch.name)
						.font(.title)
						.fontWeight(.bold)
						.multilineTextAlignment(.leading)
					Text(launch.id)
				}

				Spacer()
			}
		}
	}
}
