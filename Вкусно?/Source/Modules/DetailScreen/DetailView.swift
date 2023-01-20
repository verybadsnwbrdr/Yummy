//
//  DetailView.swift
//  Вкусно?
//
//  Created by Anton on 20.01.2023.
//

import UIKit

protocol DetailView: AnyObject {
	var recipe: DetailModel? { get set }
}

final class DetailViewController: UIViewController, DetailView {
	
	// MARK: - Properties
	
	var presenter: DetailViewPresenter!
	var id = String()
	var recipe: DetailModel? {
		didSet {
			let recipe = recipe?.recipe
			nameLabel.text = recipe?.name
			descriptionLabel.text = recipe?.description
			instructionsLabel.text = recipe?.instructions
			//			recipeImage.image = UIImage(data: recipe?.imageData ?? Data())
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
	
	private let stackView: UIStackView = {
		let arrangedSubviews = generateStars(difficulty: 3)
		let stack = UIStackView(arrangedSubviews: arrangedSubviews)
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		stack.spacing = 5
		return stack
	}()
	
	private let instructionsLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 16)
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}()
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		fetchRecipe()
		view.backgroundColor = .white
//		navigationController?.navigationBar.isHidden = true
		setupHierarchy()
		setupLayout()
	}
	
	// MARK: - Setup Controller
	
	private func setupHierarchy() {
		scrollView.addSubview(recipeImage)
		scrollView.addSubview(nameLabel)
		scrollView.addSubview(stackView)
		scrollView.addSubview(descriptionLabel)
		scrollView.addSubview(instructionsLabel)
		view.addSubview(scrollView)
	}
	
	private func setupLayout() {
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			
			recipeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .horizontalOffset),
			recipeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .horizontalInset),
			recipeImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
			recipeImage.heightAnchor.constraint(equalTo: recipeImage.widthAnchor, multiplier: 0.8),
			
			nameLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: .verticalOffset),
			nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .horizontalOffset),
			nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .horizontalInset),

			descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .verticalOffset),
			descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
			descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

			instructionsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: .horizontalOffset),
			instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .horizontalOffset),
			instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .horizontalInset),
			instructionsLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: .horizontalInset)
		])
	}
	
	private func fetchRecipe() {
		self.presenter.fetchItem(with: id)
	}
}

fileprivate extension CGFloat {
	static let horizontalOffset: CGFloat = 20
	static var horizontalInset: CGFloat { -horizontalOffset }
	
	static let verticalOffset: CGFloat = 10
	static var verticalInset: CGFloat { -verticalOffset }
	
	static let imageOffset: CGFloat = 30
	static var imageInset: CGFloat { -imageOffset }
}

private extension DetailViewController {
	
	func createStarView(with color: UIColor) -> UIImageView {
		let star = UIImageView()
		star.backgroundColor = .gray.withAlphaComponent(0.1)
		star.contentMode = .scaleToFill
		star.translatesAutoresizingMaskIntoConstraints = false
		return star
	}
	
//	func createStackView() -> UIStackView {
//		let stack = UIStackView()
//		stack.axis = .horizontal
//		stack.distribution = .fillEqually
//		stack.spacing = 5
//		return stack
//	}
	
	func generateStars(difficulty: Int) -> [UIView] {
		var views: [UIImageView] = []
		for i in 1...5 {
			var color: UIColor = i <= difficulty ? .yellow : .gray
			views.append(createStarView(with: color))
		}
		return views
	}
}
