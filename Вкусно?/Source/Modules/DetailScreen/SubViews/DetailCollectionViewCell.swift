//
//  DetailCollectionViewCell.swift
//  Вкусно?
//
//  Created by Anton on 22.01.2023.
//

import UIKit

final class DetailCollectionViewCell: UICollectionViewCell {
    
	// MARK: - Identidifier
	
	static let identifier = DetailCollectionViewCell.description()
	
	// MARK: - Properties
	
	var imageView: UIImage? {
		didSet {
			recipeImage.image = imageView
		}
	}
	
	// MARK: - Elements
	
	private let recipeImage: UIImageView = {
		let recipeImage = UIImageView()
		recipeImage.backgroundColor = .gray.withAlphaComponent(0.1)
		recipeImage.contentMode = .scaleToFill
		recipeImage.layer.cornerRadius = 5
		recipeImage.clipsToBounds = true
		return recipeImage
	}()
	
	// MARK: - Initializers
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		recipeImage.frame = self.bounds
		addSubview(recipeImage)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Prepare For Reuse

	override func prepareForReuse() {
		recipeImage.image = nil
	}
}
