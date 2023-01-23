//
//  NetworkService.swift
//  Вкусно?
//
//  Created by Anton on 19.01.2023.
//

import Foundation

protocol NetworkServiceType: AnyObject {
	init(cacheManager: CacheManagerType)
	func fetchItem<T: Decodable>(endPointURL: EndPoint, complitionHandler: @escaping (Result<T, NetworkError>) -> ())
	func fetchImage(endPointURL: EndPoint, complitionHandler: @escaping (Result<Data, NetworkError>) -> ())
}

final class NetworkService: NetworkServiceType {
	
	// MARK: - Properties
	
	private var cacheManager: CacheManagerType
	
	// MARK: - Initializer
	
	init(cacheManager: CacheManagerType) {
		self.cacheManager = cacheManager
	}
	
	// MARK: - Private Methods
	
	private func dataTask(url: URL?, complitionHandler: @escaping (Result<Data, NetworkError>) -> ()) {
		guard let url = url else {
			complitionHandler(.failure(.incorrectURL))
			return
		}
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data = data else {
				if error != nil {
					complitionHandler(.failure(.connetionProblems))
				} else {
					complitionHandler(.failure(.incorrectData))
				}
				return
			}
			complitionHandler(.success(data))
		}
		task.resume()
	}
}

// MARK: - NetworkServiceType Implementation

extension NetworkService {
	func fetchItem<T: Decodable>(endPointURL: EndPoint,
								 complitionHandler: @escaping (Result<T, NetworkError>) -> ()) {
		dataTask(url: endPointURL.url) { result in
			switch result {
			case  .failure(let error):
				complitionHandler(.failure(error))
			case let .success(data):
				do {
					let decoded = try JSONDecoder().decode(T.self, from: data)
					complitionHandler(.success(decoded))
				} catch {
					complitionHandler(.failure(.encodingFailed))
				}
			}
		}
	}
	
	func fetchImage(endPointURL: EndPoint,
					complitionHandler: @escaping (Result<Data, NetworkError>) -> ()) {
		dataTask(url: endPointURL.url) { result in
			complitionHandler(result)
		}
	}
}
