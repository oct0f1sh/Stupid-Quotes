//
//  GroupsViewController.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class GroupsViewController: UIViewController {
    var quotes = [Quote]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        QuoteService.getQuotes(groupID: "0", completion: { (quotes) in
            if let quotes = quotes {
                self.quotes = quotes
            }
        })
    }
}

extension GroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
}

extension GroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quote = quotes[indexPath.row]
        let cell: QuoteCell = tableView.dequeueReusableCell()
        cell.quoteLabel.text = quote.quote
        cell.usernameLabel.text = quote.author
        
        return cell
    }
}
