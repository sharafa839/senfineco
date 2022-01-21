//
//  ChangePasswordModel.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import Foundation
struct PasswordUpdateModel: Codable {
    let error: String?
    let code: Int?
    let status: Bool?
    let message: String?
}
