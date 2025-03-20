//
//  MainArticleViewModel.swift
//  Condé Nast Traveller
//
//  Created by Naveen Kumar on 19/03/25.
//

import Foundation


class MainArticleViewModel {
    
    var networkProtocol:NetworkManagerProtocols
    init(networkProtocol: NetworkManagerProtocols = NetworkManager.shared) {
        self.networkProtocol = networkProtocol
    }
    
    
    var topArticles:TopHeadlinesResponseModel?

    
    func getTheTopArticlesBusiness(category:String,
        onComplete:@escaping(Result<Bool,Error>)->()
    ){
        
        let url = ConvertAPIBase.business.convertUrl(withParameters: ["category":category])
        
        networkProtocol
            .getApiRequest(url: url) { [weak self](
                resp
            ) in
                guard self != nil else {
                    onComplete(.failure(NetworkErrors.dataNil))
                    return
                }
                switch resp {
                case .success(let data):
                    JsonParseManager.shared.decriptMyData(
                        input: data,
                        outPut: TopHeadlinesResponseModel.self) { [weak self] (resp) in
                            guard self != nil else {return}
                            switch resp {
                            case .success(let model):
                                self?.topArticles = model
                                onComplete(.success(true))
                                break
                                
                            case .failure(let error):
                                onComplete(.failure(error))
                                break
                                
                            }
                        }
                    
                case .failure(let error):
                    onComplete(.failure(error))
                    break
                }
                
            }
    }
}
