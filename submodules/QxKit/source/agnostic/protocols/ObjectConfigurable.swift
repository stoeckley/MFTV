//
//  ObjectConfigurable.swift
//  QxKit
//
//  Created by Emiel Lensink on 21/01/16.
//
//

import Foundation

public protocol ObjectConfigurable {
	
	// TODO: Replace by typesafe solution!
	func configureWithObject(object object:AnyObject)
}
