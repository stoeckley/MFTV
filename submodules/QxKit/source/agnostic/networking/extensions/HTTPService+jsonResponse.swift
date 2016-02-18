//
//  HTTPService+jsonResponse.swift
//  QxKit
//
//  Created by Emiel Lensink on 13/01/16.
//
//

import Foundation

extension HTTPServiceConfigurable {
	
	public typealias JsonResponseHandler = (data: AnyObject?, response: NSURLResponse?) -> ()
	
	public func jsonResponse(handler: JsonResponseHandler) -> Self {
		
		self.response { (data, response) -> () in

			var json:AnyObject? = []
			
			if let d = data {
				do {
					json = try NSJSONSerialization.JSONObjectWithData(d, options: [])
				}
				catch { }
			}
			
			handler(data: json, response: response)
		}
		
		return self
	}
}

