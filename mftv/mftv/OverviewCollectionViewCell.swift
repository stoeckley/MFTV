//
//  OverviewCollectionViewCell.swift
//  mftv
//
//  Created by Emiel Lensink on 16/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import UIKit
import QxKit

class OverviewCollectionViewCell: UICollectionViewCell, ObjectConfigurable {
	
	var configurableObject:Competition?
	var randomPhotos:[Photo] = []
	var randomPhotoIndex = 0
	
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
		configurableObject = object as? Competition
		
		self.imageView.alpha = 0.0
		self.activityIndicatorView.startAnimating()
		
		if let obj = configurableObject {
			
			textLabel.text = obj.name
			
			obj.randomPhotoData(response: { (success, data) -> () in
				if success && data.count > 0 {
					
					self.randomPhotos = data
					self.randomPhotoIndex = 0
					
					
					let service = JPEGImageService()
					service.loadImage(named: self.randomPhotos[self.randomPhotoIndex].name, size: .medium, completion: { (image) -> () in
						
						if let img = image {
							dispatch_async(dispatch_get_main_queue(), { () -> Void in
								self.imageView.image = img
								self.activityIndicatorView.stopAnimating()
								self.activityIndicatorView.hidden = true
								
								UIView.animateWithDuration(0.3, animations: { () -> Void in
									self.imageView.alpha = 1.0
								})
							})
						}
					})
					
				}
			})
		}
	}
	
	func timerFired(timer:NSTimer) {
		self.randomPhotoIndex += 1
		if self.randomPhotoIndex >= self.randomPhotos.count {
			self.randomPhotoIndex = 0
		}
	
		if self.focused { return }
		if self.randomPhotos.count == 0 { return }
		
//		dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), { () -> Void in
			
			let service = JPEGImageService()
			service.loadImage(named: self.randomPhotos[self.randomPhotoIndex].name, size: .medium, completion: { (image) -> () in
				
				if let img = image {
					dispatch_async(dispatch_get_main_queue(), { () -> Void in
						
						let newImageView = UIImageView(frame: self.imageView.frame)
						newImageView.contentMode = .ScaleAspectFill
						newImageView.adjustsImageWhenAncestorFocused = true
						newImageView.image = self.imageView.image
						
						self.insertSubview(newImageView, aboveSubview: self.imageView)
						self.imageView.image = img
						self.imageView.alpha = 0
						
						UIView.animateWithDuration(0.8, animations: { () -> Void in
							newImageView.alpha = 0
							self.imageView.alpha = 1
						}, completion: { (completed) -> Void in
							newImageView.removeFromSuperview()
						})
					})
				}
			})
//		})
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		print("Prep for re-use")
		
		self.imageView.image = nil
		self.imageView.alpha = 0.0
		self.activityIndicatorView.stopAnimating()
		self.activityIndicatorView.hidden = false
	}
}
