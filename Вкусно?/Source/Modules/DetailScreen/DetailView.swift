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
			
			collectionView.reloadData()
			stackView.setupStack(name: recipe?.name,
								 description: recipe?.description,
								 instructions: recipe?.instructions,
								 difficulty: recipe?.difficulty)
//			nameLabel.text = recipe?.name
//			descriptionLabel.text = recipe?.description
//			instructionsLabel.text = recipe?.instructions
//			showStars(with: recipe?.difficulty)
			
			if let numberOfPages = recipe?.images.count, numberOfPages > 1 {
				pageControl.numberOfPages = numberOfPages
			}
		}
	}
	
	// MARK: - Elements
	
	private lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	private let pageControl: UIPageControl = {
		let pageControl = UIPageControl()
		pageControl.translatesAutoresizingMaskIntoConstraints = false
		return pageControl
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
	
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}()
	
	private let stackView = DetailSubView()
	
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
//		scrollView.addSubview(recipeImage)
		scrollView.addSubview(collectionView)
		scrollView.addSubview(pageControl)
		scrollView.addSubview(stackView)
//		scrollView.addSubview(nameLabel)
//		scrollView.addSubview(starsStackView)
//		scrollView.addSubview(descriptionLabel)
//		scrollView.addSubview(instructionsLabel)
		view.addSubview(scrollView)
	}
	
	private func fetchRecipe() {
		self.presenter.fetchItem(with: id)
	}
}

// MARK: - Difficulty of Recipe

private extension DetailViewController {
	
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

// MARK: - Layout

private extension DetailViewController {
	func setupLayout() {
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			
//			recipeImage.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
//			recipeImage.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
//			recipeImage.topAnchor.constraint(equalTo: collectionView.topAnchor),
//			recipeImage.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
			
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .horizontalOffset),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .horizontalInset),
			collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: .imageMultiplier),
			
			pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: .verticalInset),
			
			stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: .verticalOffset),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .horizontalOffset),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .horizontalInset),
			stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: .verticalInset)
			
//			nameLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: .verticalOffset),
////			nameLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: .verticalOffset),
//			nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .horizontalOffset),
//			nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .horizontalInset),
//
//			starsStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .verticalOffset),
//			starsStackView.heightAnchor.constraint(lessThanOrEqualToConstant: .starsHeight),
//			starsStackView.widthAnchor.constraint(equalTo: starsStackView.heightAnchor, multiplier: .starsMultiplier),
//			starsStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
//
//			descriptionLabel.topAnchor.constraint(equalTo: starsStackView.bottomAnchor, constant: .verticalOffset),
//			descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
//			descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
//
//			instructionsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: .horizontalOffset),
//			instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .horizontalOffset),
//			instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .horizontalInset),
//			instructionsLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: .horizontalInset)
		])
	}
}

// MARK: - Delegates

extension DetailViewController: UICollectionViewDataSource {
	private func createRecipeImage(with frame: CGRect) -> UIImageView {
		let recipeImage = UIImageView(frame: frame)
		recipeImage.backgroundColor = .gray.withAlphaComponent(0.1)
		recipeImage.contentMode = .scaleToFill
		recipeImage.layer.cornerRadius = 5
		recipeImage.clipsToBounds = true
		return recipeImage
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.recipe?.recipe.images.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
		let recipeImage = createRecipeImage(with: cell.bounds)
		cell.addSubview(recipeImage)
		if let stringURL = recipe?.recipe.images[indexPath.item] {
			self.presenter.fetchImageData(with: stringURL) { data in
				recipeImage.image = UIImage(data: data)
			}
		}
		return cell
	}
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: collectionView.frame.width,
			   height: collectionView.frame.height)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
		let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
		if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
			self.pageControl.currentPage = visibleIndexPath.row
		}
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
