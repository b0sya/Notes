//
//  NotesTableViewCell.swift
//  Notes
//
//  Created by b0ysa on 19/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

@IBDesignable
class NotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var noteText: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    private let cornerRadius: CGFloat = 13

    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.cornerRadius = cornerRadius
        colorView.layer.borderWidth = 0.2
        colorView.layer.borderColor = UIColor.black.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
