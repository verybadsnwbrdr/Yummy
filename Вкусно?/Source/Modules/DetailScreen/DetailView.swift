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
			updateStack(with: recipe?.difficulty)
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
		generateStars()
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
	
	private func fetchRecipe() {
		self.presenter.fetchItem(with: id)
	}
}

// MARK: - Metric

fileprivate extension CGFloat {
	static let horizontalOffset: CGFloat = 20
	static var horizontalInset: CGFloat { -horizontalOffset }
	
	static let verticalOffset: CGFloat = 10
	static var verticalInset: CGFloat { -verticalOffset }
	
	static let imageMultiplier: CGFloat = 0.8
	static let starsMultiplier: CGFloat = 6
	static let starsHeight: CGFloat = 20
}

// MARK: - Difficulty of Recipe

private extension DetailViewController {
	
	func createStarView() -> UIImageView {
		let star = UIImageView()
		star.image = UIImage(named: "star.fill")
		star.contentMode = .scaleAspectFit
		star.translatesAutoresizingMaskIntoConstraints = false
		return star
	}
	
	func generateStars() {
		for _ in 0 ..< 5 {
			let view = createStarView()
			stackView.addArrangedSubview(view)
		}
	}
	
	func updateStack(with difficulty: Int?) {
		guard let difficulty = difficulty else { return }
		stackView.arrangedSubviews.enumerated().forEach {
			$0.element.tintColor = $0.offset < difficulty ? .orange : .gray
		}
	}
}

// MARK: - Layout

private extension DetailViewController {
	func setupLayout() {
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			
			recipeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .horizontalOffset),
			recipeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .horizontalInset),
			recipeImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
			recipeImage.heightAnchor.constraint(equalTo: recipeImage.widthAnchor, multiplier: .imageMultiplier),
			
			nameLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: .verticalOffset),
			nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .horizontalOffset),
			nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .horizontalInset),
			
			stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .verticalOffset),
			stackView.heightAnchor.constraint(lessThanOrEqualToConstant: .starsHeight),
			stackView.widthAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: .starsMultiplier),
			stackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

			descriptionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: .verticalOffset),
			descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
			descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

			instructionsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: .horizontalOffset),
			instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .horizontalOffset),
			instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .horizontalInset),
			instructionsLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: .horizontalInset)
		])
	}
}
