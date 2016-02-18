//
//  UIColor+Hex.swift
//  QxKit
//
//  Created by Emiel Lensink on 27/08/15.
//
//

import UIKit

extension UIColor {
	
	public convenience init(withHex hex:Int) {
		let rgb = rgbHelper(withHex: hex)
		self.init(red:rgb.r, green:rgb.g, blue:rgb.b, alpha:rgb.a)
	}
	
	public convenience init(withHex hex:Int, alpha:CGFloat) {
		let rgb = rgbHelper(withHex: hex, alpha:alpha)
		self.init(red:rgb.r, green:rgb.g, blue:rgb.b, alpha:rgb.a)
	}

	public convenience init(withHex32 hex:Int) {
		let rgb = rgbHelper(withHex32: hex)
		self.init(red:rgb.r, green:rgb.g, blue:rgb.b, alpha:rgb.a)
	}

	public convenience init(withHexString hex:String) {
		let rgb = rgbHelper(withHex: hex)
		self.init(red:rgb.r, green:rgb.g, blue:rgb.b, alpha:rgb.a)
	}
	
}