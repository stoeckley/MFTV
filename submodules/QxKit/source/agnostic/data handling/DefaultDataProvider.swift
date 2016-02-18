//
//  GenericDataProvider.swift
//  QxKit
//
//  Created by Emiel Lensink on 01/02/16.
//
//

import Foundation

//class DefaultDataProvider<T>: DataProvider {
//	
//	typealias ProviderDataType = T
//	
//	var service = DataService<T, NSError>()
//	
//	func requestDataWithParameters(parameters:[String:String], completion:(data:[T], status:DataProviderDataStatus, error:NSError?) -> (), progress:(progress:DataProviderProgress) -> ()) {
//		
//		progress(progress: .began)
//		
//		service.request(response: { (data) -> () in
//			
//			progress(progress: .completed)
//			completion(data: data, status: .new, error: nil)
//		
//		}, failure: { (response, error) -> () in
//			
//			progress(progress: .completed)
//			completion(data: [], status: .failed, error: error)
//		
//		}, parameters: parameters)
//		
//	}
//}
