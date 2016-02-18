//
//  FullscreenPhotoViewController.swift
//  mftv
//
//  Created by Emiel Lensink on 25/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import UIKit
import QxKit

class FullscreenPhotoViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

	var category:Category!
	var index:Int = 0
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.dataSource = self
		self.view.backgroundColor = UIColor.clearColor()
		
		setViewControllers([viewControllerForIndex(index)], direction: .Forward, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
		
		if let vc = viewController as? FullscreenImageViewController {
			let idx = vc.index - 1
			
			if idx >= 0 {
				return viewControllerForIndex(idx)
			}
		}
		
		return nil
	}
	
	func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

		if let vc = viewController as? FullscreenImageViewController {
			let idx = vc.index + 1
			
			if idx < category.images.count {
				return viewControllerForIndex(idx)
			}
		}
		
		return nil
	}
	
//	func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//		return category.images.count
//	}
//	
//	func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//		return index
//	}
	
	func viewControllerForIndex(idx:Int) -> UIViewController {
		
		let sb = UIStoryboard(name: "Main", bundle: nil)
		let vc = sb.instantiateViewControllerWithIdentifier("fullscreenImageViewController")
		
		if let ivc = vc as? FullscreenImageViewController {
			ivc.image = category.images[idx]
			ivc.index = idx
			ivc.count = category.images.count

			prefetchImageForIndex(idx)
			prefetchImageForIndex(idx - 1)
			prefetchImageForIndex(idx + 1)
		}
		
		return vc
	}
	
	func prefetchImageForIndex(idx:Int) {
		
		if idx >= 0 && idx < category.images.count {
		
			let image = category.images[idx]
			
			dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), { () -> Void in
				
				let service = JPEGImageService()
				service.loadImage(named: image.name, size: .large, completion: { (image) -> () in
					// Just load, don't do anything else.
				})
			})
		}
	}

}
