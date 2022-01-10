//
//  ArticleCell.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func bind(element: ArticleModel) {
        cover.kf.setImage(with: element.imageUrl)
        title.text = element.title
    }
}
