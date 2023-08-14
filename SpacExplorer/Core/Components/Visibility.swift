//
//  Visibility.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 14.08.2023.
//

import SwiftUI

struct Visibility<Content: View>: View {
	let visible: Bool

	@ViewBuilder let content: Content
	@ViewBuilder let replacement: Content?

	init(
		visible: Bool,
		@ViewBuilder content: () -> Content,
		@ViewBuilder replacement: () -> Content? = { nil }
	) {
		self.visible = visible
		self.content = content()
		self.replacement = replacement()
	}

	var body: some View {
		if visible {
			content
		} else if replacement == nil {
			EmptyView()
		} else {
			replacement!
		}
	}
}

struct Visibility_Previews: PreviewProvider {
	static var previews: some View {
		Visibility(visible: true, content: {
			Text("PES")
		}, replacement: {
			Text("Kocka")
		})
		.previewLayout(.sizeThatFits)
	}
}
