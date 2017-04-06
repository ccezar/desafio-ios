//
//  Repository.swift
//  JavaPop
//
//  Created by Caio Cezar Lopes dos Santos on 4/5/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit
import Mantle

public class Repository: MTLModel, MTLJSONSerializing {
    var name: String?
    var shortDescription: String?
    var stars: Int = 0
    var forks: Int = 0
    var owner: Owner?
    
    public static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [
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
