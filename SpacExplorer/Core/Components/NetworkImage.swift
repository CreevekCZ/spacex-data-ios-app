//
//  NetworkImage.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 07.08.2023.
//

import SwiftUI

struct NetworkImage: View {
	let imageUrl: URL?

	var body: some View {
		AsyncImage(url: imageUrl) { phase in
			switch phase {
			case .success(let image):
				image
					.resizable()
					.aspectRatio(contentMode: .fit)
					.background(.clear)
			case .empty:
				ProgressView()
					.scaleEffect(2)
					.background(.clear)
			case .failure:
				Image(systemName: "photo")
					.foregroundColor(.gray.opacity(0.85))
			@unknown default:
				Image(systemName: "photo")
					.foregroundColor(.gray.opacity(0.85))
			}
		}
	}
}

struct NetworkImage_Previews: PreviewProvider {
	static var previews: some View {
		let url = URL(string: "https://example.com/small_patch2.png")

		NetworkImage(imageUrl: url!)
			.previewLayout(.sizeThatFits)
	}
}
