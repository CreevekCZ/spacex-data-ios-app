//
//  NetworkImage.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 07.08.2023.
//

import SwiftUI

struct NetworkImage: View {
	let imageUrl: URL?
	@State private var image: UIImage? = nil

	@State private var isFailed = false

	init(imageUrl: URL?) {
		self.imageUrl = imageUrl
	}

	func fetchImage() {
		guard let url = imageUrl else {
			isFailed = true
			return
		}

		URLSession.shared.dataTask(with: url) { data, _, error in

			guard let data = data, error == nil else {
				isFailed = true
				return
			}

			DispatchQueue.main.async {
				if let image = UIImage(data: data) {
					self.image = image
				} else {
					isFailed = true
				}
			}
		}.resume()
	}

	var body: some View {
		VStack(alignment: .center) {
			if let image = image {
				Image(uiImage: image)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.background(.clear)
			} else {
				if isFailed == false {
					ProgressView()
						.scaleEffect(2)
						.background(.clear)
				} else {
					Image(systemName: "photo")
						.resizable()
						.foregroundColor(.gray.opacity(0.85))
						.scaledToFit()
						.frame(height: 100)
						.background(.clear)
				}
			}
		}
		.onAppear(perform: fetchImage)
	}
}

struct NetworkImage_Previews: PreviewProvider {
	static var previews: some View {
		let url = URL(string: "https://example.com/small_patch2.png")

		NetworkImage(imageUrl: url!)
			.previewLayout(.sizeThatFits)
	}
}
