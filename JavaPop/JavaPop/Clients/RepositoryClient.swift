//
//  RepositoryClient.swift
//  JavaPop
//
//  Created by Caio Cezar Lopes dos Santos on 4/6/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit
import Mantle

public protocol RepositoryClientProtocol {
    func getRepositoriesSuccess(data: [Repository]?)
    func getRepositoriesError(message: String)
}

public class RepositoryClient: BaseClient {
    var delegate: RepositoryClientProtocol?
    var page = 1
    
    init(delegate: RepositoryClientProtocol, page: Int) {
        self.page = page
        self.delegate = delegate
        
        super.init(url: Endpoint.repositories.rawValue)
    }
    
    func getRepositories() {
        let successBlock = {(task: URLSessionDataTask, responseObject: Any) -> Void in
            if let dictionary = responseObject as? [String : Any] {
                if let delegate = self.delegate {
                    let collection = try? MTLJSONAdapter.model(of: RepositoryCollection.self, fromJSONDictionary: dictionary)
                
                    if let collection = collection as? RepositoryCollection, let items = collection.items, items.count > 0 {
                        delegate.getRepositoriesSuccess(data: items)
                    } else {
                        delegate.getRepositoriesSuccess(data: nil)
                    }
                }
            }
        }
        
        let failureBlock = {(task: URLSessionDataTask, responseObject: Any) -> Void in
            if let delegate = self.delegate {
                delegate.getRepositoriesError(message: "Ocorreu um erro ao listar os repositórios.")
            }
        }
        
        let parameters: [String : Any] = ["q": "language:Java", "sort": "stars", "page": page]
        get(parameters: parameters as [String : AnyObject], headers: nil, success: successBlock, failure: failureBlock)
    }

}
