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

	var body: some View {
		HStack(alignment: .top) {
			Text(title ?? "")
				.fontWeight(.regular)

			Spacer()

			Text(value ?? "")
				.foregroundColor(Color.secondary)
		}
		.padding(.vertical, 2)
	}
}

struct TableItem_Previews: PreviewProvider {
	static var previews: some View {
		TableItem(title: "Test", value: "Test value")
			.previewLayout(.sizeThatFits)
	}
}
