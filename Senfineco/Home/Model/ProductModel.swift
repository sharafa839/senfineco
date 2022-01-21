//
//  ProductModel.swift
//  Senfineco
//
//  Created by ahmed on 9/7/21.
//

import Foundation
import  RxDataSources
struct productsSection {
    let headers : String
    var items : [ProductPayload]
}
extension productsSection : SectionModelType {
    init(original: productsSection, items: [ProductPayload]) {
        self = original
        self.items = items
    }
    
    
}
struct Product: Codable {
    var message: String?
    var status: Bool?
    var code: Int?
    var payload: [ProductPayload]?
}

// MARK: - Payload
struct ProductPayload: Codable {
    var shortDescriptionEn: String?
    var productUnit: String?
    var currency, qty: String?
    var howToUseAr: String?
    var title: String?
    var endSaleDateTime: String?
    var descriptionEn: String?
    var youtubeLink: String?
    var id: Int?
    var image: String?
    var category, sale, descriptionAr: String? 
    var price:Double?
    var titleAr: String?
    var gallery: [String]?
    var shortDescriptionAr: String?
    var startSaleDateTime: String?
    var brand, howToUseEn, discount: String?
    var sku: String?

    enum CodingKeys: String, CodingKey {
        case shortDescriptionEn = "short_description_en"
        case productUnit = "product_unit"
        case currency, qty
        case howToUseAr = "how_to_use_ar"
        case title, endSaleDateTime
        case descriptionEn = "description_en"
        case youtubeLink = "youtube_link"
        case id, image, category, sale
        case descriptionAr = "description_ar"
        case price
        case titleAr = "title_ar"
        case gallery
        case shortDescriptionAr = "short_description_ar"
        case startSaleDateTime, brand
        case howToUseEn = "how_to_use_en"
        case discount, sku
    }
}

enum UnitQty: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(UnitQty.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnitQty"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
