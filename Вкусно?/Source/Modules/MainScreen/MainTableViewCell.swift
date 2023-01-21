//
//  MainTableViewCell.swift
//  Вкусно?
//
//  Created by Anton on 19.01.2023.
//

import UIKit

class MainTableViewCell: UITableViewCell {
	
	// MARK: - Identifier
	
	static var identifier: String { Self.self.description() }
	
	// MARK: Property
	
	var recipe: MainModel? {
		didSet {
			nameLabel.text = recipe?.name
			descriptionLabel.text = recipe?.description
			recipeImage.image = UIImage(data: recipe?.imageData ?? Data())
		}
	}
	
	// MARK: - Elements
	
	private let recipeImage: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = .gray.withAlphaComponent(0.1)
		imageView.contentMode = .scaleToFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.font = Fonts.tableHeader.semibold
		label.numberOfLines = 1
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = Fonts.tableBody.regular
		label.numberOfLines = 2
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	// MARK: - Initializer
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupHierarchy()
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup Cell
	
	private func setupHierarchy() {
		addSubview(recipeImage)
		addSubview(nameLabel)
		addSubview(descriptionLabel)
	}
	
	private func setupLayout() {
		NSLayoutConstraint.activate([
			recipeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .horizontalOffset),
			recipeImage.centerYAnchor.constraint(equalTo: centerYAnchor),
			recipeImage.topAnchor.constraint(equalTo: topAnchor, constant: .tableVerticalOffset),
			recipeImage.widthAnchor.constraint(equalTo: recipeImage.heightAnchor),
			
//			nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: .verticalOffset),
//			nameLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor), //, constant: .verticalInset
			nameLabel.topAnchor.constraint(equalTo: recipeImage.topAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: recipeImage.trailingAnchor, constant: .horizontalOffset),
			nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .horizontalInset),
			
//			descriptionLabel.topAnchor.constraint(lessThanOrEqualTo: nameLabel.bottomAnchor, constant: .verticalOffset),
//			descriptionLabel.topAnchor.constraint(lessThanOrEqualTo: recipeImage.topAnchor),
			descriptionLabel.bottomAnchor.constraint(equalTo: recipeImage.bottomAnchor),
			descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
			descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
		])
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		self.recipeImage.image = nil
		self.nameLabel.text = nil
		self.descriptionLabel.text = nil
	}
}

//// MARK: - Metric
//
fileprivate extension CGFloat {
//	static let horizontalOffset: CGFloat = 20
//	static var horizontalInset: CGFloat { -horizontalOffset }
	
	static let tableVerticalOffset: CGFloat = 5
	static var tableVerticalInset: CGFloat { -verticalOffset }
}
