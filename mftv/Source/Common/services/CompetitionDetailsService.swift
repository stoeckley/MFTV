//
//  CompetitionDetailsService.swift
//  mftv
//
//  Created by Emiel Lensink on 22/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import Foundation
import QxKit

class CompetitionDetailsService: BaseJSONWebService<CategoryArray> {
		
	let competitionIdentifier:String
	
	init(competitionIdentifier:String) {
		self.competitionIdentifier = competitionIdentifier
		super.init()
	}
	
	func fetch(response response: (data:CategoryArray) -> (), failure: (response:ErrorResponseType?, error:NSError) -> ()) {
		request(response: response, failure: failure, parameters: ["id":competitionIdentifier])
	}
	
	override func rootNodeForJSONMapping(fetched:JSON) -> JSON {
		let res = fetched[0]["c"]
		return res
	}
	
	override var endpoint:String {
		return "api/details"
	}
}
