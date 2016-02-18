//
//  JSON.swift
//  QxKit
//
//  Created by Emiel Lensink on 14/01/16.
//
//

import Foundation

public class JSON {
	
	public typealias jsonDictionary = [String:AnyObject]
	public typealias jsonArray = [AnyObject]
	
	public enum Type {
		case string
		case number
		case bool
		case dictionary
		case array
		case null
	}
	
	private var internalType: Type = .null
	
	private var internalObject: AnyObject? = nil
	private var internalArray: jsonArray = []
	private var internalDictionary: jsonDictionary = [:]
	private var internalString: String = ""
	private var internalNumber: NSNumber = 0
	
	public init() {										// Init an empty JSON
		internalType = .null
	}
	
	public convenience init?(data: NSData?) throws {	// Parse NSData
		var json:AnyObject? = []
		
		if let d = data {
			do {
				json = try NSJSONSerialization.JSONObjectWithData(d, options: [])
			}
			catch {
				throw error
			}
		}
		
		if json != nil { self.init(object: json) }
		else { return nil }
	}
	
	public init(json: JSON) {							// Based on another JSON
		internalType = json.internalType
		
		internalObject = json.internalObject
		internalArray = json.internalArray
		internalDictionary = json.internalDictionary
		internalString = json.internalString
		internalNumber = json.internalNumber
	}
	
	public init(object: AnyObject?) {					// Based on whatever you want
		self.internalObject = object
		
		if let o = object {
			
			switch o {
			case let number as NSNumber:
				if number.isBool { internalType = .bool }
				else { internalType = .number }
				
				self.internalNumber = number
				
			case let string as String:
				internalType = .string
				self.internalString = string
				
			case let array as jsonArray:
				internalType = .array
				self.internalArray = array
				
			case let dictionary as jsonDictionary:
				internalType = .dictionary
				self.internalDictionary = dictionary
				
			default:
				internalType = .null
				
			}
		} else {
			internalType = .null
		}
	}
}

// MARK: Getting data out of it
extension JSON {
	
	public var numberValue: NSNumber {
		switch internalType {
		case .number:
			return internalNumber
		case .bool:
			return internalNumber
		case .string:
			let parsed = NSDecimalNumber(string: self.internalString)
			
			if parsed == NSDecimalNumber.notANumber() {
				return NSNumber(double: 0.0)
			}
			return parsed
			
		default:
			return NSNumber(double: 0.0)
		}
	}
	
	public var intValue: Int {
		return self.numberValue.integerValue
	}

	public var floatValue: Float {
		return self.numberValue.floatValue
	}

	public var doubleValue: Double {
		return self.numberValue.doubleValue
	}
	
	public var stringValue: String {
		switch internalType {
		case .string:
			return internalString
		default:
			if let o = internalObject {
				return "\(o)"
			} else {
				return ""
			}
		}
	}
	
	public var boolValue: Bool {
		switch internalType {
		case .bool:
			return internalNumber.boolValue
		default:
			return false
		}
	}
	
	public var arrayValue: jsonArray {
		switch internalType {
		case .array:
			return internalArray
		case .number:
			return [internalNumber]
		case .string:
			return [internalString]
		case .dictionary:
			var res:jsonArray = []
			
			for (_, value) in internalDictionary {
				res.append(value)
			}
			
			return res
		case .bool:
			return [internalNumber]
		default:
			return []
		}
	}
	
	public var dictionaryValue: jsonDictionary {
		switch internalType {
		case .array:
			var res:jsonDictionary = [:]
			var count = 0
			
			for value in internalArray {
				res["\(count)"] = value
				count += 1
			}
			
			return res
		case .number:
			return ["0": internalNumber]
		case .string:
			return ["0": internalString]
		case .dictionary:
			return internalDictionary
		case .bool:
			return ["0": internalNumber]
		default:
			return [:]
		}
	}
	
	public var count:Int {
		switch internalType {
		case .array:
			return internalArray.count
		default:
			return 0
		}
	}
	
	public var type:Type {
		return self.internalType
	}
}

// MARK: <- operators
infix operator <- { associativity right precedence 160 }

public func <-(inout left:NSNumber, right:JSON) {
	left = right.numberValue
}

public func <-(inout left:String, right:JSON) {
	left = right.stringValue
}

public func <-(inout left:Bool, right:JSON) {
	left = right.boolValue
}

public func <-(inout left:Int, right:JSON) {
	left = right.numberValue.integerValue
}

public func <-(inout left:Float, right:JSON) {
	left = right.numberValue.floatValue
}

public func <-(inout left:Double, right:JSON) {
	left = right.numberValue.doubleValue
}

public func <-(inout left:JSON.jsonArray, right:JSON) {
	left = right.arrayValue
}

public func <-(inout left:JSON.jsonDictionary, right:JSON) {
	left = right.dictionaryValue
}

// MARK: Subscripts
public extension JSON {
	public subscript(index: Int) -> JSON {
		
		var res:JSON? = nil
		
		switch internalType {
		case .array:
			if index >= 0 && index < internalArray.count {
				res = JSON(object: internalArray[index])
			}
		default:
			break
		}
		
		return res == nil ? JSON() : res!
	}
	
	public subscript(key: String) -> JSON {
		var res:JSON? = nil
		
		switch internalType {
		case .dictionary:
			res = JSON(object: internalDictionary[key])
		default:
			res = JSON()
		}
		
		return res!
	}
}

// MARK: Value for common types
public extension JSON {
	public func value() -> Int { return self.intValue }
	public func value() -> Float { return self.floatValue }
	public func value() -> Double { return self.doubleValue }
	public func value() -> jsonDictionary { return self.dictionaryValue }
	public func value() -> jsonArray { return self.arrayValue }
	public func value() -> String { return self.stringValue }
	public func value() -> NSNumber { return self.numberValue }
	public func value() -> Bool { return self.boolValue }
}

// MARK: Utility functions
private let trueNumber = NSNumber(bool: true)
private let falseNumber = NSNumber(bool: false)
private let trueCType = String.fromCString(trueNumber.objCType)
private let falseCType = String.fromCString(falseNumber.objCType)

extension NSNumber {
	var isBool:Bool {
		let cType = String.fromCString(self.objCType)
		
		if (self.compare(trueNumber) == .OrderedSame && cType == trueCType) ||
			(self.compare(falseNumber) == .OrderedSame && cType == falseCType) {
				return true
		} else {
			return false
		}
	}
}

