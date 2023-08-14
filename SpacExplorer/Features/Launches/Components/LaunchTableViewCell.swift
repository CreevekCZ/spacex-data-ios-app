//
//  LaunchTableViewCell.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 07.08.2023.
//

import Foundation
import SwiftUI
import UIKit

class LaunchTableViewCell: UITableViewCell {
	var launch: Launch!

	private var titleLabel: UILabel = {
		let title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false

		return title
	}()

	private var subtitle: UILabel = {
		let description = UILabel()
		description.translatesAutoresizingMaskIntoConstraints = false

		return description
	}()

	private var leadingImage: UIHostingController<NetworkImage>!

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		setupLayout()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		launch = nil
		titleLabel.text = nil
		subtitle.text = nil
		leadingImage.rootView = NetworkImage(imageUrl: nil)
	}

	func configure(launch: Launch) {
		self.launch = launch
		titleLabel.text = launch.name
		subtitle.text = launch.id
		leadingImage.rootView = NetworkImage(imageUrl: launch.smallPatchUrl)
	}

	private func setupLayout() {
		setupLeadingImage()
		setupTitle()
		setupSubtitle()
	}

	private func setupLeadingImage() {
		leadingImage = UIHostingController(rootView: NetworkImage(imageUrl: launch?.smallPatchUrl))

		leadingImage.view.translatesAutoresizingMaskIntoConstraints = false
		leadingImage.view.backgroundColor = UIColor.clear

		contentView.addSubview(leadingImage.view)

		NSLayoutConstraint.activate([
			leadingImage.view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			leadingImage.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			leadingImage.view.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -5),
			leadingImage.view.widthAnchor.constraint(equalToConstant: 40),
		])
	}

	private func setupTitle() {
		titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
		titleLabel.textColor = UIColor.label

		contentView.addSubview(titleLabel)

		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			titleLabel.leftAnchor.constraint(equalTo: leadingImage.view.rightAnchor, constant: 5),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
		])
	}

	private func setupSubtitle() {
		subtitle.font = UIFont.systemFont(ofSize: 14)
		subtitle.textColor = UIColor.secondaryLabel

		contentView.addSubview(subtitle)

		NSLayoutConstraint.activate([
			subtitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
			subtitle.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			subtitle.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

		])
	}
}
