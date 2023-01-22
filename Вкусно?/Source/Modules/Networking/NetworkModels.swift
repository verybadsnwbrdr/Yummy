//
//  NetworkModels.swift
//  Вкусно?
//
//  Created by Anton on 20.01.2023.
//

struct Recipes: Decodable {
	let recipes: [Recipe]
}

struct Recipe: Decodable {
	let uuid: String
	let name: String
	let images: [String]
	let description: String?
	let instructions: String
	let difficulty: Int
}
