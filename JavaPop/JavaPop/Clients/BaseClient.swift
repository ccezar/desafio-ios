//
//  BaseClient.swift
//  JavaPop
//
//  Created by Caio on 06/04/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit
import AFNetworking

public class BaseClient: NSObject {
    private let manager = AFHTTPSessionManager()
    private var url: String
    private var cached = false
    
    init(url: String) {
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.timeoutInterval = 60
        
        self.url = url
        
        super.init()
    }
    
    private func setupCache() {
        if AFNetworkReachabilityManager.shared().isReachable {
            cached = false
            manager.requestSerializer.cachePolicy = .reloadIgnoringLocalCacheData
        } else {
            cached = true
            manager.requestSerializer.cachePolicy = .returnCacheDataElseLoad
        }
    }
    
    func get(parameters: [String: AnyObject],
             headers: [NSObject: AnyObject]?,
             success: ((URLSessionDataTask, Any?) -> Void)?,
             failure: ((URLSessionDataTask, Any?) -> Void)?) {
        
        setupCache()
        
        if let headerParams = headers as? [String:AnyObject] {
            manager.requestSerializer.setValuesForKeys(headerParams)
        }
        
        manager.get(url,
                    parameters: parameters,
                    progress: nil,
                    success: {(task: URLSessionDataTask, responseObject: Any) -> Void in
                        if let success = success {
                            success(task, responseObject)
                        }
                    }, failure: {(task: URLSessionDataTask?, error: Error) in
                        if let failure = failure, let task = task {
                            failure(task, error)
                        }
                })
    }
}
