//
//  ArrayMappable.swift
//  QxKit
//
//  Created by Emiel Lensink | The Mobile Company on 02/02/16.
//
//

import Foundation


public class ArrayMappable<T where T:JSONMappable>: JSONMappable {
	
	public let data:[T]
	
	public required init(json: JSON) {
		
		let array:[T] = json.autoMap()
		data = array
	}
}
