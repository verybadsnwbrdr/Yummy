//
//  DetailPresenter.swift
//  Вкусно?
//
//  Created by Anton on 20.01.2023.
//

import Foundation

protocol DetailViewPresenter: AnyObject {
	init(itemID: String, view: DetailView, networkService: NetworkType)
	func fetchItem()
	func fetchImageData(with stringURL: String, complitionHandler: @escaping (Data) -> ())
}

final class DetailPresenter: DetailViewPresenter {
	
	private weak var view: DetailView?
	private let networkService: NetworkType
	private var itemID: String
	
	// MARK: - Initializer
	
	init(itemID: String, view: DetailView, networkService: NetworkType) {
		self.view = view
		self.networkService = networkService
		self.itemID = itemID
	}
	
	func fetchItem() {
		self.networkService.fetchItem(endPointURL: .recipeWithID(itemID)) { [weak self] (recipe: DetailModel) in
			self?.view?.recipe = recipe
		}
	}
	
	func fetchImageData(with stringURL: String, complitionHandler: @escaping (Data) -> ()) {
		self.networkService.fetchImage(stringURL: stringURL) { data in
			complitionHandler(data)
		}
	}
}
