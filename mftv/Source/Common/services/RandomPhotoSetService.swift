//
//  RandomPhotoSetService.swift
//  mftv
//
//  Created by Emiel Lensink on 21/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import Foundation
import QxKit

class RandomPhotoSetService: BaseJSONWebService<PhotoArray> {
	
	let competitionIdentifier:String
	
	init(competitionIdentifier:String) {
		self.competitionIdentifier = competitionIdentifier
		super.init()
	}

	func fetch(response response: (data:PhotoArray) -> (), failure: (response:ErrorResponseType?, error:NSError) -> ()) {
		request(response: response, failure: failure, parameters: ["id":competitionIdentifier])
	}
	
	override func rootNodeForJSONMapping(fetched:JSON) -> JSON {
		let res = fetched[0]["i"]
		return res
	}
	
	override var endpoint:String {
		return "api/overview"
	}
}
