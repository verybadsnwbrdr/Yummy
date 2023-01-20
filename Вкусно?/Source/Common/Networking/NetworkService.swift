//
//  NetworkService.swift
//  Вкусно?
//
//  Created by Anton on 19.01.2023.
//

import Foundation

protocol NetworkInterface {
//	func fetchRecipes(endPointURL: EndPoint, complitionHandler: @escaping (Recipes) -> ())
//	func fetchRecipes(endPointURL: EndPoint, complitionHandler: @escaping (Recipe) -> ())
	func fetchRecipes<T: Decodable>(endPointURL: EndPoint, complitionHandler: @escaping (T) -> ())
	func fetchImages(stringURLs: [String], complitionHandler: @escaping (Data) -> ())
	func fetchImage(stringURL: String, complitionHandler: @escaping (Data) -> ())
}

final class NetworkService: NetworkInterface {
	
	func fetchRecipes<T: Decodable>(endPointURL: EndPoint, complitionHandler: @escaping (T) -> ()) {
		guard let url = endPointURL.stringURL else { return }
		dataTask(url: url) { data in
			do {
				let decoded = try JSONDecoder().decode(T.self, from: data)
				DispatchQueue.main.async {
					complitionHandler(decoded)
				}
			} catch {
				print(error.localizedDescription)
			}
		}
	}
	
	func fetchImages(stringURLs: [String],
					complitionHandler: @escaping (Data) -> ()) {
		for stringURL in stringURLs {
			fetchImage(stringURL: stringURL) { data in
				complitionHandler(data)
			}
//			guard let url = URL(string: stringURL) else { return }
//			dataTask(url: url) { data in
//				do {
//					let data = try Data(contentsOf: url)
//					DispatchQueue.main.async {
//						complitionHandler(data)
//					}
//				} catch {
//					print(error.localizedDescription)
//				}
//			}
		}
	}
	
	func fetchImage(stringURL: String,
					complitionHandler: @escaping (Data) -> ()) {
		guard let url = URL(string: stringURL) else { return }
		dataTask(url: url) { data in
			DispatchQueue.main.async {
				complitionHandler(data)
			}
		}
	}
	
	// MARK: - Private Methods
	
	private func dataTask(url: URL, complitionHandler: @escaping (Data) -> ()) {
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data else { return }
			complitionHandler(data)
		}
		task.resume()
	}
}


