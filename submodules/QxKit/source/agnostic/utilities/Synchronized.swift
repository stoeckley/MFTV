//
//  Synchronized.swift
//  QxKit
//
//  Created by Emiel Lensink on 26/01/16.
//
//

import Foundation

// Swift version of @synchronized
func synchronized<T>(lock: AnyObject, @noescape closure: () throws -> T) rethrows -> T {
	objc_sync_enter(lock)
	defer {
		objc_sync_exit(lock)
	}
	return try closure()
}

