//
//  HTTPServiceTask.swift
//  QxKit
//
//  Created by Emiel Lensink on 11/01/16.
//
//

import Foundation

public class HTTPServiceTask: HTTPServiceConfigurable {

	// MARK: Private variables
	private var basePath: String = ""
	
	private var session: NSURLSession
	private var task: NSURLSessionDataTask?

	// MARK: Init
	required public init(urlSession: NSURLSession, config: HTTPServiceConfig) {
		session = urlSession
		
		super.init()
		self.config = config
		self.basePath = config.path
		self.config.path = ""
	}

	// MARK: Module private API, chained operators
	public func basePath(path: String) -> Self {
		basePath = path
		return self
	}

	// MARK: Public API
	public func execute() -> Bool {
		// Based on the configuration, we'll create an URL.

		// Set up base parameters
		let components = NSURLComponents()
		components.scheme = config.scheme
		components.host = config.host
		if self.config.port != 0 { components.port = self.config.port }
		
		// Set up query items
		var queryItems: [NSURLQueryItem] = []
		self.config.parameters.forEach { (key:String, value:String) -> () in
			let item = NSURLQueryItem(name: key, value: value)
			queryItems.append(item)
		}
		components.queryItems = queryItems.count > 0 ? queryItems : nil
		
		// If all checks out, build query path
		if let URL = components.URL {
			var tempURL = URL.URLByAppendingPathComponent(self.basePath)
			tempURL = tempURL.URLByAppendingPathComponent(self.config.path)
			
			let request = NSMutableURLRequest(URL: tempURL)
			
			// Add headers to the request
			self.config.headers.forEach({ (key:String, value:String) -> () in
				request.addValue(value, forHTTPHeaderField: key)
			})
			
			// Set the verb
			switch self.config.verb {
			case .GET:
				request.HTTPMethod = "GET"
			case .POST:
				request.HTTPMethod = "POST"
			case .PUT:
				request.HTTPMethod = "PUT"
			case .DELETE:
				request.HTTPMethod = "DELETE"
			case .UPDATE:
				request.HTTPMethod = "UPDATE"
			}
			
			// Set the body
			request.HTTPBody = self.config.body
			
			// Set the caching strategy
			switch self.config.cachePolicy {
			case .standard:
				request.cachePolicy = .UseProtocolCachePolicy
			case .preferCache:
				request.cachePolicy = .ReturnCacheDataElseLoad
			case .preferDownload:
				request.cachePolicy = .ReloadIgnoringLocalCacheData
			}
			
			// Create the actual data task to perform the request
			let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
			
				var validationError = error;
				
				validation: for validator in self.config.validators {
					let result = validator.validate(data: data, response: response, error: error)
					
					switch result.0 {
					case .failure:
						validationError = result.1
						break validation
//					case .retry:
//						print("retry call - not implemented yet!")
					case .success:
						break validation
					default:
						break
					}
				}
				
				if let _ = validationError {
					for errorHandler in self.config.failure {
						errorHandler(data: data, response: response, error: validationError)
					}
				} else {
					for responseHandler in self.config.response {
						responseHandler(data: data, response: response)
					}
				}
			})
			
			task.resume()
		}
		
		return false
	}
}

