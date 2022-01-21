//
//  CategoryModel.swift
//  Senfineco
//
//  Created by ahmed on 9/7/21.
//

import Foundation

// MARK: - Category
struct Category: Codable{
    var message: String?
    var payload: [CategoryPayload]?
    var code: Int?
    var status: Bool?
}

// MARK: - Payload
struct CategoryPayload: Codable {
    var categoryNameEn: String?
    var image: String?
    var categoryNameAr: String?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case categoryNameEn = "category_name_en"
        case image
        case categoryNameAr = "category_name_ar"
        case id
    }
}
