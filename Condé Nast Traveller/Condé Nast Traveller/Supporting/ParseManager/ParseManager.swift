//
//  ParseManager.swift
//  Condé Nast Traveller
//
//  Created by Naveen Kumar on 19/03/25.
//

import Foundation

protocol JsonParseManagerProtocols {
    
    func decriptMyData<T:Decodable>(
        input:Data,
        outPut:T.Type,
        onComplete:@escaping (Result<T,Error>)->())
    
}

class JsonParseManager : JsonParseManagerProtocols {
    
    static let shared = JsonParseManager()
    private init() {}
    
    
    func decriptMyData<T>(input: Data, outPut: T.Type, onComplete: @escaping (Result<T, any Error>) -> ()) where T : Decodable {
        
        do {
            let model = try JSONDecoder().decode(outPut, from: input)
            onComplete(.success(model))
        }
        catch let error {
            onComplete(.failure(error))
        }
    }

    
}
