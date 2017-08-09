//
//  UITableView+Cell.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/8/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

protocol CellIdentifiable {
    static var cellIdentifier: String { get }
}

extension CellIdentifiable where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: CellIdentifiable { }

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: CellIdentifiable {
        guard let cell = dequeueReusableCell(withIdentifier: T.cellIdentifier) as? T else {
            fatalError("Error dequeueing cell for identifier \(T.cellIdentifier)")
        }
        return cell
    }
}
