//
//  BankModel.swift
//  Senfineco
//
//  Created by ahmed on 9/19/21.
//

import Foundation

// MARK: - BankInfo
struct BankInfo: Codable {
    let info: Info?
}

// MARK: - Info
struct Info: Codable {
    let id: Int?
    let bankname, bankNumber, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, bankname
        case bankNumber = "bank_number"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
struct UploadImageModel: Codable {
    let name, originalName: String

    enum CodingKeys: String, CodingKey {
        case name
        case originalName = "original_name"
    }
}
