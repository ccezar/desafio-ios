//
//  ViewController.swift
//  JavaPop
//
//  Created by Caio Cezar Lopes dos Santos on 4/5/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    
    // MARK: Properties
    fileprivate var collection: RepositoryCollection!
    
    override func viewWillAppear(_ animated: Bool) {
        menuButton.imageView?.image = menuButton.imageView?.image!.withRenderingMode(.alwaysTemplate)
        menuButton.imageView?.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection = RepositoryCollection(delegate: self)
        collection.loadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pullRequestsSegue" {
            if let vc = segue.destination as? PullRequestsViewController,
                let cell = sender as? RepositoryCell,
                let owner = cell.repository?.owner?.login,
                let repository = cell.repository?.name  {
                
                vc.owner = owner
                vc.repository = repository
            } else {
                // TODO: Cancel navigation and show exception message
            }
        }
    }

    // MARK: Methods
    func showMessage(_ message: String) {
        let actionSheetController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in }
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true, completion: nil)
    }
}

extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoryCell
        cell.repository = collection.items?[indexPath.item] ?? nil
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - 1000
        
        if (actualPosition >= contentHeight) {
            collection.loadNextPage()
        }
    }
}

extension RepositoriesViewController: RepositoryCollectionProtocol {
    func getRepositoriesSuccess() {
        tableView.reloadData()
    }
    
    func getRepositoriesError(message: String) {
        showMessage(message)
    }
}

