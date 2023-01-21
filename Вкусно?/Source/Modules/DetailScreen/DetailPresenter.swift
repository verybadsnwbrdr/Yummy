//
//  DetailPresenter.swift
//  Вкусно?
//
//  Created by Anton on 20.01.2023.
//

import Foundation

protocol DetailViewPresenter: AnyObject {
	init(view: DetailView, networkService: NetworkInterface)
	func fetchItem(with id: String)
	func fetchImages(strings: [String], complitionHandler: @escaping (Data) -> ())
	func fetchImageData(with stringURL: String, complitionHandler: @escaping (Data) -> ())
}

final class DetailPresenter: DetailViewPresenter {
	
	private weak var view: DetailView?
	private let networkService: NetworkInterface
//	private var item: DetailModel?
	
	// MARK: - Initializer
	
	init(view: DetailView, networkService: NetworkInterface) {
		self.view = view
		self.networkService = networkService
	}
	
	func fetchItem(with id: String) {
		self.networkService.fetchRecipes(endPointURL: .recipeWithID(id)) { [weak self] (recipe: DetailModel) in
//			self?.item = recipe
			self?.view?.recipe = recipe
		}
	}
	
	func fetchImages(strings: [String], complitionHandler: @escaping (Data) -> ()) {
		self.networkService.fetchImages(stringURLs: strings) { data in
			complitionHandler(data)
		}
	}
	
	func fetchImageData(with stringURL: String, complitionHandler: @escaping (Data) -> ()) {
		self.networkService.fetchImage(stringURL: stringURL) { data in
			complitionHandler(data)
		}
	}
}
