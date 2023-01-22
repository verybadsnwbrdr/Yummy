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
	
	var presenter: DetailViewPresenter?
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
		collectionView.register(DetailCollectionViewCell.self,
								forCellWithReuseIdentifier: DetailCollectionViewCell.description())
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
		setupController()
		setupHierarchy()
		setupLayout()
	}
	
	// MARK: - Setup Controller
	
	private func setupController() {
		fetchRecipe()
		navigationItem.largeTitleDisplayMode = .never
		navigationController?.navigationBar.tintColor = .gray
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: Images.backShewron.rawValue),
														   style: .plain,
														   target: self,
														   action: #selector(back))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
															target: self,
															action: #selector(activite))
		view.backgroundColor = .white
	}
	
	private func setupHierarchy() {
		scrollView.addSubview(collectionView)
		scrollView.addSubview(pageControl)
		scrollView.addSubview(detailSubView)
		view.addSubview(scrollView)
	}
	
	// MARK: - Private Methods
	
	private func fetchRecipe() {
		presenter?.fetchItem()
	}
	
	@objc private func back() {
		navigationController?.popViewController(animated: true)
	}

	@objc private func activite() {
		let currentIndex = self.pageControl.currentPage
		let indexPath = IndexPath(item: currentIndex, section: .zero)
		guard let cell = collectionView.cellForItem(at: indexPath) as? DetailCollectionViewCell,
			  let image = cell.imageView  else { return }
		let activityViewController = UIActivityViewController(activityItems: [image],
															  applicationActivities: nil)
		present(activityViewController, animated: true)
	}
	
}

// MARK: - DataSource

extension DetailViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		recipe?.recipe.images.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: DetailCollectionViewCell.description(),
			for: indexPath
		) as? DetailCollectionViewCell else { return UICollectionViewCell() }
		if let stringURL = recipe?.recipe.images[indexPath.item] {
			presenter?.fetchImageData(with: stringURL) { data in
				cell.imageView = UIImage(data: data)
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
			pageControl.currentPage = visibleIndexPath.row
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
