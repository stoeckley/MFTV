//
//  HTTPService.swift
//  QxKit
//
//  Created by Emiel Lensink on 03/11/15.
//
//

import Foundation

public class HTTPService: HTTPServiceConfigurable, NSURLSessionDelegate {
	
	// MARK: Private variables
	private var session: NSURLSession?
	private var task: NSURLSessionDataTask?
	
	// MARK: Singleton
	public class var sharedInstance:HTTPService {
		get {
			struct Static {
				static var instance : HTTPService? = nil
				static var token: dispatch_once_t = 0
			}

			dispatch_once(&Static.token) { () -> Void in
				Static.instance = HTTPService()
			}
			
			return Static.instance!
		}
	}
	
	// MARK: Init
	override init() {
		super.init()
		print("HTTP service init")
		
		let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
		let queue = NSOperationQueue()
		self.session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: queue)
	}
	
	// MARK: NSURLSession delegate
	public func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?) {
		print("Session did become invalid")
	}
	
	public func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
		//print("Auth challenge")
		completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, nil)
	}
	
	public func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession) {
		print("URL background session did finish")
	}
	
	// MARK: Creation of task(s), based on default parameters
	public func newServiceTask() -> HTTPServiceTask {
		return HTTPServiceTask(urlSession: session!, config: config)
	}
}