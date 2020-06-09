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
        
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url, url])
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
    var requestedURLs = [URL]()
    
    func get(from url: URL) {
        requestedURLs.append(url)
    }
}
