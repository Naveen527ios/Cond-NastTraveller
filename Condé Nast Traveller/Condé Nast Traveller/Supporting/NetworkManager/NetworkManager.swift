//
//  NetworkManager.swift
//  Condé Nast Traveller
//
//  Created by Naveen Kumar on 19/03/25.
//

import Foundation

enum NetworkErrors:String, Error {
    case invalidUrl = "url is not valid."
    case badRequest = "request not valid."
    case parseError = "can't able to parse the response."
    case dataNil = "data not available."
}

protocol NetworkManagerProtocols {
    func getApiRequest(
        url:URL,
        onComplete:@escaping(Result<Data,Error>)->())
}

class NetworkManager : NetworkManagerProtocols {
    
    static let shared = NetworkManager()
    private init() {}
    
    func getApiRequest(
        url: URL,
        onComplete: @escaping (Result<Data, any Error>) -> ()) {
            
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request){ (data,response,error) in
                
                guard let res = response as? HTTPURLResponse , res.statusCode == 200 else {
                    onComplete(.failure(NetworkErrors.badRequest))
                    return
                }
                
                guard let data = data  else {
                    onComplete(.failure(NetworkErrors.dataNil))
                    return
                    
                }
                
                onComplete(.success(data))
                
            }.resume()
    }
    
}
