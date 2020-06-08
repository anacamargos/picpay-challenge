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
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        client.get(from: URL(string: "https://www.a-url.com.br")!)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

final class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}

final class RemoteContactListLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        _ = RemoteContactListLoader(client: client)
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClientSpy()
        let sut = RemoteContactListLoader(client: client)
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}
