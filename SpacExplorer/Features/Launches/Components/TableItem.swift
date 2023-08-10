//
//  TableItem.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 07.08.2023.
//

import SwiftUI

struct TableItem: View {
	let title: String?
	let value: String?

	init(title: String?, value: String?) {
		self.title = title
		self.value = value
	}

	var body: some View {
		HStack(alignment: .top) {
			Text(title ?? "")
				.fontWeight(.bold)

			Spacer()

			Text(value ?? "")
				.textSelection(.enabled)
		}
	}
}

struct TableItem_Previews: PreviewProvider {
	static var previews: some View {
		TableItem(title: "Test", value: "Test value")
	}
}
