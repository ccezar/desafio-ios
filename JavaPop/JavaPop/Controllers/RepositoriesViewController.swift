//
//  ViewController.swift
//  JavaPop
//
//  Created by Caio Cezar Lopes dos Santos on 4/5/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit
import Mantle

class RepositoriesViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    fileprivate var repositories: [Repository] = []
    fileprivate var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: Methods
    func loadData() {
        let client = RepositoryClient(delegate: self, page: page)
        client.getRepositories()
    }
    
    func showMessage(_ message: String) {
        let actionSheetController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in }
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true, completion: nil)
    }
}

extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoryCell
        cell.repository = repositories[indexPath.item]
        
        return cell
    }
}

extension RepositoriesViewController: RepositoryClientProtocol {
    func getRepositoriesSuccess(data: [Repository]?) {
        if let data = data {
            repositories = data
            tableView.reloadData()
        }
    }
    
    func getRepositoriesError(message: String) {
        showMessage(message)
    }
}

