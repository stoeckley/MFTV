//
//  Utilities.swift
//  QxKit
//
//  Created by Emiel Lensink on 07/10/15.
//
//

import Foundation

public func clamp<T: Comparable>(value:T, lower: T, higher: T) -> T {
	return min(max(value, lower), higher)
}

