//
//  CompetitionService.swift
//  mftv
//
//  Created by Emiel Lensink on 14/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import Foundation
import QxKit

class CompetitionService: BaseJSONWebService<CompetitionArray> {
	
	override init() {
		super.init()
	}
	
	override var endpoint:String {
		return "api/meta"
	}
}
