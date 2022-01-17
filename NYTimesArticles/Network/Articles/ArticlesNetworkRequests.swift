//
//  ArticlesNetworkRequests.swift
//  NYTimesArticles
//
//  Created by iMac on 17/01/2022.
//

import Foundation
import ObjectMapper
import Alamofire

protocol ArticlesNetworkRequests {
    func getArticles(completionHandler: @escaping (AFResult<Response<Article>?>) -> Void)
}

class ArticlesNetworkRequestsImplementation: ArticlesNetworkRequests {
  
    func getArticles(completionHandler: @escaping (AFResult<Response<Article>?>) -> Void) {
        let request = ArticlesNetworkRouter.getArticles
        AF.request(request).responseJSON { response in
            switch response.result {
            case let .success(value):
                let response = Mapper<Response<Article>>().map(JSON: value as! [String:Any])
                completionHandler(.success(response))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
        
    }
    
   
}






