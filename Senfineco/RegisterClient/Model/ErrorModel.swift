//
//  ErrorModel.swift
//  Senfineco
//
//  Created by ahmed on 9/7/21.
//

import Foundation
struct ErrorModel: Codable {
    let detail: [Detail]
}

// MARK: - Detail
struct Detail: Codable {
    let loc: [String]
    let msg, type: String
}
