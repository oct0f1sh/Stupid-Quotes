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
    @IBOutlet weak var tableViewBackground: UIView!
    var groups = [Group]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func unwindToGroups(segue: UIStoryboardSegue) {
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addGroupButtonTapped(_ sender: Any) {
        self.showNewGroupAlert(completion: { (groupTitle) in
            if let groupTitle = groupTitle {
                GroupService.newGroup(user: User.current, groupName: groupTitle) { (key) in
                    self.getGroups()
                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getGroups()
    }
    
    func getGroups() {
        UserService.getUserGroups(uid: User.current.uid) { (groupList) in
            if let groupList = groupList {
                self.groups = groupList
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.tableViewBackground.roundCorners([.topLeft, .topRight], radius: Style.roundedCorner)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.section
            let quotesView = segue.destination as! QuotesViewController
            quotesView.group = groups[selectedRow]
        }
    }

}

extension GroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if User.current.uid == groups[indexPath.row].groupCreatorUID {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            print("delete tapped")
            
            self.confirmAlert(title: "Delete?", message: "Are you sure you want to delete this group? All quotes will be lost forever.") { (result) in
                if result {
                    let group = self.groups[indexPath.row]
                    
                    GroupService.deleteGroup(groupID: group.groupID) { () in
                        self.getGroups()
                    }
                } else {
                    print("group not deleted")
                }
            }
        }
    }
}

extension GroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = groups[indexPath.row]
        let cell: GroupCell = tableView.dequeueReusableCell()
        cell.groupNameLabel.text = group.groupName
        cell.memberCountLabel.text = String(group.usersInGroup.count)
        if group.usersInGroup.count == 1 {
            cell.membersLabel.text = "member"
        }
        QuoteService.getQuotes(groupID: group.groupID, completion: { (quotes) in
            if let quotes = quotes {
                cell.quotesCountLabel.text = String(quotes.count)
                if quotes.count == 1 {
                    cell.quotesLabel.text = "quote"
                }
            } else {
                cell.quotesCountLabel.text = "0"
            }
        })
        
        return cell
    }
}
