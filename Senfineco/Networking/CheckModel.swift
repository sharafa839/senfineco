//
//  CheckModel.swift
//  Store Joud
//
//  Created by ahmed on 6/15/21.
//

import Foundation
struct CheckModel: Codable {
    let status: Bool?
    let code: Int
    let messages: String?
    let payload:String?
}
