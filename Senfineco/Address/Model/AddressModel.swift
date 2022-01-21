//
//  AddressModel.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//
import  RxDataSources

import Foundation
struct AddressSection {
    let headers : String
    var items : [AddressModelPayload]
}
extension AddressSection : SectionModelType {
    init(original: AddressSection, items: [AddressModelPayload]) {
        self = original
        self.items = items
    }
    
    
}
struct AddressModel: Codable  {
    var payload: [AddressModelPayload]?
    var status: Bool?
    var code: Int?
    var message: String?
}

// MARK: - Payload
struct AddressModelPayload: Codable {
    var address: Address?
        var id: Int?
}

// MARK: - Address
struct Address: Codable {
    var street1: String?
    var city, state: String?
    var street2, zip, notes, country,phone: String?
}


// MARK: - Address
struct MakeNewOrder: Codable  {
    var status: Bool?
    var payload: MakeNewOrderPayload?
    var message: String?
    var code: Int?
}

// MARK: - Payload
struct MakeNewOrderPayload: Codable {
    var id: Int?
}
// MARK: - Item
struct Item: Codable {
    let sku, title, productID: String?
    let quantity, discount, tax, total: Int?
    let price: Int?
}

// MARK: - Shipping
struct Shipping: Codable {
    let address: Address?
    let phone, userID: String?
}
struct ShippingOrder: Codable {
    let address: Address?
    let phone:String
    let userID: Int?
}

// MARK: - Address
/*struct Address: Codable {
    let street1, street2, city, state: String
    let country, zip, notes: String
}*/

// MARK: - User
struct User: Codable {
    let fname, lname, email, group: String?
    let phone: String?
}

