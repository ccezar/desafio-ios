//
//  JavaPopTests.swift
//  JavaPopTests
//
//  Created by Caio Cezar Lopes dos Santos on 4/5/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import XCTest
import Mantle
@testable import JavaPop

class OwnerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitWithEmptyDictionaryShouldInitializeAttributesWithDefaultValues() {
        let owner = try? MTLJSONAdapter.model(of: Owner.self, fromJSONDictionary: [ : ])
        
        XCTAssertNotNil(owner)
        XCTAssertNil((owner as! Owner).login)
        XCTAssertNil((owner as! Owner).photoURL)
    }
    
    func testInitWithValidDictionaryShouldInitializeAttributesCorrectly() {
        let owner = try? MTLJSONAdapter.model(of: Owner.self, fromJSONDictionary: ["login":"test",
                                                                                   "avatar_url":"https://avatars0.githubusercontent.com/u/655851?v=3"])
        
        XCTAssertNotNil(owner)
        XCTAssertEqual((owner as! Owner).login, "test")
        XCTAssertEqual((owner as! Owner).photoURL?.absoluteString, "https://avatars0.githubusercontent.com/u/655851?v=3")
    }
    
    func testInitWithDictionaryWithtoutLoginShouldLeaveAttributeNil() {
        let owner = try? MTLJSONAdapter.model(of: Owner.self, fromJSONDictionary: ["avatar_url":"https://avatars0.githubusercontent.com/u/655851?v=3"])
        
        XCTAssertNotNil(owner)
        XCTAssertNil((owner as! Owner).login)
        XCTAssertEqual((owner as! Owner).photoURL?.absoluteString, "https://avatars0.githubusercontent.com/u/655851?v=3")
    }
    
    func testInitWithDictionaryWithtoutPhotoShouldLeaveAttributeNil() {
        let owner = try? MTLJSONAdapter.model(of: Owner.self, fromJSONDictionary: ["login":"test"])
        
        XCTAssertNotNil(owner)
        XCTAssertEqual((owner as! Owner).login, "test")
        XCTAssertNil((owner as! Owner).photoURL)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
