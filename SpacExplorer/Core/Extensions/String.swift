//
//  String.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 18.08.2023.
//

import Foundation
import UIKit

extension String {
	func emojiToImage() -> UIImage {
		let emojiString = NSAttributedString(string: self)
		let renderer = UIGraphicsImageRenderer(size: emojiString.size())
		let image = renderer.image { _ in
			emojiString.draw(at: .zero)
		}

		return image
	}
}
