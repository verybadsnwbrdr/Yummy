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
		view.presenter = MainPresenter(view: view, networkService: networkService)
		return view
	}
}
