//
//  PullRequestViewController.swift
//  JavaPop
//
//  Created by Caio on 07/04/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit

class PullRequestsViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    // MARK: Properties
    fileprivate var collection: PullRequestCollection!
    var owner: String!
    var repository: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection = PullRequestCollection(delegate: self, owner: owner, repository: repository)
        collection.loadData()
    }
    
    // MARK: Methods
    func showMessage(_ message: String) {
        let actionSheetController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in }
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true, completion: nil)
    }
}

extension PullRequestsViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PullRequestCell
        cell.pullRequest = collection.items?[indexPath.item] ?? nil
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PullRequestCell
        if let url = cell.pullRequest?.url {
            UIApplication.shared.openURL(url)
        }
    }
}

extension PullRequestsViewController: PullRequestCollectionProtocol {
    func getPullRequestsSuccess() {
        summaryLabel.text = collection.getSummary()
        tableView.reloadData()
    }
    
    func getPullRequestsError(message: String) {
        showMessage(message)
    }
}
