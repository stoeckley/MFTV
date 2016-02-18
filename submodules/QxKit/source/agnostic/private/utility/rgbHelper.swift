//
//  HexToRGBHelper.swift
//  QxKit
//
//  Created by Emiel Lensink on 26/08/15.
//
//

import Foundation
import CoreGraphics

public struct rgbHelper {
	let r:CGFloat
	let g:CGFloat
	let b:CGFloat
	let a:CGFloat
	
	init(red:CGFloat, green:CGFloat, blue:CGFloat) {
		self.init(red:red, green:green, blue:blue, alpha:1.0)
	}
	
	init(red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat) {
		r = red
		g = green
		b = blue
		a = alpha
	}
	
	init(withHex hex:Int, alpha:CGFloat) {
		let parsedB = hex & 0xFF
		let parsedG = (hex >> 8) & 0xFF
		let parsedR = (hex >> 16) & 0xFF
		
		r = CGFloat(parsedR) / 255.0
		g = CGFloat(parsedG) / 255.0
		b = CGFloat(parsedB) / 255.0
		a = 1.0
	}

	init(withHex hex:Int) {
		self.init(withHex:hex, alpha:1.0)
	}
	
	init(withHex32 hex:Int) {
		let parsedA = hex & 0xFF
		let floatA = CGFloat(parsedA) / 255.0
		
		self.init(withHex:(hex >> 8), alpha:floatA)
	}
	
	init(withHex hex:String) {
		var initR:CGFloat = 0.0
		var initG:CGFloat = 0.0
		var initB:CGFloat = 0.0
		var initA:CGFloat = 1.0
		
		if hex.characters.count > 0 {
			var trimmedHex = hex.uppercaseString
			
			if trimmedHex.hasPrefix("#") {
				trimmedHex = trimmedHex.substringByClippingLeftSide(characterCount: 1)
			}
			
			let scanner = NSScanner(string: trimmedHex)
			var scanned: UInt64 = 0

			if scanner.scanHexLongLong(&scanned) {
				switch hex.characters.count {
				case 3:			// RGB
					let parsedB = scanned & 0xF
					let parsedG = (scanned >> 4) & 0xF
					let parsedR = (scanned >> 8) & 0xF
					
					initR = CGFloat(parsedR) / 15.0
					initG = CGFloat(parsedG) / 15.0
					initB = CGFloat(parsedB) / 15.0
					
				case 4:			// RGBA
					let parsedA = scanned & 0xF
					let parsedB = (scanned >> 4) & 0xF
					let parsedG = (scanned >> 8) & 0xF
					let parsedR = (scanned >> 12) & 0xF
					
					initA = CGFloat(parsedA) / 15.0
					initR = CGFloat(parsedR) / 15.0
					initG = CGFloat(parsedG) / 15.0
					initB = CGFloat(parsedB) / 15.0
				
				case 6:			// RRGGBB
					let parsedB = scanned & 0xFF
					let parsedG = (scanned >> 8) & 0xFF
					let parsedR = (scanned >> 16) & 0xFF
					
					initR = CGFloat(parsedR) / 255.0
					initG = CGFloat(parsedG) / 255.0
					initB = CGFloat(parsedB) / 255.0

				case 8:			// RRGGBBAA
					let parsedA = scanned & 0xF
					let parsedB = (scanned >> 8) & 0xF
					let parsedG = (scanned >> 16) & 0xF
					let parsedR = (scanned >> 24) & 0xF
					
					initA = CGFloat(parsedA) / 255.0
					initR = CGFloat(parsedR) / 255.0
					initG = CGFloat(parsedG) / 255.0
					initB = CGFloat(parsedB) / 255.0
					
				default:
					initA = 0.0		// Don't really do anything
				}
			}
		
		}
		
		r = initR; g = initG; b = initB; a = initA
	}
	
}