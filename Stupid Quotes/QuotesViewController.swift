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
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
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
    
    @IBAction func inviteFriendsTapped(_ sender: Any) {
        self.showInviteFriendAlert(completion: { (friend) in
            if let friend = friend {
                if let group = self.group {
                    GroupService.addUserToGroup(groupID: group.groupID, username: friend, completion: { (result) in
                        if let result = result {
                            if result == "failure" {
                                self.showAlert(title: "Error", message: "User does not exist", actionText: "Ok")
                            }
                        }
                    })
                }
            }
        })
    }
}

extension QuotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if User.current.username == quotes[indexPath.row].author {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            print("delete tapped")
            
            self.confirmAlert(title: "Delete?", message: "Are you sure you want to delete this quote?") { (result) in
                if result {
                    let quote = self.quotes[indexPath.row]
                    
                    if let group = self.group {
                        QuoteService.deleteQuote(quote: quote, group: group) { () in
                            self.getQuotes()
                        }
                    }
                } else {
                    print("quote not deleted")
                }
            }
        }
    }
}

extension QuotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quote = quotes[indexPath.row]
        let cell: QuoteCell = tableView.dequeueReusableCell()
        
        cell.quoteTextView.delegate = self
        cell.quoteTextView.text = "\(quote.quote)"
        cell.subjectLabel.text = "\(quote.subject)"
        
        return cell
    }
}

extension QuotesViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
