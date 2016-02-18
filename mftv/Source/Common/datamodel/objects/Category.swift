//
//  Category.swift
//  mftv
//
//  Created by Emiel Lensink on 14/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import Foundation
import QxKit

class Category: JSONMappable {
	
	var description:String
	var name:String
	
	var images:[Photo] = []

	required init(json: JSON) {
		description = json["d"].value()
		name = json["n"].value()
		
		images = json["i"].autoMap()
	}
}

