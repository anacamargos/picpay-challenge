//
//  RemoteContactListLoaderTests.swift
//  PicPayChallengeTests
//
//  Created by Ana Leticia Camargos on 08/06/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import XCTest

final class RemoteContactListLoader {
    
    private let client: HTTPClient
    private let url: URL
    
    init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

final class RemoteContactListLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
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
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}
