//
//  ViewController.swift
//  JavaPop
//
//  Created by Caio Cezar Lopes dos Santos on 4/5/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit
import Mantle

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let owner = try? MTLJSONAdapter.model(of: Owner.self, fromJSONDictionary: ["login":"Caio", "avatar_url":"https://avatars0.githubusercontent.com/u/655851?v=3"])
        
        if let owner = owner as? Owner {
            print(owner.login ?? "VAZIO")
            print(owner.photoURL ?? "VAZIO")
        }
    
        let repository = try? MTLJSONAdapter.model(of: Repository.self, fromJSONDictionary: ["name": "Test", "description": "Bla bla bla", "stargazers_count": 10, "forks_count": 1, "owner": ["login":"Caio", "avatar_url":"https://avatars0.githubusercontent.com/u/655851?v=3"]])
        
        if let repository = repository as? Repository {
            print(repository.name ?? "VAZIO")
            print(repository.shortDescription ?? "VAZIO")
            print(repository.stars)
            print(repository.forks)
            print(repository.owner?.photoURL ?? "VAZIO")
        }
        
        let pullRequest = try? MTLJSONAdapter.model(of: PullRequest.self, fromJSONDictionary: ["owner": ["login":"Caio",
                                                                                                         "avatar_url":"https://avatars0.githubusercontent.com/u/655851?v=3"],
                                                                                               "title": "Test",
                                                                                               "created_at": "2011-01-26T19:06:43Z",
                                                                                               "body": "bla bla bla body",
                                                                                               "url": "http://uol.com.br"])
        
        if let pullRequest = pullRequest as? PullRequest {
            print(pullRequest.date ?? "VAZIO")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

