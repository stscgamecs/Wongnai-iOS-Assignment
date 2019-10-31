//
//  TableViewMenuListCell.swift
//  Wongnai-iOS-Assignment
//
//  Created by Z94me on 30/10/2562 BE.
//  Copyright © 2562 Z94me. All rights reserved.
//

import UIKit

class TableViewMenuListCell: UITableViewCell {
    @IBOutlet weak var imageShow: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUi(Model:Photo){
         let result = String(format: "%ld %@", locale: Locale.current, Model.votesCount, "views")
        nameLabel.text = Model.name
        discriptionLabel.text = Model.description
        voteLabel.text = result
        if let url = URL(string: Model.images.first!.url){
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    self.imageShow.image = image
                }
            }
        }
    }
}
