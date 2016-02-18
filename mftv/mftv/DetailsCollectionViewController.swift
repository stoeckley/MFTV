//
//  DetailsCollectionViewController.swift
//  mftv
//
//  Created by Emiel Lensink on 22/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import Foundation
import UIKit
import QxKit

private let reuseIdentifier = "DetailsImageCell"
private let headerIdentifier = "DetailsSectionHeader"

class DetailsCollectionViewController: UICollectionViewController {

	var competition:Competition!
	var counts:[Int] = []
	
	override func viewDidLoad() {
		competition.categories = []
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		if competition.categories.count == 0 {
			competition.categoryData(response: { (success, data) -> () in
				
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					self.collectionView?.reloadData()
				})
				
			})
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: UICollectionViewDataSource
	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return competition.categories.count
	}
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return competition.categories[section].images.count
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
		
		if let configurableCell = cell as? ObjectConfigurable {
			
			let category = competition.categories[indexPath.section]
			let photo = category.images[indexPath.row]
			
			configurableCell.configureWithObject(object:photo)
		}
		
		return cell
	}
	
	override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
		
		// We don't care about the kind here, since we only expect header views here.
		let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerIdentifier, forIndexPath: indexPath)
		
		if let configurableView = view as? ObjectConfigurable {
			configurableView.configureWithObject(object:competition.categories[indexPath.section])
		}
		
		return view
	}
		
	// MARK: Navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		if segue.identifier == "FullscreenSegue" {
			if let dvc = segue.destinationViewController as? FullscreenPhotoViewController {
				
				let paths = collectionView?.indexPathsForSelectedItems()
				
				if let p = paths {
					if p.count > 0 {
						let path = p[0]
						let row = path.row
						let section = path.section
						
						dvc.index = row
						dvc.category = competition.categories[section]
						
					}
				}
			}
		}
	}
}
