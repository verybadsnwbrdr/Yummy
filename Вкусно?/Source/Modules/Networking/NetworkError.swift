//
//  NetworkError.swift
//  Вкусно?
//
//  Created by Anton on 23.01.2023.
//

import Foundation

enum NetworkError: Error {
	case encodingFailed
	case connetionProblems
	case incorrectURL
	case incorrectData
}
