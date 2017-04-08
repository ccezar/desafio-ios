//
//  Repository.swift
//  JavaPop
//
//  Created by Caio Cezar Lopes dos Santos on 4/7/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import XCTest
import Mantle
@testable import JavaPop

class RepositoryTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitWithEmptyDictionaryShouldInitializeAttributesWithDefaultValues() {
        let repository = try? MTLJSONAdapter.model(of: Repository.self, fromJSONDictionary: [ : ])
        
        XCTAssertNotNil(repository)
        XCTAssertNil((repository as! Repository).owner)
        XCTAssertNil((repository as! Repository).name)
        XCTAssertNil((repository as! Repository).shortDescription)
        XCTAssertEqual((repository as! Repository).stars, 0)
        XCTAssertEqual((repository as! Repository).forks, 0)
        XCTAssertNil(((repository as! Repository).owner)?.login)
        XCTAssertNil(((repository as! Repository).owner)?.photoURL)
    }
    
    func testInitWithInvalidDictionaryShouldInitializeAttributesWithDefaultValues() {
        let repository = try? MTLJSONAdapter.model(of: Repository.self, fromJSONDictionary: ["ABCD": "EFGH"])
        
        XCTAssertNotNil(repository)
        XCTAssertNil((repository as! Repository).owner)
        XCTAssertNil((repository as! Repository).name)
        XCTAssertNil((repository as! Repository).shortDescription)
        XCTAssertEqual((repository as! Repository).stars, 0)
        XCTAssertEqual((repository as! Repository).forks, 0)
        XCTAssertNil(((repository as! Repository).owner)?.login)
        XCTAssertNil(((repository as! Repository).owner)?.photoURL)
    }
    
    func testInitWithValidDictionaryShouldInitializeAttributesCorrectly() {
        let repository = try? MTLJSONAdapter.model(of: Repository.self, fromJSONDictionary: ["name": "Test",
                                                                                             "description": "Bla bla bla",
                                                                                             "stargazers_count": 10,
                                                                                             "forks_count": 1,
                                                                                             "owner": ["login":"Test",
                                                                                                       "avatar_url":"https://avatars0.githubusercontent.com/u/655851?v=3"]
            ])

        XCTAssertNotNil(repository)
        XCTAssertNotNil((repository as! Repository).owner)
        
        XCTAssertEqual((repository as! Repository).name, "Test")
        XCTAssertEqual((repository as! Repository).shortDescription, "Bla bla bla")
        XCTAssertEqual((repository as! Repository).stars, 10)
        XCTAssertEqual((repository as! Repository).forks, 1)
        XCTAssertEqual(((repository as! Repository).owner)?.login, "Test")
        XCTAssertEqual(((repository as! Repository).owner)?.photoURL?.absoluteString, "https://avatars0.githubusercontent.com/u/655851?v=3")
    }
    
    func testInitWithDictionaryWithtoutNameShouldLeaveAttributeNil() {
        let repository = try? MTLJSONAdapter.model(of: Repository.self, fromJSONDictionary: ["description": "Bla bla bla",
                                                                                             "stargazers_count": 10,
                                                                                             "forks_count": 1,
                                                                                             "owner": ["login":"Test",
                                                                                                       "avatar_url":"https://avatars0.githubusercontent.com/u/655851?v=3"]])
        
        XCTAssertNotNil(repository)
        XCTAssertNotNil((repository as! Repository).owner)
        
        XCTAssertNil((repository as! Repository).name)
        XCTAssertEqual((repository as! Repository).shortDescription, "Bla bla bla")
        XCTAssertEqual((repository as! Repository).stars, 10)
        XCTAssertEqual((repository as! Repository).forks, 1)
        XCTAssertEqual(((repository as! Repository).owner)?.login, "Test")
        XCTAssertEqual(((repository as! Repository).owner)?.photoURL?.absoluteString, "https://avatars0.githubusercontent.com/u/655851?v=3")
    }
    
    func testInitWithDictionaryWithtoutDescriptionShouldLeaveAttributeNil() {
        let repository = try? MTLJSONAdapter.model(of: Repository.self, fromJSONDictionary: ["name": "Test",
                                                                                             "stargazers_count": 10,
                                                                                             "forks_count": 1,
                                                                                             "owner": ["login":"Test",
                                                                                                       "avatar_url":"https://avatars0.githubusercontent.com/u/655851?v=3"]])
        
        XCTAssertNotNil(repository)
        XCTAssertNotNil((repository as! Repository).owner)
        
        XCTAssertEqual((repository as! Repository).name, "Test")
        XCTAssertNil((repository as! Repository).shortDescription)
        XCTAssertEqual((repository as! Repository).stars, 10)
        XCTAssertEqual((repository as! Repository).forks, 1)
        XCTAssertEqual(((repository as! Repository).owner)?.login, "Test")
        XCTAssertEqual(((repository as! Repository).owner)?.photoURL?.absoluteString, "https://avatars0.githubusercontent.com/u/655851?v=3")
    }
    
    func testInitWithDictionaryWithtoutStarsShouldLeaveAttributeZero() {
        let repository = try? MTLJSONAdapter.model(of: Repository.self, fromJSONDictionary: ["name": "Test",
                                                                                             "description": "Bla bla bla",
                                                                                             "forks_count": 1,
                                                                                             "owner": ["login":"Test",
                                                                                                       "avatar_url":"https://avatars0.githubusercontent.com/u/655851?v=3"]])
        
        XCTAssertNotNil(repository)
        XCTAssertNotNil((repository as! Repository).owner)
        
        XCTAssertEqual((repository as! Repository).name, "Test")
        XCTAssertEqual((repository as! Repository).shortDescription, "Bla bla bla")
        XCTAssertEqual((repository as! Repository).stars, 0)
        XCTAssertEqual((repository as! Repository).forks, 1)
        XCTAssertEqual(((repository as! Repository).owner)?.login, "Test")
        XCTAssertEqual(((repository as! Repository).owner)?.photoURL?.absoluteString, "https://avatars0.githubusercontent.com/u/655851?v=3")
    }
    
    func testInitWithDictionaryWithtoutForksShouldLeaveAttributeZero() {
        let repository = try? MTLJSONAdapter.model(of: Repository.self, fromJSONDictionary: ["name": "Test",
                                                                                             "description": "Bla bla bla",
                                                                                             "stargazers_count": 10,
                                                                                             "owner": ["login":"Test",
                                                                                                       "avatar_url":"https://avatars0.githubusercontent.com/u/655851?v=3"]])
        
        XCTAssertNotNil(repository)
        XCTAssertNotNil((repository as! Repository).owner)
        
        XCTAssertEqual((repository as! Repository).name, "Test")
        XCTAssertEqual((repository as! Repository).shortDescription, "Bla bla bla")
        XCTAssertEqual((repository as! Repository).stars, 10)
        XCTAssertEqual((repository as! Repository).forks, 0)
        XCTAssertEqual(((repository as! Repository).owner)?.login, "Test")
        XCTAssertEqual(((repository as! Repository).owner)?.photoURL?.absoluteString, "https://avatars0.githubusercontent.com/u/655851?v=3")
    }
    
    func testInitWithDictionaryWithtoutOwnerShouldLeaveAttributeZero() {
        let repository = try? MTLJSONAdapter.model(of: Repository.self, fromJSONDictionary: ["name": "Test",
                                                                                             "description": "Bla bla bla",
                                                                                             "stargazers_count": 10,
                                                                                             "forks_count": 1])
        
        XCTAssertNotNil(repository)
        XCTAssertNil((repository as! Repository).owner)
        
        XCTAssertEqual((repository as! Repository).name, "Test")
        XCTAssertEqual((repository as! Repository).shortDescription, "Bla bla bla")
        XCTAssertEqual((repository as! Repository).stars, 10)
        XCTAssertEqual((repository as! Repository).forks, 1)
    }
}
