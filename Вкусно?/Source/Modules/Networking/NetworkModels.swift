//
//  NetworkModels.swift
//  Вкусно?
//
//  Created by Anton on 20.01.2023.
//

import Foundation

struct Recipes: Decodable {
	let recipes: [Recipe]
}

struct Recipe: Decodable {
	let uuid: String
	let name: String
	let images: [String]
	let lastUpdated: Int
	let description: String?
	let instructions: String
	let difficulty: Int
	let similar: [Similar]?
}

extension Recipe {
	struct Similar: Decodable {
		let uuid: String
		let name: String
		let image: String
	}
}
