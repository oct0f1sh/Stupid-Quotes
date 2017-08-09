//
//  QuotesViewController.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/9/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class QuotesViewController: UIViewController {
    @IBOutlet weak var tableViewBackground: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var quotes = [Quote]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var group: Group?
    
    override func viewDidLoad() {
        getQuotes()
    }
    
    func getQuotes() {
        if let group = group {
            QuoteService.getQuotes(groupID: group.groupID) { (gatheredQuotes) in
                if let gatheredQuotes = gatheredQuotes {
                    self.quotes = gatheredQuotes
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.tableViewBackground.roundCorners([.topLeft, .topRight], radius: Style.roundedCorner)
    }
}

extension QuotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
}

extension QuotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quote = quotes[indexPath.row]
        let cell: QuoteCell = tableView.dequeueReusableCell()
        
        cell.quoteTextView.text = quote.quote
        cell.subjectLabel.text = "-\(quote.subject)"
        cell.usernameLabel.text = quote.author
        
        return cell
    }
}
