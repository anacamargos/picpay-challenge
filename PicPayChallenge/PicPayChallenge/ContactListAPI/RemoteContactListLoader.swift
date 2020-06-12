//
//  RemoteContactListLoader.swift
//  PicPayChallenge
//
//  Created by Ana Leticia Camargos on 09/06/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import Foundation

public typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public final class RemoteContactListLoader {
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    // MARK: - Dependencies
    
    private let client: HTTPClient
    private let url: URL
    
    // MARK: - Initializer
    
    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    // MARK: - Public Methods
    
    public func load(completion: @escaping (Result<[ContactData], Error>) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success((data, response)):
                if response.statusCode == 200, let root = try? JSONDecoder().decode([ContactData].self, from: data) {
                    completion(.success(root))
                } else {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}
