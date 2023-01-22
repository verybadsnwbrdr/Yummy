//
//  CacheManager.swift
//  Вкусно?
//
//  Created by Anton on 21.01.2023.
//

import Foundation

protocol CacheManagerType: AnyObject {
	func data(for url: URL) -> NSData?
	func insertData(_ image: NSData?, for url: URL)
}

final class CacheManager: CacheManagerType {
	private let imageCache = NSCache<AnyObject, AnyObject>()
	
	func insertData(_ image: NSData?, for url: URL) {
		guard let image = image else { return }
		imageCache.setObject(image, forKey: url as AnyObject)
	}
	
	func data(for url: URL) -> NSData? {
		if let image = imageCache.object(forKey: url as AnyObject) as? NSData {
			return image
		}
		return nil
	}
}
