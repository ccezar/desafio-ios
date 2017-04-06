//
//  Owner.swift
//  JavaPop
//
//  Created by Caio Cezar Lopes dos Santos on 4/5/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit
import Mantle

public class Owner: MTLModel, MTLJSONSerializing {
    var login: String?
    var photoURL: URL?
    
    public static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [
            "login": "login",
            "photoURL": "avatar_url"
        ]
    }
    
    public static func photoURLjsonTransformer() -> ValueTransformer! {
        return ValueTransformer.init(forName: NSValueTransformerName(rawValue: MTLURLValueTransformerName))
    }
}
