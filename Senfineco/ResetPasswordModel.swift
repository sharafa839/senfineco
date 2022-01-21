//
//  ResetPasswordModel.swift
//  Senfineco
//
//  Created by Ahmed on 31/10/2021.
//

import Foundation
struct ResetPasswordModel: Codable {
    let payload: String?
    let code: Int?
    let status: Bool?
    let message: String?
}
