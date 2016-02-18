//
//  Dictionary+utilities.swift
//  QxKit
//
//  Created by Emiel Lensink on 20/01/16.
//
//

import Foundation

public func +=<KeyType, ValueType> (inout lhs: [KeyType:ValueType], rhs: [KeyType:ValueType]) {
	
	for (k, v) in rhs {
		lhs[k] = v
	}
}
