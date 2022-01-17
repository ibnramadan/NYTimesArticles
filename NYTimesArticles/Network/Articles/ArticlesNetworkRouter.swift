//
//  ArticlesNetworkRouter.swift
//  NYTimesArticles
//
//  Created by iMac on 17/01/2022.
//


import Foundation
import Alamofire

enum ArticlesNetworkRouter: URLRequestConvertible {
    
    case getArticles
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch  self {
            case .getArticles :
                return .get
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
           case .getArticles :
            return nil
        }
        }()
        
        let custonHeaders: ([String: String]?) = {
            switch self {
            case .getArticles :
                return nil
            }
        }()

        let headers = NetworkConstants.generalAppHeaders.merging(custonHeaders ?? [:]) { (_, k2) -> String in
            return k2
        }
        
        let url: URL = {
            switch self {
            case .getArticles:
                return URL(string: NetworkConstants.EndPoints.articles)!
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.allHTTPHeaderFields = headers
        
        let encoding: ParameterEncoding = {
            return JSONEncoding.default
        }()
        
        return try! encoding.encode(urlRequest, with: params)
    }
    
    
}




