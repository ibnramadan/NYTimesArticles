//
//  ArticleTableViewCell.swift
//  NYTimesArticles
//
//  Created by iMac on 17/01/2022.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    
    
     @IBOutlet weak var articleTitleL: UILabel!
     @IBOutlet weak var articleDateL: UILabel!
     @IBOutlet weak var articleImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        articleImageView.layer.cornerRadius = articleImageView.bounds.height / 2
        articleImageView.layer.masksToBounds = true

    }

     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)

         // Configure the view for the selected state
     }
     
     func setupCell(article : Article){
         articleTitleL.text = article.title
         articleDateL.text = article.published_date
         articleImageView.downloadFrom(url:  article.media?.first?.metadata?.first?.url ?? "")
     }

 }
