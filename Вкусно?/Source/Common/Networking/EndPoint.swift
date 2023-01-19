//
//  EndPoint.swift
//  Вкусно?
//
//  Created by Anton on 19.01.2023.
//

import Foundation

extension NetworkService {
	enum EndPoint {
		
		case recipes
		case recipeWithID(String)
		
		var stringURL: URL? {
			return URL(string: Self.base + fullPath)
		}
		
		// MARK: - Private Properties
		
		private static let base = "https://test.kode-t.ru/"
		private var fullPath: String {
			switch self {
			case .recipes:
				return "recipes"
			case .recipeWithID(let id):
				return "recipes/" + id
			}
		}
	}
}
