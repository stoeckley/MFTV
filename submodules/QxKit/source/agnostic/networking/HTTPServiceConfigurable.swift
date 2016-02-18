//
//  HTTPServiceConfigurable.swift
//  QxKit
//
//  Created by Emiel Lensink on 12/01/16.
//
//

import Foundation

public struct HTTPServiceConfig {

	public enum Verb {
		case GET
		case PUT
		case POST
		case UPDATE
		case DELETE
	}
	
	public enum CachePolicy {
		case standard
		case preferCache
		case preferDownload
	}
	
	init() {
		verb = .GET
		scheme = "https"
		host = ""
		path = ""
		port = 0
		
		headers = [:]
		parameters = [:]
		
		validators = []
		
		response = []
		failure = []
		
		body = nil
		cachePolicy = .standard
	}
	
	public var verb: Verb
	public var scheme: String
	public var host: String
	public var port: Int
	public var path: String
	public var body: NSData?
	public var cachePolicy: CachePolicy

	public var headers: [String: String]
	public var parameters: [String: String]
	
	public var validators: [HTTPValidator]
	
	public var response: [HTTPServiceConfigurable.ResponseHandler]
	public var failure: [HTTPServiceConfigurable.FailureHandler]
}

public class HTTPServiceConfigurable: NSObject {

	public typealias ResponseHandler = (data: NSData?, response: NSURLResponse?) -> ()
	public typealias FailureHandler = (data: NSData?, response: NSURLResponse?, error:NSError?) -> ()

	public var config = HTTPServiceConfig()
		
	// MARK: Public API, chained operators
	public func scheme(scheme: String) -> Self {
		self.config.scheme = scheme
		return self
	}

	public func cachePolicy(policy: HTTPServiceConfig.CachePolicy) -> Self {
		self.config.cachePolicy = policy
		return self
	}
	
	public func verb(verb: HTTPServiceConfig.Verb) -> Self {
		self.config.verb = verb
		return self
	}
	
	public func host(host: String) -> Self {
		self.config.host = host
		return self
	}
	
	public func path(path: String) -> Self {
		self.config.path = path
		return self
	}
	
	public func header(header: String, value: String) -> Self {
		self.config.headers[header] = value
		return self
	}
	
	public func body(body: NSData?) -> Self {
		self.config.body = body
		return self
	}
	
	public func parameter(name: String, value: String) -> Self {
		self.config.parameters[name] = value
		return self
	}
	
	public func validator(validator: HTTPValidator) -> Self {
		self.config.validators.append(validator)
		return self
	}
	
	public func validator(validator: HTTPValidatorBlock) -> Self {
		let blockValidator = HTTPBlockValidator(validator: validator)
		self.config.validators.append(blockValidator)
		return self
	}
	
	public func response(handler: ResponseHandler) -> Self {
		self.config.response.append(handler)
		return self
	}
	
	public func failure(handler: FailureHandler) -> Self {
		self.config.failure.append(handler)
		return self
	}
}
