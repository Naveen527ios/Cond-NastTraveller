//
//  Conde__Nast_TravellerTests.swift
//  Condé Nast TravellerTests
//
//  Created by Naveen Kumar on 19/03/25.
//

import XCTest
@testable import Condé_Nast_Traveller

final class Conde__Nast_TravellerTests: XCTestCase {
    
    var viewModel: MainArticleViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        viewModel = MainArticleViewModel(networkProtocol: mockNetworkManager)
        
        
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    
    
    
    // Test case for successful API response and data parsing
       func testGetTheTopArticlesBusiness_Success() {
           // Arrange: Prepare mock data
           let mockData = """
           {
               "articles": [
                   {
                       "title": "Naveen Kumar",
                       "description": "Description for Naveen Kumar"
                   },
                   {
                       "title": "Kota",
                       "description": "Description for Kota"
                   }
               ]
           }
           """.data(using: .utf8)!
           
           mockNetworkManager.mockResponse = .success(mockData)
           let expectation = self.expectation(description: "Fetch top articles")
           
           viewModel.getTheTopArticlesBusiness(category: "business") { result in
               switch result {
               case .success(let model):
                   XCTAssertNotNil(model)
                   XCTAssertTrue(model, "its has to be True")
                   expectation.fulfill()
               case .failure(let error):
                   XCTFail("Expected success, but got error: \(error)")
               }
           }
           
           waitForExpectations(timeout: 2, handler: nil)
       }
       
       // Test case for failure in API request (network error)
       func testGetTheTopArticlesBusiness_NetworkFailure() {
           // Arrange: Prepare mock network failure
           mockNetworkManager.mockResponse = .failure(NetworkErrors.dataNil)
           
           // Act: Call the method
           let expectation = self.expectation(description: "Fetch top articles with network failure")
           
           viewModel.getTheTopArticlesBusiness(category: "business") { result in
               // Assert: Verify the failure case
               switch result {
               case .success:
                   XCTFail("Expected failure, but got success")
               case .failure(let error):
                   XCTAssertEqual(error as? NetworkErrors, NetworkErrors.dataNil)
                   expectation.fulfill()
               }
           }
           
           waitForExpectations(timeout: 2, handler: nil)
       }
       
       // Test case for failure in data decryption (parsing error)
       func testGetTheTopArticlesBusiness_ParsingFailure() {
           // Arrange: Prepare mock invalid data
           let mockData = """
           { "invalidKey": "Invalid data" }
           """.data(using: .utf8)!
           
           // Mock success response with invalid data
           mockNetworkManager.mockResponse = .success(mockData)
           
           // Act: Call the method
           let expectation = self.expectation(description: "Fetch top articles with parsing failure")
           
           viewModel.getTheTopArticlesBusiness(category: "business") { result in
               // Assert: Verify the failure case
               switch result {
               case .success:
                   XCTFail("Expected failure, but got success")
               case .failure(let error):
                   XCTAssertNotNil(error)
                   expectation.fulfill()
               }
           }
           
           waitForExpectations(timeout: 2, handler: nil)
       }
    
    
    
}
