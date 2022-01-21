//
//  IncrementModel.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import Foundation
struct Increment: Codable {
    let payload, code: Int?
    let status: Bool?
    let message: String?
}
struct deleteModel: Codable {
    let payload:Bool?
        let code: Int?
    let status: Bool?
    let message: String?
}
