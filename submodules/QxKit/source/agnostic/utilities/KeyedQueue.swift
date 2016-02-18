//
//  KeyedQueue.swift
//  QxKit
//
//  Created by Emiel Lensink on 26/01/16.
//
//

import Foundation

public class KeyedQueue<T> {
	
	private var queueDictionary:[String:[T]] = [:]

	public init() {
		
	}
	
	// Returns true if the queue was created.
	public func queueItem(item item:T, forKey key:String) -> Bool {
		var res = false
		
		synchronized(self) { () -> Void in
			
			if queueDictionary[key] == nil { queueDictionary[key] = []; res = true }
			queueDictionary[key]?.append(item)
		}

		return res
	}

	public func hasQueueForKey(key key:String) -> Bool {

		let res = synchronized(self) { () -> Bool in
			return queueDictionary[key] != nil
		}

		return res
	}
	
	public func processQueue(forKey key:String, closure:(item:T) -> ()) {
		
		synchronized(self) { () -> Void in
			
			if let array = queueDictionary[key] {
				for item in array {
					closure(item: item)
				}
				
				queueDictionary.removeValueForKey(key)
			}
		}
	}
}