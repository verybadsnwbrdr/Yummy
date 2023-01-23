//
//  DetailPresenter.swift
//  Вкусно?
//
//  Created by Anton on 20.01.2023.
//

import Foundation

protocol DetailViewPresenter: AnyObject {
	init(itemID: String, view: DetailView, dataService: DataServiceType)
	func fetchItem()
	func fetchImageData(with stringURL: String, complitionHandler: @escaping (Data) -> ())
}

final class DetailPresenter: DetailViewPresenter {
	
	// MARK: - Properties
	
	private weak var view: DetailView?
//	private let networkService: NetworkServiceType
	private let dataService: DataServiceType
	private var itemID: String
	
	// MARK: - Initializer
	
	init(itemID: String, view: DetailView, dataService: DataServiceType) {
		self.view = view
		self.dataService = dataService
		self.itemID = itemID
	}
	
	// MARK: - DetailViewPresenter Implementation
	
	func fetchItem() {
		dataService.getItem(endPointURL: .recipeWithID(itemID)) { [weak self] (recipe: DetailModel) in
			DispatchQueue.main.async {
				self?.view?.recipe = recipe
			}
		}
	}
	
	func fetchImageData(with stringURL: String, complitionHandler: @escaping (Data) -> ()) {
		dataService.getImage(endPointURL: .image(stringURL)) { data in
			DispatchQueue.main.async {
				complitionHandler(data)
			}
		}
	}
}
