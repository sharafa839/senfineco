//
//  MyOrderModel.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import Foundation
import RxDataSources
struct OrdersModel {
    var section:String
    var items : [OrdersPayload]
}
extension OrdersModel :SectionModelType{
    init(original: OrdersModel, items: [OrdersPayload]) {
        self = original
        self.items = items
    }
    
    
}
// MARK: - Orders
struct Orders: Codable  {
    var code: Int?
    var status: Bool?
    var payload: [OrdersPayload]?
    var message: String?
}

// MARK: - Payload
struct OrdersPayload: Codable {
    var totalCost: String?
    var status: String?
    var shipping: ShippingOrder?
    var items: [OrdersItem]?
    var currency, paymentStatus, id, date: String?
    var customerID: String?

    enum CodingKeys: String, CodingKey {
        case totalCost, status, shipping, items, currency, paymentStatus, id, date
        case customerID = "customerId"
    }
}

// MARK: - Item
struct OrdersItem: Codable {
    var productID: Int?
    var sku: String?
    var total: Int?
    var title: String?
}

// MARK: - Shipping


// MARK: - Address

struct shippingPrice: Codable {
    let payload: Int?
    let code: Int?
    let status: Bool?
    let message: String?
}
struct TrackOrder: Codable {
    let payload: TrackOrderPayload?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct TrackOrderPayload: Codable {
    let status, payment: String?
}


// MARK: - Item
/*struct Item: Codable {
    let sku, title, productID: String
    let quantity, discount, tax, total: Int
    let price: Int
}
*/
// MARK: - Shipping
/*struct Shipping: Codable {
    let address: Address
    let phone, userID: String
}
*/
// MARK: - Address
/*struct Address: Codable {
    let street1, street2, city, state: String
    let country, zip, notes: String
}
*/
// MARK: - User
/*struct User: Codable {
    let fname, lname, email, group: String
    let phone: String
}
*/
