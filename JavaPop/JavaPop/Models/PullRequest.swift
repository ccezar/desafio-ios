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

public protocol PullRequestCollectionProtocol {
    func getPullRequestsSuccess()
    func getPullRequestsError(message: String)
}

public class PullRequestCollection: MTLModel, MTLJSONSerializing {
    var owner: String?
    var repository: String?
    var items: [PullRequest]?
    var delegate: PullRequestCollectionProtocol?
    
    public override init!() {
        super.init()
    }
    
    init(delegate: PullRequestCollectionProtocol, owner: String, repository: String) {
        self.delegate = delegate
        self.owner = owner
        self.repository = repository
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
        return MTLJSONAdapter.arrayTransformer(withModelClass: PullRequest.self)
    }
    
    func loadData() {
        if let owner = owner, let repository = repository {
            let client = PullRequestClient(delegate: self, owner: owner, repository: repository)
            client.getPullRequests()
        } else {
            // TODO: Throw error message
        }
    }
    
    func getSummary() -> NSAttributedString {
        let openedCount = items?.filter{ $0.state == "open" }.count ?? 0
        let closedCount = items?.filter{ $0.state == "closed" }.count ?? 0
        
        let openedString = "\(openedCount) opened"
        let openedAttrString = NSMutableAttributedString(string: openedString,
                                                         attributes: [NSForegroundColorAttributeName: UIColor(netHex: 0xDD9225)])
        
        let closedString = " / \(closedCount) closed"
        let closedAttrString = NSAttributedString(string: closedString,
                                                  attributes: [NSForegroundColorAttributeName: UIColor.black,
                                                               NSFontAttributeName: UIFont.boldSystemFont(ofSize: 11)])
        
        openedAttrString.append(closedAttrString)
        
        return openedAttrString
    }
}

extension PullRequestCollection: PullRequestClientProtocol {
    public func getPullRequestsSuccess(data: [PullRequest]?) {
        if let data = data {
            if items == nil {
                items = [PullRequest]()
            }
            
            items?.append(contentsOf: data)
        }
        
        delegate?.getPullRequestsSuccess()
    }
    
    public func getPullRequestsError(message: String) {
        delegate?.getPullRequestsError(message: message)
    }
}

public class PullRequest: MTLModel, MTLJSONSerializing {
    var user: Owner?
    var title: String?
    var date: Date?
    var body: String?
    var url: URL?
    var state: String?
    
    public static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [
            "user": "user",
            "title": "title",
            "date": "created_at",
            "body": "body",
            "url": "html_url",
            "state": "state"
        ]
    }
    
    static func userJSONTransformer() -> ValueTransformer! {
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
