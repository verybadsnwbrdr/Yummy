//
//  MainPresenter.swift
//  Вкусно?
//
//  Created by Anton on 19.01.2023.
//

import Foundation

protocol MainViewPresenter: AnyObject {
	init(view: MainView, networkService: NetworkInterface)
	func fetchItems()
	func itemForRow(at index: Int) -> MainModel
	func numberOfItems() -> Int
	func fetchImageData(for row: Int, complitionHandler: @escaping (Data) -> ())
	
	func createDetailView(for row: Int) -> DetailView
}

final class MainPresenter: MainViewPresenter {
	
	private weak var view: MainView?
	private let networkService: NetworkInterface
	private var items: [MainModel] = []
	
	// MARK: - Initializer
	
	init(view: MainView, networkService: NetworkInterface) {
		self.view = view
		self.networkService = networkService
	}
	
	// MARK: - Methods
	
	func fetchItems() {
		networkService.fetchRecipes(endPointURL: .recipes) { [weak self] (recipes: Recipes) in
			self?.items = recipes.recipes.map { MainModel(uuid: $0.uuid,
														  name: $0.name,
														  description: $0.description,
														  images: $0.images) }
			self?.view?.updateTableView()
		}
	}
	
	func itemForRow(at index: Int) -> MainModel {
		items[index]
	}
	
	func numberOfItems() -> Int {
		items.count
	}
	
	func fetchImageData(for row: Int, complitionHandler: @escaping (Data) -> ()) {
		guard let stringURL = items[row].images.first else { return }
		networkService.fetchImage(stringURL: stringURL) { data in
			complitionHandler(data)
		}
	}
	
	func createDetailView(for row: Int) -> DetailView {
		let model = items[row]
		return DetailAssembly.build(id: model.uuid, with: self.networkService)
	}
}
