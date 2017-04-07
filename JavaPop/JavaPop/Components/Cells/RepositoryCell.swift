//
//  RepositoryCell.swift
//  JavaPop
//
//  Created by Caio Cezar Lopes dos Santos on 4/6/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!

    @IBOutlet weak var forksImageView: UIImageView!
    @IBOutlet weak var starsImageView: UIImageView!

    var repository: Repository? {
        didSet {
            nameLabel.text = repository?.name ?? ""
            fullNameLabel.text = repository?.fullName ?? ""
            descriptionLabel.text = repository?.shortDescription ?? ""
            forksLabel.text = "\(repository?.forks ?? 0)"
            starsLabel.text = "\(repository?.stars ?? 0)"
            loginLabel.text = repository?.owner?.login ?? ""
            userImageView.downloadedFrom(url: repository?.owner?.photoURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        forksImageView.image = forksImageView.image!.withRenderingMode(.alwaysTemplate)
        forksImageView.tintColor = UIColor(netHex: 0xdd9225)
        
        starsImageView.image = starsImageView.image!.withRenderingMode(.alwaysTemplate)
        starsImageView.tintColor = UIColor(netHex: 0xdd9225)
    }
}
