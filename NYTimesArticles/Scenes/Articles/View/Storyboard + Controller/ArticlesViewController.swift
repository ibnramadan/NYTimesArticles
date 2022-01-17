//
//  ArticlesViewController.swift
//  NYTimesArticles
//
//  Created by iMac on 17/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ArticlesViewController: UIViewController {

    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var articlesContainerView: UIView!
    
    let articleTableViewCell = "ArticleTableViewCell"
    let articlesViewModel = ArticlesViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToArticleSelection()
        setupTableView()
        bindToHiddenTable()
        subscribeToLoading()
        subscribeToResponse()
        getArticles()
        
    }
    func setupTableView() {
        
        articlesTableView.register(UINib(nibName: articleTableViewCell, bundle: nil), forCellReuseIdentifier: articleTableViewCell)
    }
    func bindToHiddenTable() {
        articlesViewModel.isTableHiddenObservable.bind(to: self.articlesContainerView.rx.isHidden).disposed(by: disposeBag)
    }
    func subscribeToLoading() {
        articlesViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToResponse() {
        self.articlesViewModel.articlesModelObservable
            .bind(to: self.articlesTableView
                .rx
                .items(cellIdentifier: articleTableViewCell,
                       cellType: ArticleTableViewCell.self)) { row, article, cell in
                        print(row)
                        cell.setupCell(article : article)
        }
        .disposed(by: disposeBag)
    }
    func subscribeToArticleSelection() {
        Observable
            .zip(articlesTableView.rx.itemSelected, articlesTableView.rx.modelSelected(Article.self))
            .bind { [weak self] selectedIndex, article in
                print(selectedIndex, article.title ?? "")
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let articleDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as! ArticleDetailsViewController
                articleDetailsViewController.article = article
                self?.navigationController?.pushViewController(articleDetailsViewController, animated:true)
        }
        .disposed(by: disposeBag)
    }
    func getArticles() {
        articlesViewModel.getData()
    }
}
