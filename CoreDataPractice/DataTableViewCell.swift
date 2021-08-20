//
//  DataTableViewCell.swift
//  CoreDataPractice
//
//  Created by Zoom Digital on 12/08/2021.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
