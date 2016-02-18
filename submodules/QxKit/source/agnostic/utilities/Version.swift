//
//  Version.swift
//  QxKit
//
//  Created by Emiel Lensink on 15/10/15.
//
//

import Foundation

public class QxKit {

	public static func versionString() -> String {
		
	#if os(iOS)
		let platform = "iOS"
	#elseif os(OSX)
		let platform = "OSX"
	#else
		let platform = "unknown"
	#endif
		
	#if arch(x86_64)
		let architecture = "x86_64"
	#elseif arch(arm)
		let architecture = "arm"
	#elseif arch(arm64)
		let architecture = "arm64"
	#elseif arch(i386)
		let architecture = "i386"
	#else
		let architecture = "unknown"
	#endif
		
	#if DEBUG
		let debug = "debug"
	#else
		let debug = "release"
	#endif
		
		return "qxKit 1.0 (\(platform), \(architecture), \(debug))"
	}

}