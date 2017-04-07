//
//  RepositoryClient.swift
//  JavaPop
//
//  Created by Caio Cezar Lopes dos Santos on 4/6/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit
import Mantle

public protocol PullRequestClientProtocol {
    func getPullRequestsSuccess(data: [PullRequest]?)
    func getPullRequestsError(message: String)
}

public class PullRequestClient: BaseClient {
    var delegate: PullRequestClientProtocol?
    var owner: String?
    var repository: String?
    
    init(delegate: PullRequestClientProtocol, owner: String, repository: String) {
        self.owner = owner
        self.repository = repository
        self.delegate = delegate
        
        let finalURL = Endpoint.pullRequest.rawValue.replacingOccurrences(of: "{owner}", with: "\(owner)")
                                                    .replacingOccurrences(of: "{repository}", with: "\(repository)")
        super.init(url: finalURL)
    }
    
    func getPullRequests() {
        let successBlock = {(task: URLSessionDataTask, responseObject: Any) -> Void in
            if let delegate = self.delegate {
                let dictionary = ["items": responseObject]
                let collection = try? MTLJSONAdapter.model(of: PullRequestCollection.self, fromJSONDictionary: dictionary)
            
                if let collection = collection as? PullRequestCollection, let items = collection.items, items.count > 0 {
                    delegate.getPullRequestsSuccess(data: items)
                } else {
                    delegate.getPullRequestsSuccess(data: nil)
                }
            }
        }
        
        let failureBlock = {(task: URLSessionDataTask, responseObject: Any) -> Void in
            if let delegate = self.delegate {
                delegate.getPullRequestsError(message: "Ocorreu um erro ao listar os pull requests.")
            }
        }
        
        get(parameters: [:], headers: nil, success: successBlock, failure: failureBlock)
    }

}
