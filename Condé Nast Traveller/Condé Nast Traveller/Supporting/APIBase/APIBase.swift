//
//  APIBase.swift
//  Condé Nast Traveller
//
//  Created by Naveen Kumar on 19/03/25.
//

import Foundation

protocol NetworkUrl{
    
    func convertUrl(withParameters parameters: [String: String])-> URL
}

struct BaseAPI {
    static let baseURLString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=b14847fbf1964b59ada46948c2f94175"
    
}
enum ConvertAPIBase  {
    case business
}

extension ConvertAPIBase: NetworkUrl {
    func convertUrl(withParameters parameters: [String: String]) -> URL {
        var urlString = BaseAPI.baseURLString

        switch self {
        case .business :
            if let category = parameters["category"] {
                urlString += "&category=\(category)"
            }
            return URL(string:urlString)!
            
        }
        
    }
}
