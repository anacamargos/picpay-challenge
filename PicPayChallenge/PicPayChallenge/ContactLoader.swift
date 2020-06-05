//
//  ContactLoader.swift
//  PicPayChallenge
//
//  Created by Ana Leticia Camargos on 05/06/20.
//  Copyright © 2020 Ana Leticia Camargos. All rights reserved.
//

import Foundation

protocol ContactLoader {
    func load(completion: @escaping (Result<[ContactData], Error>) -> Void)
}
