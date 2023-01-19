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
	
	var recipe: Recipe? {
		didSet {
			nameLabel.text = recipe?.name
			descriptionLabel.text = recipe?.description
			
			// TODO: - DEPRECATE
			NetworkService().fetchImage(stringURL: recipe?.images[0] ?? "") { [unowned self] in
				recipeImage.image = UIImage(data: $0)
			}
		}
	}
	
	// MARK: - Elements
	
	private var recipeImage: UIImageView = {
		let imageView = UIImageView()
		imageView.tintColor = .red
		imageView.contentMode = .scaleToFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	private var nameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		label.numberOfLines = 1
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private var descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14)
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
			recipeImage.topAnchor.constraint(equalTo: topAnchor, constant: .verticalOffset),
//			recipeImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .horizontalInset),
			recipeImage.widthAnchor.constraint(equalTo: recipeImage.heightAnchor),
//			recipeImage.widthAnchor.constraint(equalToConstant: 40),
			
			nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: .verticalOffset),
//			nameLabel.bottomAnchor.constraint(equalTo: centerYAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: recipeImage.trailingAnchor, constant: .horizontalOffset),
			nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .horizontalInset),
			
			descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .verticalOffset),
			descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .verticalInset),
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

private extension CGFloat {
	static let horizontalOffset: CGFloat = 20
	static var horizontalInset: CGFloat { -horizontalOffset }
	
	static let verticalOffset: CGFloat = 5
	static var verticalInset: CGFloat { -verticalOffset }
}
