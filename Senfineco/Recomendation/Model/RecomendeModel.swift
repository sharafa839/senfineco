//
//  RecomendeModel.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import Foundation
struct RecomendedModel: Codable {
    let payload: [RecomendedModelPayload]?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct RecomendedModelPayload: Codable {
    let id: Int
    let brand, model, type, resutls: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, brand, model, type, resutls
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
