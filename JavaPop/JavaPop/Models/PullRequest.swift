//
//  PullRequest.swift
//  JavaPop
//
//  Created by Caio Cezar Lopes dos Santos on 4/5/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit
import Mantle

public class PullRequest: MTLModel, MTLJSONSerializing {
    var owner: Owner?
    var title: String?
    var date: Date?
    var body: String?
    var url: String?
    
    public static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [
            "owner": "owner",
            "title": "title",
            "date": "created_at",
            "body": "body",
            "url": "url"
        ]
    }
    
    static func ownerJSONTransformer() -> ValueTransformer! {
        return MTLJSONAdapter.dictionaryTransformer(withModelClass: Owner.self)
    }
    
}
