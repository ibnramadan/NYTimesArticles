//
//  ArticlesViewModel.swift
//  NYTimesArticles
//
//  Created by iMac on 17/01/2022.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

class ArticlesViewModel {
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    private var articlesModelSubject = PublishSubject<[Article]>()
    
    var articlesModelObservable: Observable<[Article]> {
        return articlesModelSubject
    }
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    private let ArticlesNetwork: ArticlesNetworkRequests = ArticlesNetworkRequestsImplementation()
    
    func getData() {
        loadingBehavior.accept(true)
        ArticlesNetwork.getArticles { [weak self] (response) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            switch response {
            case let .success(result) where result?.status == "OK":
                
                guard let articlesModel = result?.results else { return }
                if articlesModel.count > 0 {
                    self.articlesModelSubject.onNext(articlesModel)
                    self.isTableHidden.accept(false)
                } else {
                    self.isTableHidden.accept(true)
                }
            case let .success(result):
                print(result?.fault?.faultstring ?? "Error")
              //  self.showHint(message: result?.message ?? "Error")
            case let .failure(error) :
                print(error.localizedDescription)
               // self.showHint(message: "Error")
            }
        }
    }
  
}

