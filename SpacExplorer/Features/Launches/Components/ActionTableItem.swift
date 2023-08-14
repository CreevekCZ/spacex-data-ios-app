//
//  ActionTableItem.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 14.08.2023.
//

import SwiftUI

struct ActionTableItem: View {
	let title: String
	let actionTitle: String

	let action: () -> Void

	var body: some View {
		HStack {
			Text(title)

			Spacer()

			Button(actionTitle) {
				action()
			}
		}
	}
}

struct ActionTableItem_Previews: PreviewProvider {
	static var previews: some View {
		ActionTableItem(title: "Title", actionTitle: "Action") {
			print("TEST")
		}
		.previewLayout(.sizeThatFits)
	}
}
