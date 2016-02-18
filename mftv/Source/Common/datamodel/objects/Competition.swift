//
//  Competition.swift
//  mftv
//
//  Created by Emiel Lensink on 14/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import Foundation
import QxKit

class Competition: JSONMappable {
	
	var id:Int
	var description:String
	var name:String
	
	var randomPhotos:[Photo] = []
	var lastRandomPhotosRefresh = NSDate.distantPast()

	var categories:[Category] = []
	var lastCategoriesRefresh = NSDate.distantPast()
	
	let randomPhotoService:RandomPhotoSetService
	let detailsService:CompetitionDetailsService

	required init(json: JSON) {
		id = json["i"].value()
		description = json["d"].value()
		name = json["n"].value()
		
		randomPhotoService = RandomPhotoSetService(competitionIdentifier: "\(id)")
		detailsService = CompetitionDetailsService(competitionIdentifier: "\(id)")
	}
	
	func randomPhotoData(response response: (success:Bool, data:[Photo]) -> ()) {
		
		var mustFetch = false
		if randomPhotos.count == 0 { mustFetch = true }
		if NSDate() - lastRandomPhotosRefresh > 1 * 60 { mustFetch = true }
		
		if !mustFetch {
			response(success: true, data: randomPhotos)
		} else {
			
			randomPhotoService.fetch(response: { (data) -> () in
				
				self.randomPhotos = data.data // TODO
				self.lastRandomPhotosRefresh = NSDate()
				response(success: true, data: self.randomPhotos)
				
			}, failure: { (responseCode, error) -> () in
					
				self.randomPhotos = []
				self.lastRandomPhotosRefresh = NSDate.distantPast()
				response(success: false, data: self.randomPhotos)
				
			})
		}
	}
	
	func categoryData(response response: (success:Bool, data:[Category]) -> ()) {
		
		var mustFetch = false
		if categories.count == 0 { mustFetch = true }
		if NSDate() - lastCategoriesRefresh > 5 * 60 { mustFetch = true }
		
		if !mustFetch {
			response(success: true, data: categories)
		} else {
			
			detailsService.fetch(response: { (data) -> () in
				
				self.categories = data.data // TODO
				self.lastCategoriesRefresh = NSDate()
				response(success: true, data: self.categories)
				
			}, failure: { (responseCode, error) -> () in
				
				self.categories = []
				self.lastCategoriesRefresh = NSDate.distantPast()
				response(success: false, data: self.categories)
					
			})
		}
	}
}
