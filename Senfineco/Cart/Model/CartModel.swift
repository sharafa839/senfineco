//
//  CartModel.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import Foundation
import RxDataSources

struct Cart: Codable {
    var code: Int?
    var payload: CartPayload?
    var message: String?
    var status: Bool?
}

// MARK: - Payload
struct CartPayload: Codable {
    var products: [Products]?
        var status: String?
        var total: Double?
        var id, userID: Int?
}

// MARK: - Product

struct sectionCart {
    var items : [Products]
    var heades: String
    
}
extension sectionCart : SectionModelType{
    init(original: sectionCart, items: [Products]) {
        self = original
        self.items = items
    }
    
    
}
// MARK: - Payload


// MARK: - Product
struct Products: Codable {
    var productID, quantity: Int?
    var image: String?
    var nameAr, name: String?
    var total,price: Double?

    enum CodingKeys: String, CodingKey {
        case productID, total, quantity, image
        case nameAr = "name_ar"
        case name, price
    }
}
// MARK: - FailModel
struct FailModel: Codable {
    let payload: FailModelPayload?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct FailModelPayload: Codable {
}
