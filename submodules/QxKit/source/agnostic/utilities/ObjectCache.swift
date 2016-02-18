//
//  ObjectCache.swift
//  QxKit
//
//  Created by Emiel Lensink on 22/01/16.
//
//

import Foundation

// Simple singleton for managing NSCache objects.
public class ObjectCache {
	
	public static let defaultCache = NSCache()
	public static let sharedInstance = ObjectCache()
	
	var internalCaches:[String:NSCache] = [:]
	
	private init() {
		
	}
	
	public func createCache(named named:String) -> NSCache {
		if let cache = getCache(named: named) {
			return cache
		} else {
			internalCaches[named] = NSCache()
			return internalCaches[named]!
		}
	}
	
	public func getCache(named named:String) -> NSCache? {
		return internalCaches[named]
	}
	
	public func removeCache(named named:String) {
		if let cache = getCache(named: named) {
			cache.removeAllObjects()
		}
		
		internalCaches.removeValueForKey(named)
	}
}
