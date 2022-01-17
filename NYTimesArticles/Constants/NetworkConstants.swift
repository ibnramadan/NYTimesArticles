//
//  NetworkConstants.swift
//  NYTimesArticles
//
//  Created by iMac on 17/01/2022.
//

import Foundation

enum NetworkConstants {
    static var generalAppHeaders : [String : String] {
        return [
            "Accept" : "application/json",
            ].compactMapValues { $0 }
    }
    static var baseUrl = "https://api.nytimes.com/"

    enum EndPoints {
        static let articles = baseUrl + "svc/mostpopular/v2/viewed/7.json?api-key=mjaNQfbKiQk3oBhuZX0okH5jnHgnhc1y"
    }
}
