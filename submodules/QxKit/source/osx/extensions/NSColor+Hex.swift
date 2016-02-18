//
//  NSColor+Hex.swift
//  QxKit
//
//  Created by Emiel Lensink on 27/08/15.
//
//

import Foundation
import AppKit

extension NSColor {

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

	public convenience init(withCalibratedHex hex:Int) {
		let rgb = rgbHelper(withHex: hex)
		self.init(calibratedRed:rgb.r, green:rgb.g, blue:rgb.b, alpha:rgb.a)
	}
	
	public convenience init(withCalibratedHex hex:Int, alpha:CGFloat) {
		let rgb = rgbHelper(withHex: hex, alpha:alpha)
		self.init(calibratedRed:rgb.r, green:rgb.g, blue:rgb.b, alpha:rgb.a)
	}
	
	public convenience init(withCalibratedHex32 hex:Int) {
		let rgb = rgbHelper(withHex32: hex)
		self.init(calibratedRed:rgb.r, green:rgb.g, blue:rgb.b, alpha:rgb.a)
	}
	
	public convenience init(withCalibratedHexString hex:String) {
		let rgb = rgbHelper(withHex: hex)
		self.init(calibratedRed:rgb.r, green:rgb.g, blue:rgb.b, alpha:rgb.a)
	}

	public convenience init(withDeviceHex hex:Int) {
		let rgb = rgbHelper(withHex: hex)
		self.init(deviceRed:rgb.r, green:rgb.g, blue:rgb.b, alpha:rgb.a)
	}
	
	public convenience init(withDeviceHex hex:Int, alpha:CGFloat) {
		let rgb = rgbHelper(withHex: hex, alpha:alpha)
		self.init(deviceRed:rgb.r, green:rgb.g, blue:rgb.b, alpha:rgb.a)
	}
	
	public convenience init(withDeviceHex32 hex:Int) {
		let rgb = rgbHelper(withHex32: hex)
		self.init(deviceRed:rgb.r, green:rgb.g, blue:rgb.b, alpha:rgb.a)
	}
	
	public convenience init(withDeviceHexString hex:String) {
		let rgb = rgbHelper(withHex: hex)
		self.init(deviceRed:rgb.r, green:rgb.g, blue:rgb.b, alpha:rgb.a)
	}

}