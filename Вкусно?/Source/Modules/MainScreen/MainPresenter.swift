//
//  MainPresenter.swift
//  Вкусно?
//
//  Created by Anton on 19.01.2023.
//

import Foundation

protocol MainViewPresenter {
	init(view: MainView, networkService: NetworkInterface)
	func fetchItems()
}

final class MainPresenter: MainViewPresenter {
	
	private weak var view: MainView?
	private let networkService: NetworkInterface
	private var items: [Recipe] = []
	
	// MARK: - Initializer
	
	init(view: MainView, networkService: NetworkInterface) {
		self.view = view
		self.networkService = networkService
	}
	
	// MARK: - Methods
	
	func fetchItems() {
		networkService.fetchRecipes { [weak self] recipes in
			self?.view?.reloadTableView(with: recipes.recipes)
		}
	}
}
