//
//  InAppSafariView.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 13.08.2023.
//

import SafariServices
import SwiftUI

struct InAppSafariView: UIViewControllerRepresentable {
	let url: URL

	func makeUIViewController(context: Context) -> SFSafariViewController {
		return SFSafariViewController(url: url)
	}

	func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

struct InAppSafariView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			InAppSafariView(url: URL(string: "https://google.com/")!)
				.previewLayout(.sizeThatFits)
		}
	}
}
