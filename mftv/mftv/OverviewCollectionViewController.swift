//
//  OverviewCollectionViewController.swift
//  mftv
//
//  Created by Emiel Lensink on 16/01/16.
//  Copyright © 2016 Emiel Lensink. All rights reserved.
//

import UIKit
import QxKit

private let reuseIdentifier = "OverviewImageCell"
private let headerIdentifier = "OverviewSectionHeader"

class OverviewCollectionViewController: UICollectionViewController {

	let dm = DataModel.sharedInstance
	var data:[Competition] = []
	var randomPhotoTimer:NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		dm.rootData { (success, data) -> () in
			if success {
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					self.setNewTimer()
					
					if data.count != self.data.count {
						self.data = data
						self.collectionView?.reloadData()
					}
				})
			}
		}
	}
	
	override func viewWillDisappear(animated: Bool) {
		randomPhotoTimer?.invalidate()
	}
	
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)

		if let configurableCell = cell as? ObjectConfigurable {
			configurableCell.configureWithObject(object:data[indexPath.row])
		}
		    
        return cell
    }

	override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
		
		// We don't care about the kind here, since we only expect header views here.
		let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerIdentifier, forIndexPath: indexPath)
		
		return view
	}
	
	// MARK: Navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		if segue.identifier == "DetailsSegue" {
			if let source = sender as? OverviewCollectionViewCell, dvc = segue.destinationViewController as? DetailsCollectionViewController, competition = source.configurableObject {
				
				dvc.competition = competition
			}
		}
	}
	
	// MARK: Timer for refreshing images
	func setNewTimer() {
		randomPhotoTimer?.invalidate()
		
		randomPhotoTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "timerFired:", userInfo: nil, repeats: false)
	}
	
	@objc func timerFired(timer:NSTimer) {
		
		dispatch_async(dispatch_get_main_queue()) { () -> Void in
			
			let cells = self.collectionView!.visibleCells()

			for cell in cells {
				if let c = cell as? OverviewCollectionViewCell {
					c.timerFired(timer)
				}
			}
			
			self.setNewTimer()
		}
	}
}
