//
//  FullscreenImageViewController.swift
//  mftv
//
//  Created by Emiel Lensink on 25/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import UIKit

class FullscreenImageViewController: UIViewController {

	@IBOutlet var imageView:UIImageView!
	@IBOutlet var imageView2:UIImageView!
	@IBOutlet var activityIndicatorView:UIActivityIndicatorView!
	
	@IBOutlet var nameLabel:UILabel!
	@IBOutlet var exifLabel:UILabel!
	
	var image:Photo!
	var index:Int = 0
	var count:Int = 0
	
    override func viewDidLoad() {
        super.viewDidLoad()

		imageView.alpha = 0.0
		imageView2.alpha = 0.0
		activityIndicatorView.startAnimating()
		
		exifLabel.layer.shadowColor = UIColor.blackColor().CGColor
		exifLabel.layer.shadowOpacity = 1.0
		exifLabel.layer.shadowRadius = 15.0
		exifLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
		exifLabel.text = ""
		
		nameLabel.layer.shadowColor = UIColor.blackColor().CGColor
		nameLabel.layer.shadowOpacity = 1.0
		nameLabel.layer.shadowRadius = 15.0
		nameLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
		nameLabel.text = ""
		
		self.exifLabel.alpha = 0.0
		self.nameLabel.alpha = 0.0
		
		dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), { () -> Void in
			
			let service = JPEGImageService()
			service.loadImage(named: self.image.name, size: .large, completion: { (uiimage) -> () in
				
				if let img = uiimage {
					dispatch_async(dispatch_get_main_queue(), { () -> Void in
						self.imageView.image = img
						self.imageView2.image = img
						self.activityIndicatorView.stopAnimating()

						if self.image.exposure != 0 && self.image.iso != 0 {
							// Let's assume we have EXIF.
							
							let formatter = NSNumberFormatter()
							formatter.numberStyle = .DecimalStyle
							formatter.usesGroupingSeparator = false
							
							var exposure = self.image.exposure
							var exposureString = ""
							if exposure < 1.0 {
								exposure = 1.0 / exposure
								formatter.minimumFractionDigits = 2
								formatter.maximumFractionDigits = 2
								formatter.decimalSeparator = "."
								let s = formatter.stringFromNumber(NSNumber(double: exposure))!
								exposureString = "\(s)"
							} else {
								formatter.maximumFractionDigits = 0
								let s = formatter.stringFromNumber(NSNumber(double: exposure))!
								exposureString = "1/\(s)"
							}
							
							let exifString = "f/\(self.image.fstop), \(exposureString) sec, \(Int(self.image.iso)) ISO, \(Int(self.image.focal)) mm"
							
							self.exifLabel.text = exifString
						}
						
						self.nameLabel.text = "\(self.index + 1)/\(self.count)  \(self.image.user)"
						
						UIView.animateWithDuration(0.3, animations: { () -> Void in
							self.imageView.alpha = 1.0
							self.imageView2.alpha = 1.0
							self.exifLabel.alpha = 1.0
							self.nameLabel.alpha = 1.0
							self.activityIndicatorView.alpha = 0.0
						})
					})
				}
			})
		})
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
