//
//  String+subStrings.swift
//  QxKit
//
//  Created by Emiel Lensink on 07/10/15.
//
//

import Foundation

extension String {
	
	public func leftSubstring(characterCount characterCount: Int) -> String {
		let wish = clamp(characterCount, lower: 0, higher: self.characters.count)
		return self.substringToIndex(self.startIndex.advancedBy(wish))
	}
	
	public func rightSubstring(characterCount characterCount: Int) -> String {
		let wish = clamp(characterCount, lower: 0, higher: self.characters.count)
		return self.substringFromIndex(self.endIndex.advancedBy(-wish))
	}
	
	public func substringByClippingLeftSide(characterCount characterCount: Int) -> String {
		let count = self.characters.count
		let wish = clamp(count - characterCount, lower: 0, higher: self.characters.count)
		return self.substringFromIndex(self.startIndex.advancedBy(wish))
	}

	public func substringByClippingRightSide(characterCount characterCount: Int) -> String {
		let count = self.characters.count
		let wish = clamp(count - characterCount, lower: 0, higher: self.characters.count)
		return self.substringToIndex(self.endIndex.advancedBy(-wish))
	}
	
}

