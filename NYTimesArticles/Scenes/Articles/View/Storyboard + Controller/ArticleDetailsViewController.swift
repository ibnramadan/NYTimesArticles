//
//  ArticleDetailsViewController.swift
//  NYTimesArticles
//
//  Created by iMac on 18/01/2022.
//

import UIKit

class ArticleDetailsViewController: UIViewController {

    @IBOutlet weak var articleTitleL: UILabel!
    @IBOutlet weak var articleAbstractL: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var article : Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind(article : self.article)
    }
     
     func bind(article : Article){
         articleTitleL.text = article.title
         articleAbstractL.text = article.abstract
         articleImageView.downloadFrom(url:  article.media?.first?.metadata?.last?.url ?? "")
     }
}
