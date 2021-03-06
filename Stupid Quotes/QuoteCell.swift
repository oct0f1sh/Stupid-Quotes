//
//  QuoteCell.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class QuoteCell: UITableViewCell {
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var subjectLabel: UILabel!
    
    override func awakeFromNib() {
        self.quoteTextView.textContainer.lineFragmentPadding = 0
        self.quoteTextView.textContainerInset = UIEdgeInsets.zero
    }
}
