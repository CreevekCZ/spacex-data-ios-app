//
//  ViewController.swift
//  SpacExplorer
//
//  Created by Jan Kožnárek on 01.08.2023.
//

import UIKit

class ViewController: UIViewController {
	private var goNextButton = {
		let button = UIButton(type: .system)

		return button
	}()

	private let testView: UIView = {
		let view = UIView()
		view.backgroundColor = .yellow
		view.layer.cornerRadius = 20
		view.clipsToBounds = true
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	@objc func buttonAction() {
		navigationController?.pushViewController(LaunchesViewController(), animated: true)
	}

	private var myButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Kočka"
		navigationController?.navigationBar.prefersLargeTitles = true

		view.layer.backgroundColor = UIColor.systemRed.cgColor

		view.addSubview(self.testView)

		view.addSubview(self.goNextButton)

		self.goNextButton.center(in: self.view)

		// Initialize the button
		self.myButton = UIButton(type: .system)
		self.myButton.setTitle("Tap Me", for: .normal)

		// Set the target and action
		self.myButton.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)

		// Add the button to the view
		self.view.addSubview(self.myButton)

		// Use auto layout to center the button
		self.myButton.translatesAutoresizingMaskIntoConstraints = false
		self.myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		self.myButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
	}
}

extension UIView {
	func centerTop() {
		translatesAutoresizingMaskIntoConstraints = false
		widthAnchor.constraint(equalToConstant: superview!.frame.width).isActive = true
		heightAnchor.constraint(equalToConstant: 150).isActive = true
		centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
		topAnchor.constraint(equalTo: superview!.topAnchor, constant: 0).isActive = true
	}
}

// MARK: - ------------------------------------------------------------------

public protocol LayoutAnchorContainer {
	var leadingAnchor: NSLayoutXAxisAnchor { get }
	var trailingAnchor: NSLayoutXAxisAnchor { get }
	var leftAnchor: NSLayoutXAxisAnchor { get }
	var rightAnchor: NSLayoutXAxisAnchor { get }
	var topAnchor: NSLayoutYAxisAnchor { get }
	var bottomAnchor: NSLayoutYAxisAnchor { get }
	var widthAnchor: NSLayoutDimension { get }
	var heightAnchor: NSLayoutDimension { get }
	var centerXAnchor: NSLayoutXAxisAnchor { get }
	var centerYAnchor: NSLayoutYAxisAnchor { get }

	var anchorContainerView: UIView? { get }
}

public struct EdgeConstraints {
	public let top: NSLayoutConstraint
	public let leading: NSLayoutConstraint
	public let bottom: NSLayoutConstraint
	public let trailing: NSLayoutConstraint

	public var all: [NSLayoutConstraint] {
		[self.top, self.leading, self.bottom, self.trailing]
	}
}

public struct EdgeConstraintPriorities {
	public let top: UILayoutPriority?
	public let leading: UILayoutPriority?
	public let bottom: UILayoutPriority?
	public let trailing: UILayoutPriority?

	public init(
		top: UILayoutPriority? = nil,
		leading: UILayoutPriority? = nil,
		bottom: UILayoutPriority? = nil,
		trailing: UILayoutPriority? = nil
	) {
		self.top = top
		self.leading = leading
		self.bottom = bottom
		self.trailing = trailing
	}

	public var all: [UILayoutPriority?] {
		[self.top, self.leading, self.bottom, self.trailing]
	}
}

public extension LayoutAnchorContainer {
	@discardableResult
	func pin(
		to container: LayoutAnchorContainer,
		insets: UIEdgeInsets = .zero,
		priorities: EdgeConstraintPriorities = EdgeConstraintPriorities()
	) -> EdgeConstraints {
		self.anchorContainerView?.translatesAutoresizingMaskIntoConstraints = false

		let constraints = EdgeConstraints(
			top: self.topAnchor.constraint(
				equalTo: container.topAnchor,
				constant: insets.top
			),
			leading: self.leadingAnchor.constraint(
				equalTo: container.leadingAnchor,
				constant: insets.left
			),
			bottom: container.bottomAnchor.constraint(
				equalTo: self.bottomAnchor,
				constant: insets.bottom
			),
			trailing: container.trailingAnchor.constraint(
				equalTo: self.trailingAnchor,
				constant: insets.right
			)
		)

		for (constraint, priority) in zip(constraints.all, priorities.all) {
			if let priority = priority {
				constraint.priority = priority
			}
		}

		NSLayoutConstraint.activate(constraints.all)
		return constraints
	}

	func center(in container: LayoutAnchorContainer) {
		self.anchorContainerView?.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.centerXAnchor.constraint(equalTo: container.centerXAnchor),
			self.centerYAnchor.constraint(equalTo: container.centerYAnchor),
			self.widthAnchor.constraint(lessThanOrEqualTo: container.widthAnchor),
			self.heightAnchor.constraint(lessThanOrEqualTo: container.heightAnchor)
		])
	}

	func setSize(_ size: CGSize) {
		self.anchorContainerView?.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.widthAnchor.constraint(equalToConstant: size.width),
			self.heightAnchor.constraint(equalToConstant: size.height)
		])
	}
}

extension UILayoutGuide: LayoutAnchorContainer {
	public var anchorContainerView: UIView? { nil }
}

extension UIView: LayoutAnchorContainer {
	public var anchorContainerView: UIView? { self }
}

public extension UIView {
	@discardableResult
	func addAndPinSubview(
		_ subview: UIView,
		insets: UIEdgeInsets = .zero,
		priorities: EdgeConstraintPriorities = EdgeConstraintPriorities()
	) -> EdgeConstraints {
		self.addSubview(subview)
		return subview.pin(to: self, insets: insets, priorities: priorities)
	}
}
