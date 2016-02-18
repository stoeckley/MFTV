//
//  BaseDataLoaderService.swift
//  QxKit
//
//  Created by Emiel Lensink on 22/01/16.
//
//

import Foundation

public class BaseDataLoaderService: DataService<NSData, NSHTTPURLResponse> {
	
//	public typealias ObjectType = NSData
	public typealias ErrorResponseType = NSHTTPURLResponse
	
	public override init() {
		super.init()
	}
	
	public override func request(response response: (data:NSData) -> (), failure: (response:ErrorResponseType?, error:NSError) -> (), parameters:[String:String]) {
		
		let task = HTTPService.sharedInstance.newServiceTask()
		
		// Add validators to the task
		task.validator(HTTPLoggingValidator())
			.validator(HTTP404Validator())
			.validator(HTTP50xValidator())
		
		// Set task endpoint
		task.path(self.endpoint)
		
		// Set parameters
		task.config.parameters += parameters
		
		// Set task completion and failure blocks
		task.response { (data, httpresponse) -> () in

			if let d = data {
				
				response(data:d)

			} else {
			
				let error = NSError(domain: "qxkit.dataloaderwebservice", code: 0, userInfo: ["text":"no data received"])
				failure(response: httpresponse as? NSHTTPURLResponse, error: error)
				
			}
		
		}
		
		task.failure { (data, responseObject, error) -> () in
			let urlHTTPResponse = responseObject as? NSHTTPURLResponse
			failure(response: urlHTTPResponse, error: error!)
		}
		
		// Allow the app to modify the request (like verb, body, etc)
		self.configureServiceTask(task)
		
		task.execute()
	}
	
	// MARK: Overridables
	public func rootNodeForJSONMapping(fetched:JSON) -> JSON {
		return fetched
	}
	
	public func configureServiceTask(task:HTTPServiceTask) {
		// Override this to modify everything related to the request before it's
		//  sent.
	}
	
	public var endpoint:String {
		return ""
	}
	
}