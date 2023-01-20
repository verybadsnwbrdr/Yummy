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
		networkService.fetchRecipes(endPointURL: .recipeWithID(id)) { [weak self] (recipe: DetailModel) in
//			self?.item = recipe
			self?.view?.recipe = recipe
		}
	}
}
