//
//  MainModel.swift
//  Вкусно?
//
//  Created by Anton on 19.01.2023.
//

import Foundation

struct MainModel {
	let uuid: String
	let name: String
	let description: String?
	let images: [String]
	var imageData: Data?
}
