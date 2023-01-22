//
//  MainAssembly.swift
//  Вкусно?
//
//  Created by Anton on 20.01.2023.
//

struct MainAssembly {
	static func build() -> MainViewController {
		let view = MainViewController()
		let cacheManager = CacheManager()
		let dataManager = DataManager()
		let networkService = NetworkService(cacheManager: cacheManager, dataManager: dataManager)
		view.presenter = MainPresenter(view: view, networkService: networkService, dataManager: dataManager)
		return view
	}
}
