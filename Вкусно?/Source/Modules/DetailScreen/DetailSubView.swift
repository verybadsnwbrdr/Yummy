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
		descriptionLabel.text = description
		instructionsLabel.text = instructions
		showStars(with: difficulty)
	}

	// MARK: - Elements
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 16)
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
	
	private let instructionsLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 16)
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
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
		addSubview(descriptionLabel)
		addSubview(starsStackView)
		addSubview(instructionsLabel)
	}
	
	private func setupLayout() {
		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(equalTo: topAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

			starsStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
			starsStackView.heightAnchor.constraint(lessThanOrEqualToConstant: 15),
			starsStackView.widthAnchor.constraint(equalTo: starsStackView.heightAnchor, multiplier: 6),
			starsStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

			descriptionLabel.topAnchor.constraint(equalTo: starsStackView.bottomAnchor, constant: 5),
			descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

			instructionsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
			instructionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			instructionsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
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
