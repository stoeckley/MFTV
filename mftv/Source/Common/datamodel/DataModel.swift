//
//  DataModel.swift
//  mftv
//
//  Created by Emiel Lensink on 20/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import Foundation
import QxKit

class DataModel {
	
	enum ErrorReason {
		case failed
	}
	
	
	static var sharedInstance = DataModel()
	
	private init() {
		
	}
	
	var lastRootDataRefresh = NSDate.distantPast()
	var rootData:[Competition] = []
	let competitionService = CompetitionService()
	
	func rootData(response response: (success:Bool, data:[Competition]) -> ()) {

		// RootData is fetched once per hour. The fetched data is merged with the existing
		//  data if it's there.
		var mustFetch = false
		if rootData.count == 0 { mustFetch = true }
		if NSDate() - lastRootDataRefresh > 60 * 60 { mustFetch = true }
		
		if !mustFetch {
			response(success: true, data: rootData)
		} else {
			
			competitionService.request(response: { (data) -> () in
				
				self.rootData = data.data // TODO
				self.lastRootDataRefresh = NSDate()
				response(success: true, data: self.rootData)
				
			}, failure: { (responseCode, error) -> () in
				
				self.rootData = []
				self.lastRootDataRefresh = NSDate.distantPast()
				response(success: false, data: self.rootData)
				
			})
		}
	}
}
