//
//  UIImageView.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 14.08.2023.
//

import Foundation
import UIKit

extension UIImageView {
	func load(url: URL, placeholder: UIImage?, cache: URLCache = URLCache.shared) {
		let cache = cache
		let request = URLRequest(url: url)

		if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
			DispatchQueue.main.async {
				self.image = image
			}
		} else {
			self.image = placeholder
			tintColor = .gray

			URLSession.shared.dataTask(with: request) { [weak self] data, response, _ in
				guard let data = data, let httpResponse = response as? HTTPURLResponse, 200 ... 299 ~= httpResponse.statusCode, let image = UIImage(data: data) else { return }

				let cachedData = CachedURLResponse(response: httpResponse, data: data)
				cache.storeCachedResponse(cachedData, for: request)
				DispatchQueue.main.async {
					self?.image = image
				}
			}.resume()
		}
	}
}
