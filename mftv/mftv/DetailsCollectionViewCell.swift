//
//  DetailsCollectionViewCell.swift
//  mftv
//
//  Created by Emiel Lensink on 22/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import Foundation
import UIKit
import QxKit

class DetailsCollectionViewCell: UICollectionViewCell, ObjectConfigurable {
	
	var configurableObject:Photo?
	
	@IBOutlet var textLabel:UILabel!
	@IBOutlet var imageView:UIImageView!
	@IBOutlet var activityIndicatorView:UIActivityIndicatorView!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder:aDecoder)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	func configureWithObject(object object:AnyObject) {
		configurableObject = object as? Photo
		
		self.imageView.alpha = 0.0
		self.activityIndicatorView.startAnimating()
		
		if let obj = configurableObject {
			
			textLabel.text = obj.user
			
			let service = JPEGImageService()
			service.loadImage(named: obj.name, size: .medium, completion: { (image) -> () in
				
				if let img = image {
					dispatch_async(dispatch_get_main_queue(), { () -> Void in
						self.imageView.image = img
						self.activityIndicatorView.stopAnimating()
						
						UIView.animateWithDuration(0.3, animations: { () -> Void in
							self.imageView.alpha = 1.0
						})
					})
				}
			})
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		self.imageView.image = nil
		self.imageView.alpha = 0.0
		self.activityIndicatorView.stopAnimating()

	}
}
