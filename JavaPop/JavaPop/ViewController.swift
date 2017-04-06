//
//  ViewController.swift
//  JavaPop
//
//  Created by Caio Cezar Lopes dos Santos on 4/5/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let owner = try? Owner(dictionary: ["login":"Caio", "avatar_url":"https://avatars0.githubusercontent.com/u/655851?v=3"])
        print(owner?.login ?? "VAZIO")
        print(owner?.photoURL ?? "VAZIO")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

