//
//  NetworkService.swift
//  Вкусно?
//
//  Created by Anton on 19.01.2023.
//

import Foundation

protocol NetworkInterface {
	func fetchRecipes(complitionHandler: @escaping (Recipes) -> ())
	func fetchImages(stringURLs: [String], complitionHandler: @escaping (Data) -> ())
}

final class NetworkService: NetworkInterface {
	func fetchRecipes(complitionHandler: @escaping (Recipes) -> ()) {
		guard let url = EndPoint.recipes.stringURL else { return }
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data else { return }
			do {
				let decoded = try JSONDecoder().decode(Recipes.self, from: data)
				DispatchQueue.main.async {
					complitionHandler(decoded)
				}
			} catch {
				print(error.localizedDescription)
			}
			
		}.resume()
	}
	
	func fetchImages(stringURLs: [String],
					complitionHandler: @escaping (Data) -> ()) {
		for stringURL in stringURLs {
			guard let url = URL(string: stringURL) else { return }
			do {
				let data = try Data(contentsOf: url)
				DispatchQueue.main.async {
					complitionHandler(data)
				}
			} catch {
				print(error.localizedDescription)
			}
		}
	}
	
	func fetchImage(stringURL: String,
					complitionHandler: @escaping (Data) -> ()) {
		guard let url = URL(string: stringURL) else { return }
		DispatchQueue.global(qos: .userInitiated).async {
			do {
				let data = try Data(contentsOf: url)
				DispatchQueue.main.async {
					complitionHandler(data)
				}
			} catch {
				print(error.localizedDescription)
			}
		}
	}
}


