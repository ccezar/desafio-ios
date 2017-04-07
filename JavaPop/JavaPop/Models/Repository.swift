//
//  Repository.swift
//  JavaPop
//
//  Created by Caio Cezar Lopes dos Santos on 4/5/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit
import Mantle

public protocol RepositoryCollectionProtocol {
    func getRepositoriesSuccess()
    func getRepositoriesError(message: String)
}

public class RepositoryCollection: MTLModel, MTLJSONSerializing {
    var page = 1
    var items: [Repository]?
    var delegate: RepositoryCollectionProtocol?
    
    public override init!() {
        super.init()
    }
    
    init(delegate: RepositoryCollectionProtocol) {
        self.delegate = delegate
        super.init()
    }
    
    required public init!(coder: NSCoder!) {
        super.init(coder: coder)
    }
    
    required public init(dictionary dictionaryValue: [AnyHashable : Any]!) throws {
        try super.init(dictionary: dictionaryValue)
    }
    
    public static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [
            "items": "items"
        ]
    }
    
    static func itemsJSONTransformer() -> ValueTransformer! {
        return MTLJSONAdapter.arrayTransformer(withModelClass: Repository.self)
    }
    
    func loadData() {
        let client = RepositoryClient(delegate: self, page: page)
        client.getRepositories()
    }
    
    func loadNextPage() {
        page += 1
        let client = RepositoryClient(delegate: self, page: page)
        client.getRepositories()
    }
}

extension RepositoryCollection: RepositoryClientProtocol {
    public func getRepositoriesSuccess(data: [Repository]?) {
        if let data = data {
            if items == nil {
                items = [Repository]()
            }
            
            items?.append(contentsOf: data)
            delegate?.getRepositoriesSuccess()
        }
    }
    
    public func getRepositoriesError(message: String) {
        delegate?.getRepositoriesError(message: message)
    }
}

public class Repository: MTLModel, MTLJSONSerializing {
    var name: String?
    var fullName: String?
    var shortDescription: String?
    var stars: Int = 0
    var forks: Int = 0
    var owner: Owner?
    
    public static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [
            "name": "name",
            "fullName": "full_name",
            "shortDescription": "description",
            "stars": "stargazers_count",
            "forks": "forks_count",
            "owner": "owner"
        ]
    }
    
    static func ownerJSONTransformer() -> ValueTransformer! {
        return MTLJSONAdapter.dictionaryTransformer(withModelClass: Owner.self)
    }
}
