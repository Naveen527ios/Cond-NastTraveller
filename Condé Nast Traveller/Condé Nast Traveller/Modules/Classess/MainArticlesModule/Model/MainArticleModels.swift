//
//  MainArticleModels.swift
//  Condé Nast Traveller
//
//  Created by Naveen Kumar on 19/03/25.
//

import Foundation

// MARK: - TopHeadlinesResponseModel
struct TopHeadlinesResponseModel: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

// MARK: - Article
struct Article: Decodable {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

// MARK: - Source
struct Source: Decodable {
    var id: String?
    var name: String?
}



enum AvailableCategory : String {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"

}
