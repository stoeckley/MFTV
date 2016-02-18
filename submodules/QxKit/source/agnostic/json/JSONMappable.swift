//
//  JSONMappable.swift
//  QxKit
//
//  Created by Emiel Lensink on 14/01/16.
//
//

import Foundation

public protocol JSONMappable {
	init(json:JSON)
}

extension JSON {

	public func autoMap<T where T:JSONMappable>() -> T {
		return T(json: self)
	}

	public func autoMap<T where T:JSONMappable>() -> [T] {
		
		var res:[T] = []
		
		for index in 0..<self.count {
			let item = self[index]
			
			let mapped:T = item.autoMap()
			res.append(mapped)
		}
		
		return res
	}
}
