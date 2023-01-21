//
//  DetailAssembly.swift
//  Вкусно?
//
//  Created by Anton on 20.01.2023.
//

import Foundation

struct DetailAssembly {
	static func build(id: String, with networkService: NetworkType) -> DetailView {
		let view = DetailViewController()
		view.presenter = DetailPresenter(itemID: id, view: view, networkService: networkService)
		return view
	}
}
