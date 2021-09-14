//
//  CategoryHeader.swift
//  Rappiering
//
//  Created by Nivardo Ibarra on 9/10/21.
//

import UIKit

final class CategoryHeader: UITableViewHeaderFooterView {
    
    // MARK: - Outlets
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setTitle(_ title: String) {
        categoryName.text = title
    }
}
