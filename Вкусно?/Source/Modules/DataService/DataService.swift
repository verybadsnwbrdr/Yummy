//
//  DataService.swift
//  Вкусно?
//
//  Created by Anton on 23.01.2023.
//

import Foundation

protocol DataServiceType {
	//	func getItem<T: Decodable>(endPointURL: EndPoint, expecting: T)
	//	func getImage(endPointURL: EndPoint, complitionHandler: @escaping (Result<Data, NetworkError>) -> ())
	func getItem<T: Decodable>(endPointURL: EndPoint, complitionHandler: @escaping (T) -> ())
	func getImage(endPointURL: EndPoint, complitionHandler: @escaping (Data) -> ())
}

final class DataService: DataServiceType {
	
	
	
	private let networkService: NetworkServiceType
	//	private weak var presenter:
	
	init(networkService: NetworkServiceType) {
		self.networkService = networkService
	}
	
	func getItem<T: Decodable>(endPointURL: EndPoint, complitionHandler: @escaping (T) -> ()) {
		networkService.fetchItem(endPointURL: endPointURL) { [weak self] (result: Result<T, NetworkError>) in
			switch result {
			case .success(let data):
				complitionHandler(data)
			case .failure(_):
				let data = self?.getFromCoreData()
				complitionHandler(data)
			}
		}
	}
	
	func getImage(endPointURL: EndPoint, complitionHandler: @escaping (Data) -> ()) {
		networkService.fetchImage(endPointURL: endPointURL) { [weak self] result in
			switch result {
			case .success(let data):
				complitionHandler(data)
			case .failure(_):
				let data = self?.getFromCoreData()
				complitionHandler(data)
			}
		}
	}
	
	
	private func fetchImage(endPointURL: EndPoint) {
		networkService.fetchImage(endPointURL: endPointURL) { result in
			
		}
	}
	
	private func fetchItem<T: Decodable>(endPointURL: EndPoint, expecting: T) {
		networkService.fetchItem(endPointURL: endPointURL) { (result: Result<T, NetworkError>) in
			
		}
	}
	
	private func getFromCoreData<T>() -> T {
		
	}
	
//	private func get
}
