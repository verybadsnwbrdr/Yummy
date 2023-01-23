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
		let networkService = NetworkService(cacheManager: cacheManager)
		let dataService = DataService(networkService: networkService)
		view.presenter = MainPresenter(view: view, dataService: dataService)
		return view
	}
}
