//
//  DetailsCollectionHeaderView.swift
//  mftv
//
//  Created by Emiel Lensink on 25/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import UIKit
import QxKit

class DetailsCollectionHeaderView: UICollectionReusableView, ObjectConfigurable {
	
	@IBOutlet var label:UILabel!
	
	func configureWithObject(object object:AnyObject) {
		if let obj = object as? Category {
			
			label.text = "\(obj.name): \(obj.description)"
			
		}
	}
}
