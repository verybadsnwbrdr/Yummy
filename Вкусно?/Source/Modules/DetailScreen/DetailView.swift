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
	var recipe: DetailModel? {
		didSet {
			let recipe = recipe?.recipe
			
			collectionView.reloadData()
			detailSubView.setupStack(name: recipe?.name,
								 description: recipe?.description,
								 instructions: recipe?.instructions,
								 difficulty: recipe?.difficulty)
			
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
		pageControl.isEnabled = false
		pageControl.translatesAutoresizingMaskIntoConstraints = false
		return pageControl
	}()
	
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}()
	
	private let detailSubView = DetailSubView()
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		fetchRecipe()
		navigationItem.largeTitleDisplayMode = .never
		navigationController?.navigationBar.tintColor = .gray
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back",
														   style: .plain,
														   target: self,
														   action: #selector(back))
		view.backgroundColor = .white
		setupHierarchy()
		setupLayout()
	}
	
	// MARK: - Setup Controller
	
	private func setupHierarchy() {
		scrollView.addSubview(collectionView)
		scrollView.addSubview(pageControl)
		scrollView.addSubview(detailSubView)
		view.addSubview(scrollView)
	}
	
	// MARK: - Private Methods
	
	private func fetchRecipe() {
		self.presenter.fetchItem()
	}
	
	@objc func back() {
		navigationController?.popViewController(animated: true)
	}
}

// MARK: - DataSource

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

// MARK: - FlowLayout Delegate

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

// MARK: - Layout

private extension DetailViewController {
	func setupLayout() {
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .horizontalOffset),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .horizontalInset),
			collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: .imageMultiplier),
			
			pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: .verticalInset),
			
			detailSubView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: .verticalOffset),
			detailSubView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .horizontalOffset),
			detailSubView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .horizontalInset),
			detailSubView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
		])
	}
}
