//
//  DetailCollectionView.swift
//  Вкусно?
//
//  Created by Anton on 21.01.2023.
//

import UIKit

final class DetailSubView: UIView {
	
	// MARK: - Setup Stack
	
	func setupStack(name: String?,
					description: String?,
					instructions: String?,
					difficulty: Int?) {
		nameLabel.text = name
		descriptionView.body = description
		instructionsView.body = instructions
		showStars(with: difficulty)
	}

	// MARK: - Elements
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.font = Fonts.header.bold
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let starsStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.alignment = .leading
		stack.distribution = .fillEqually
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	private let descriptionView = ViewWithHeader(header: Localization.description.rawValue)
	private let instructionsView = ViewWithHeader(header: Localization.instructions.rawValue)

	// MARK: - Initializers
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		translatesAutoresizingMaskIntoConstraints = false
		generateStars()
		setupHierarchy()
		setupLayout()
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup Controller
	
	private func setupHierarchy() {
		addSubview(nameLabel)
		addSubview(starsStackView)
		addSubview(descriptionView)
		addSubview(instructionsView)
	}
	
	private func setupLayout() {
		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(equalTo: topAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

			starsStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .verticalOffset),
			starsStackView.heightAnchor.constraint(lessThanOrEqualToConstant: .starsHeight),
			starsStackView.widthAnchor.constraint(equalTo: starsStackView.heightAnchor, multiplier: .starsMultiplier),
			starsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			
			descriptionView.topAnchor.constraint(equalTo: starsStackView.bottomAnchor, constant: .verticalOffset),
			descriptionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			descriptionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			instructionsView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: .verticalOffset),
			instructionsView.leadingAnchor.constraint(equalTo: leadingAnchor),
			instructionsView.trailingAnchor.constraint(equalTo: trailingAnchor),
			instructionsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .verticalInset)
		])
	}
}

private extension DetailSubView {
	
	func createStarView() -> UIImageView {
		let star = UIImageView()
		star.image = UIImage(named: "star.fill")
		star.tintColor = .gray
		star.contentMode = .scaleAspectFit
		star.translatesAutoresizingMaskIntoConstraints = false
		return star
	}
	
	func generateStars() {
		for _ in 0 ..< 5 {
			let view = createStarView()
			starsStackView.addArrangedSubview(view)
		}
	}
	
	func showStars(with difficulty: Int?) {
		guard let difficulty = difficulty else { return }
		starsStackView.arrangedSubviews.enumerated().forEach {
			$0.element.tintColor = $0.offset < difficulty ? .orange : .gray
		}
	}
}
