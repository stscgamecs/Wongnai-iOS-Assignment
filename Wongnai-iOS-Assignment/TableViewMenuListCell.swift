//
//  TableViewMenuListCell.swift
//  Wongnai-iOS-Assignment
//
//  Created by Z94me on 30/10/2562 BE.
//  Copyright © 2562 Z94me. All rights reserved.
//

import UIKit

var imageCache: [String: UIImage] = [:]
class TableViewMenuListCell: UITableViewCell {
    @IBOutlet weak var imageShow: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUi(Model:Photo) {
         let votesCount = String(format: "%ld %@",
                                 locale: Locale.current,
                                 Model.positive_votes_count,"")
        nameLabel.text = Model.name
        discriptionLabel.text = Model.description
        voteLabel.text = votesCount
        
        guard let urlImage = Model.image_url.first else {
            return
        }
        if let image = imageCache[urlImage] {
          imageShow.image = image
        } else if let url = URL(string: urlImage) {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    imageCache[urlImage] = image
                    self.imageShow.image = image
                }
            }
        }
    }
}
