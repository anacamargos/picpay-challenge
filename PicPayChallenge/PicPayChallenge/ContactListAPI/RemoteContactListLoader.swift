//
//  RemoteContactListLoader.swift
//  PicPayChallenge
//
//  Created by Ana Leticia Camargos on 09/06/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (Error) -> Void)
}

public final class RemoteContactListLoader {
    
    public enum Error: Swift.Error {
        case connectivity
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
    
    public func load(completion: @escaping (Error) -> Void = { _ in }) {
        client.get(from: url) { error in
            completion(.connectivity)
        }
    }
}
