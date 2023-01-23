//
//  EndPoint.swift
//  Вкусно?
//
//  Created by Anton on 19.01.2023.
//

import Foundation

enum EndPoint {
	
	case recipes
	case recipeWithID(String)
	case image(String)
	
	var url: URL? {
		URL(string: fullPath)
	}
	
	// MARK: - Private Properties
	
	private static let base = "https://test.kode-t.ru/"
	private var fullPath: String {
		switch self {
		case .recipes:
			return Self.base + "recipes"
		case .recipeWithID(let id):
			return Self.base +  "recipes/" + id
		case .image(let url):
			return url
		}
	}
}
