//
//  PullRequestCell.swift
//  JavaPop
//
//  Created by Caio on 07/04/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit

class PullRequestCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var pullRequest: PullRequest? {
        didSet {
            titleLabel.text = pullRequest?.title ?? ""
            bodyLabel.text = pullRequest?.body ?? ""
            loginLabel.text = pullRequest?.user?.login ?? ""
            fullNameLabel.text = ""
            userImageView.downloadedFrom(url: pullRequest?.user?.photoURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
