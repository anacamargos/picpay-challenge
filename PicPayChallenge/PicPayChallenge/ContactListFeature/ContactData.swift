//
//  ContactData.swift
//  PicPayChallenge
//
//  Created by Ana Leticia Camargos on 05/06/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import Foundation

public struct ContactData: Equatable {
    public let id: Int
    public let name: String
    public let imageURL: URL
    public let username: String
    
    public init(id: Int, name: String, imageURL: URL, username: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.username = username
    }
}

extension ContactData: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "img"
        case username
    }
}
