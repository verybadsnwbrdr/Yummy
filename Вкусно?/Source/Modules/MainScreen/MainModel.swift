//
//  MainModel.swift
//  Вкусно?
//
//  Created by Anton on 19.01.2023.
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
	//	let similar: [Similar]
}

extension Recipe {
	struct Similar: Decodable {
		let uuid: String
		let name: String
		let image: String
	}
}

extension Recipe {
	static let mock: Recipe =
	Recipe(uuid: "fc988768-c1e9-11e6-a4a6-cec0c932ce01",
		   name: "Pan Roasted Chicken with Lemon, Garlic, Green Beans and Red Potatoes",
		   images: ["star.fill",
					"https://bigoven-res.cloudinary.com//image//upload//w_300,c_fill,h_250//pan-roasted-chicken-with-lemon-garl-12.jpg"],
		   lastUpdated: 524224800,
		   description: "Pan-roasted chicken with lemon, garlic, green beans and red potatoes",
		   instructions: "1. Preheat the oven to 230deg C. Coat a large baking dish or cast-iron skillet with 1 tbs of olive oil. Arrange the lemon slices in a single layer in the bottom of the dish or skillet.<br>2. In a large bowl, combine the remaining oil, lemon juice, garlic, salt and pepper; add the green beans and toss to coat. Using a slotted spoon or tongs, remove the green beans and arrange them on top of the lemon slices. Add the potatoes to the same olive oil mixture and toss to coat. Using a slotted spoon or tongs, arrange the potatoes along the inside edge of the dish or skillet on top of the green beans. Place the chicken in the same bowl with the olive oil mixture and coat thoroughly. Place the chicken, skin side up, in the dish or skillet. Pour any remaining olive oil mixture over the chicken.<br>3. Roast for 50 minutes. Remove the chicken from the dish or skillet. Place the beans and potatoes back in the oven for 10 minutes more or until the potatoes are tender.<br>4. Place a chicken breast on each of 4 serving plates; divide the green beans and potatoes equally. Serve warm.",
		   difficulty: 3)
}
