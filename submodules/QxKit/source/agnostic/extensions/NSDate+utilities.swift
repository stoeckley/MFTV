//
//  NSDate+utilities.swift
//  QxKit
//
//  Created by Emiel Lensink on 21/01/16.
//
//

import Foundation

extension NSDate {
	
}

public func -(lhs:NSDate, rhs:NSDate) -> NSTimeInterval {
	return lhs.timeIntervalSinceDate(rhs)
}

public func +(lhs:NSDate, rhs:NSTimeInterval) -> NSDate {
	return lhs.dateByAddingTimeInterval(rhs)
}

public func -(lhs:NSDate, rhs:NSTimeInterval) -> NSDate {
	return lhs.dateByAddingTimeInterval(-rhs)
}

public func +=(inout lhs:NSDate, rhs:NSTimeInterval) {
	lhs = lhs.dateByAddingTimeInterval(rhs)
}

public func -=(inout lhs:NSDate, rhs:NSTimeInterval) {
	lhs = lhs.dateByAddingTimeInterval(rhs)
}

