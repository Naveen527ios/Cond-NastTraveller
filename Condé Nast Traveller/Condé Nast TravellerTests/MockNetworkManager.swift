//
//  MockNetworkManager.swift
//  Condé Nast TravellerTests
//
//  Created by Naveen Kumar on 21/03/25.
//

import Foundation
@testable import Condé_Nast_Traveller

class MockNetworkManager :NetworkManagerProtocols {
    
    var mockResponse: Result<Data, Error>?

    func getApiRequest(
        url: URL,
        onComplete: @escaping (Result<Data, any Error>) -> ()
    ) {
        
        if let response = mockResponse {
            onComplete(response)
        }
    }

    
}
