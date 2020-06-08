//
//  RemoteContactListLoaderTests.swift
//  PicPayChallengeTests
//
//  Created by Ana Leticia Camargos on 08/06/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import XCTest

final class RemoteContactListLoader {}

protocol HTTPClient {}

final class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
}

final class RemoteContactListLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        _ = RemoteContactListLoader()
        XCTAssertNil(client.requestedURL)
    }
}
