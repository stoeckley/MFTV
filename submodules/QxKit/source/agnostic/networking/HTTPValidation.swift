//
//  HTTPValidation.swift
//  QxKit
//
//  Created by Emiel Lensink on 12/01/16.
//
//

import Foundation

// MARK: Validator actions
public enum HTTPValidationAction {
	case proceed		// Don't act on the result of this validator
	case success		// Immediately call success handler
	case failure		// Immediately call failure handler
	case retry			// Retry the network call
}

// MARK: Validator protocol
public protocol HTTPValidator {
	func validate(data data: NSData?, response: NSURLResponse?, error:NSError?) -> (HTTPValidationAction, NSError?)
}

public typealias HTTPValidatorBlock = (data: NSData?, response: NSURLResponse?, error:NSError?) -> (HTTPValidationAction, NSError?)

// MARK: Block/closure validator
public class HTTPBlockValidator: HTTPValidator {
	
	let validator: HTTPValidatorBlock
	
	required public init(validator: HTTPValidatorBlock) {
		self.validator = validator
	}
	
	public func validate(data data: NSData?, response: NSURLResponse?, error: NSError?) -> (HTTPValidationAction, NSError?) {
		return validator(data: data, response: response, error: error)
	}
}

// MARK: 404 validator
public class HTTP404Validator: HTTPValidator {
	
	public init() { }
	
	public func validate(data data: NSData?, response: NSURLResponse?, error: NSError?) -> (HTTPValidationAction, NSError?) {

		if let res = response as? NSHTTPURLResponse {
			if res.statusCode == 404 {
				let error = NSError(domain: "qxkit.httpservice.http404validator", code: 404, userInfo: ["description":"HTTP status code is 404: not found"])
				return (.failure, error)
			}
		}
		
		return (.proceed, nil)
	}
	
}

// MARK: 50x validator
public class HTTP50xValidator: HTTPValidator {
	
	public init() { }
	
	public func validate(data data: NSData?, response: NSURLResponse?, error: NSError?) -> (HTTPValidationAction, NSError?) {
		
		if let res = response as? NSHTTPURLResponse {
			if res.statusCode >= 500 {
				let error = NSError(domain: "qxkit.httpservice.http50xvalidator", code: res.statusCode, userInfo: ["description":"HTTP error"])
				return (.failure, error)
			}
		}
		
		return (.proceed, nil)
	}
	
}

// MARK: Logging validator
public class HTTPLoggingValidator: HTTPValidator {

	var verbose:Bool
	
	public init(verbose:Bool = false) { self.verbose = verbose }
	
	public func validate(data data: NSData?, response: NSURLResponse?, error: NSError?) -> (HTTPValidationAction, NSError?) {
		if verbose {
			print(response)
			print("Response body length: \(data?.length)")
			print("Error: \(error)")
		}
		else {
			if let urlRes = response as? NSHTTPURLResponse {
				if error != nil { print("\(urlRes.URL!): \(urlRes.statusCode) (\(error))") }
				else { print("\(urlRes.URL!): \(urlRes.statusCode)") }
			}
		}
		
		return (.proceed, nil)
	}
	
}