//
//  Photo.swift
//  mftv
//
//  Created by Emiel Lensink on 14/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import Foundation
import QxKit

class Photo: JSONMappable {
	
	let name:String
	let fstop:Double
	let exposure:Double
	let focal:Double
	let iso:Double
	let make:String
	let model:String
	let user:String
	
	required init(json: JSON) {
		
		name = json["name"].value()
		fstop = json["fstop"].value()
		exposure = json["exposure"].value()
		focal = json["focal"].value()
		iso = json["iso"].value()
		make = json["make"].value()
		model = json["model"].value()
		user = json["user"].value()
	}
}