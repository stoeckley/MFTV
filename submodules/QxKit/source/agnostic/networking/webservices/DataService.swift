//
//  BaseDataService.swift
//  QxKit
//
//  Created by Emiel Lensink on 15/01/16.
//
//

import Foundation

public class DataService<T, U> {
	
	public init() {
		
	}
	
	public func request(response response: (data:T) -> (), failure: (response:U?, error:NSError) -> ()) {
		request(response: response, failure: failure, parameters: [:])
	}
	
	public func request(response response: (data:T) -> (), failure: (response:U?, error:NSError) -> (), parameters:[String:String]) {
		assertionFailure("subclasses must implement and not call this!")
	}
	
}