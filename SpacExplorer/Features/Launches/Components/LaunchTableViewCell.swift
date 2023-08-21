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

	private var leadingImage: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.backgroundColor = UIColor.clear

		return imageView
	}()

	private var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical

		return stackView
	}()

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
		leadingImage.image = nil
	}

	func configure(launch: Launch) {
		self.launch = launch
		titleLabel.text = launch.name
		subtitle.text = launch.id

		let placeholder = UIImage(systemName: "photo")

		if let url = launch.smallPatchUrl {
			leadingImage.load(url: url, placeholder: placeholder)
		} else {
			leadingImage.image = placeholder
			leadingImage.tintColor = .gray
		}
	}

	private func setupLayout() {
		setupLeadingImage()
		setupStackView()
		setupTitle()
		setupSubtitle()
	}

	private func setupLeadingImage() {
		contentView.addSubview(leadingImage)

		leadingImage.contentMode = .scaleAspectFit

		NSLayoutConstraint.activate([
			leadingImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			leadingImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			leadingImage.widthAnchor.constraint(equalToConstant: 50),
			leadingImage.heightAnchor.constraint(equalToConstant: 40),
		])
	}

	private func setupStackView() {
		contentView.addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			stackView.leftAnchor.constraint(equalTo: leadingImage.rightAnchor, constant: 5),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
			stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10),
		])
	}

	private func setupTitle() {
		titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
		titleLabel.textColor = UIColor.label

		stackView.addArrangedSubview(titleLabel)
	}

	private func setupSubtitle() {
		subtitle.font = UIFont.systemFont(ofSize: 14)
		subtitle.textColor = UIColor.secondaryLabel

		stackView.addArrangedSubview(subtitle)
	}
}
