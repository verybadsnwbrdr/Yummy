//
//  MainAssembly.swift
//  Вкусно?
//
//  Created by Anton on 20.01.2023.
//

import Foundation

struct MainAssembly {
	static func build() -> MainViewController {
		let view = MainViewController()
		let dataManager = DataManager()
		let networkService = NetworkService(dataManager: dataManager)
		view.presenter = MainPresenter(view: view, networkService: networkService)
		return view
	}
}
