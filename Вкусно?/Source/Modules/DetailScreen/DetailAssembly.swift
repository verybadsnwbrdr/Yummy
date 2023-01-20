//
//  DetailAssembly.swift
//  Вкусно?
//
//  Created by Anton on 20.01.2023.
//

import Foundation

struct DetailAssembly {
	static func build(id: String, with networkService: NetworkInterface) -> DetailView {
		let view = DetailViewController()
//		view.recipe?.uuid = id
		view.id = id
		view.presenter = DetailPresenter(view: view, networkService: networkService)
		return view
	}
}
