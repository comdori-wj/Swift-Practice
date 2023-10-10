//
//  TableViewCell.swift
//  tableView
//
//  Created by Wonji Ha on 2023/10/10.
//

import UIKit

class TableViewCell: UITableViewCell {
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse() // 셀 초기화
        backgroundColor = .systemBackground
        detailTextLabel?.text = "Detail"
        
    }

}
