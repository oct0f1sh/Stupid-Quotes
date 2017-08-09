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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
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
}

extension GroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
}

extension GroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = groups[indexPath.row]
        let cell: GroupCell = tableView.dequeueReusableCell()
        cell.groupNameLabel.text = group.groupName
        cell.memberCountLabel.text = String(group.usersInGroup.count)
        
        return cell
    }
}
