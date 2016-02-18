//
//  DataProvider.swift
//  QxKit
//
//  Created by Emiel Lensink on 01/02/16.
//
//

import Foundation

public enum DataProviderDataStatus {
	case new
	case changed
	case unchanged
	case failed
	case empty
}

public enum DataProviderProgress {
	case began
	case completed
}

public protocol DataProvider: class {
	
	typealias ProviderDataType
	
	func requestDataWithParameters(parameters:[String:String], completion:(data:ProviderDataType?, status:DataProviderDataStatus, error:NSError?) -> (), progress:(progress:DataProviderProgress) -> ())
}
