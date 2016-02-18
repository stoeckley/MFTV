//
//  ServiceProvider.swift
//  topshelf
//
//  Created by Emiel Lensink on 27/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import Foundation
import TVServices

class ServiceProvider: NSObject, TVTopShelfProvider {

	override init() {
	    super.init()
	}

	// MARK: - TVTopShelfProvider protocol

	var topShelfStyle: TVTopShelfContentStyle {
	    // Return desired Top Shelf style.
	    return .Sectioned
	}

	var topShelfItems: [TVContentItem] {
	    // Create an array of TVContentItems.
		var items:[TVContentItem] = []
		
		let data = NSData(contentsOfURL: NSURL(string: "https://mooistefotos.nl/api/ten")!)
		
		do {
			let j = try JSON(data: data)
			
			if let json = j {
				for index in 0..<json.count {
			
					let item = TVContentItem(contentIdentifier: TVContentIdentifier(identifier: "\(index)", container: nil)!)!

					let name = json[index]["name"].stringValue
					
					item.imageShape = .Square
					item.imageURL = NSURL(string: "http://mooistefotos.nl/uploads/\(name)_800.jpg")
					item.displayURL = NSURL(string: "mftv://\(name)")
						
					items.append(item)
				}
			}
		}
		catch { }
		
		let group = TVContentItem(contentIdentifier: TVContentIdentifier(identifier: "recent", container: nil)!)!
		group.topShelfItems = items
		group.title = "Recente inzendingen"
		
		return [group]
	}

}

