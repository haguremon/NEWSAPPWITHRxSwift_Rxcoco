//
//  Article.swift
//  NEWSAPPWITHRxSwift_Rxcoco
//
//  Created by IwasakIYuta on 2022/01/12.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}

extension ArticlesList {
    
    static var all: Resource<ArticlesList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=jp&apiKey=\(apikey)")!
        return Resource(url: url)
    }()
    
}

struct Article: Decodable {
    let title: String
    let description: String?
}
