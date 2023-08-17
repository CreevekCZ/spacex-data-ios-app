//
//  HostingController.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 17.08.2023.
//

import Foundation
import SwiftUI
import UIKit

class HostingController<Content: View>: UIHostingController<Content> {
	weak var coordinator: Coordinator?

	init(
		@ViewBuilder rootView: () -> Content,
		coordinator: Coordinator? = nil
	) {
		super.init(rootView: rootView())
		self.coordinator = coordinator
	}

	@available(*, unavailable)
	@MainActor dynamic required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
