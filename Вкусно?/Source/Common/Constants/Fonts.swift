//
//  Fonts.swift
//  Вкусно?
//
//  Created by Anton on 21.01.2023.
//

import UIKit

enum Fonts: CGFloat {
	case header = 18
	case body = 16
	case tableHeader = 15
	case tableBody = 14
	
	var bold: UIFont { .systemFont(ofSize: rawValue, weight: .bold) }
	var semibold: UIFont { .systemFont(ofSize: rawValue, weight: .semibold) }
	var regular: UIFont { .systemFont(ofSize: rawValue) }
}
