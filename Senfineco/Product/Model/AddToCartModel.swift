//
//  AddToCartModel.swift
//  Senfineco
//
//  Created by ahmed on 9/8/21.
//

import Foundation
struct AddToCart: Codable {
    let error: String?
    let code: Int?
    let status: Bool?
    let message: String?
    let payload: Bool?
}
struct FavModel: Codable {
    let payload: FavModelPayload?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct FavModelPayload: Codable {
    let id, userID, productID: String?
    let price: Int?
    let curreny, nameAr, name: String?
    let image: String?
    enum CodingKeys: String, CodingKey {
        case id, userID, productID, price, curreny
        case nameAr = "name_ar"
        case name, image
    }
}

struct DeleteModell: Codable {
    var payload, message: String?
    var status: Bool?
    var code: Int?
}
