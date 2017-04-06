//
//  Enum.swift
//  JavaPop
//
//  Created by Caio on 06/04/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit

enum Endpoint : String {
    case repositories = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page={page}",
    pullRequest = "https://api.github.com/repos/{owner}/{repository}/pulls"
}
