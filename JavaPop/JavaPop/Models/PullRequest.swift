//
//  PullRequest.swift
//  JavaPop
//
//  Created by Caio Cezar Lopes dos Santos on 4/5/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit
import Mantle
import Caterpillar


public class PullRequestCollection: MTLModel, MTLJSONSerializing {
    var items: [PullRequest]?
    
    public static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [
            "items": "items"
        ]
    }
    
    static func itemsJSONTransformer() -> ValueTransformer! {
        return MTLJSONAdapter.arrayTransformer(withModelClass: PullRequest.self)
    }
}

public class PullRequest: MTLModel, MTLJSONSerializing {
    var owner: Owner?
    var title: String?
    var date: Date?
    var body: String?
    var url: URL?
    
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
    
    static func urljsonTransformer() -> ValueTransformer! {
        return ValueTransformer.init(forName: NSValueTransformerName(rawValue: MTLURLValueTransformerName))
    }
    
    static func dateJSONTransformer() -> ValueTransformer! {
        let _forwardBlock: MTLValueTransformerBlock? = { (value, success, error) in
            return self.dateFormatter().date(from: value as! String)
        }
        let _reverseBlock: MTLValueTransformerBlock? = { (value, success, error) in
            return self.dateFormatter().string(from: value as! Date)
        }
        
        return MTLValueTransformer.init(usingForwardBlock: _forwardBlock, reverse: _reverseBlock)
    }
    
    static func dateFormatter() -> DateFormatter {
        let format = Caterpillar()
            .year(.fourDigits)
            .separator(.dash)
            .month(.zeroPaddedNumber)
            .separator(.dash)
            .day(.zeroPaddedNumber)
            .string("T")
            .hour(.zeroPaddedTwentyFourHour)
            .separator(.colon)
            .minute(.zeroPaddedNumber)
            .separator(.colon)
            .second(.zeroPaddedNumber)
            .timezone(.RFC822)
        
        let formatter = DateFormatter()
        formatter.setDateFormat(format)
        
        return formatter
    }
}
