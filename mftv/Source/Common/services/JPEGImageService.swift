//
//  JPEGImageService.swift
//  mftv
//
//  Created by Emiel Lensink on 22/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import Foundation
import UIKit
import QxKit

typealias JPEGCompletion = (image:UIImage?) -> ()

class JPEGImageQueue: KeyedQueue<JPEGCompletion> {
	static let sharedInstance = KeyedQueue<JPEGCompletion>()
	
	override init() {
		super.init()
	}
}

class JPEGImageService: BaseDataLoaderService {
	
	enum Size {
		case small
		case medium
		case large
	}
	
	var currentEndpoint = ""
	
	func loadImage(named named:String, size:Size, completion:JPEGCompletion) {
		
		var suffix = ""
		switch size {
		case .small:
			suffix = "_225.jpg"
		case .medium:
			suffix = "_450.jpg"
		case .large:
			suffix = "_2560.jpg"
		}
		
		currentEndpoint = "uploads/\(named)\(suffix)"
		let currentCacheKey = "CACHE_KEY_JPEGIMAGE_\(currentEndpoint)"
		let cache = ObjectCache.defaultCache
		
		let newQueue = JPEGImageQueue.sharedInstance.queueItem(item: completion, forKey:currentCacheKey)
		if !newQueue { print("JPEG image loading. Closure queued"); return }
		
		if let image = cache.objectForKey(currentCacheKey) as? UIImage {
			JPEGImageQueue.sharedInstance.processQueue(forKey: currentCacheKey, closure: { (item) -> () in
				item(image: image)
			})
		} else {
			super.request(response: { (data) -> () in
				//if let d = data {

					if let image = UIImage(data: data) {
						cache.setObject(image, forKey: currentCacheKey)

						JPEGImageQueue.sharedInstance.processQueue(forKey: currentCacheKey, closure: { (item) -> () in
							item(image: image)
						})
					}
					
//				} else {
//					JPEGImageQueue.sharedInstance.processQueue(forKey: currentCacheKey, closure: { (item) -> () in
//						item(image: nil)
//					})
//				}
//				
			}, failure: { (response, error) -> () in
				JPEGImageQueue.sharedInstance.processQueue(forKey: currentCacheKey, closure: { (item) -> () in
					item(image: nil)
				})
			})
		}
	}
	
	override func request(response response: (data: NSData) -> (), failure: (response: NSHTTPURLResponse?, error: NSError) -> ()) {
		assertionFailure("Don't call this directly. Call loadImage instead.")
	}
	
	override func configureServiceTask(task: HTTPServiceTask) {

		task.validator { (data, response, error) -> (HTTPValidationAction, NSError?) in
			if let r = response as? NSHTTPURLResponse {
				
				var found = false
				
				let headers = r.allHeaderFields
				for (key, value) in headers {
					if let k = key as? String, v = value as? String {
						if k == "Content-Type" && v == "image/jpeg" { found = true }
					}
				}
				
				if !found { return (.failure, nil) }
			}
			
			return (.proceed, nil)
		}
		
	}
	
	override var endpoint:String {
		return currentEndpoint
	}
}