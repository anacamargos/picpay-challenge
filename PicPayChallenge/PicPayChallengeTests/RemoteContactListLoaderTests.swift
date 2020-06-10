//
//  RemoteContactListLoaderTests.swift
//  PicPayChallengeTests
//
//  Created by Ana Leticia Camargos on 08/06/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import XCTest
import PicPayChallenge

final class RemoteContactListLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        var capturedErrors = [RemoteContactListLoader.Error]()
        sut.load { capturedErrors.append($0) }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            var capturedErrors = [RemoteContactListLoader.Error]()
            sut.load { capturedErrors.append($0) }
            
            client.complete(withStatusCode: code, at: index)
            XCTAssertEqual(capturedErrors, [.invalidData])
        }
        
    }
    
    // MARK: - Test Helpers
    
    private func makeSUT(
        url: URL = URL(string: "https://a-given-url.com")!
    ) -> (sut: RemoteContactListLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteContactListLoader(client: client, url: url)
        return (sut, client)
    }
}

final class HTTPClientSpy: HTTPClient {
    
    private var messages = [(url: URL, completion: (Error?, HTTPURLResponse?) -> Void)]()
    
    var requestedURLs: [URL] {
        messages.map { $0.url }
    }
    
    func get(from url: URL, completion: @escaping (Error?, HTTPURLResponse?) -> Void) {
        messages.append((url, completion))
    }
    
    // MARK: - Helper Methods
    
    func complete(with error: Error, at index: Int = 0) {
        messages[index].completion(error, nil)
    }
    
    func complete(withStatusCode code: Int, at index: Int = 0) {
        let response = HTTPURLResponse(
            url: requestedURLs[index],
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )
        messages[index].completion(nil, response)
    }
}
