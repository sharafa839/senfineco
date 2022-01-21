//
//  UserContactModel.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import Foundation
struct ContactMessage: Codable {
    let error: String?
    let code: Int?
    let status: Bool?
    let message: String?
}
