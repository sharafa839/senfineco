//
//  WishListModel.swift
//  Senfineco
//
//  Created by ahmed on 9/12/21.
//

import Foundation
import RxDataSources
struct SectionModel {
    var header :String
    var items : [WishListPayload]
}
extension SectionModel : SectionModelType{
    init(original: SectionModel, items: [WishListPayload]) {
        self = original
        self.items = items
    }
    
    
}
struct WishList: Codable {
    var message: String?
    var payload: [WishListPayload]?
    var code: Int?
    var status: Bool?
}

// MARK: - Payload
struct WishListPayload: Codable {
    var name: String?
    var productID, id: Int?
    var image: String?
    var userID: Int?
    var curreny, nameAr, price: String?

    enum CodingKeys: String, CodingKey {
        case name, productID, id, image, userID, curreny
        case nameAr = "name_ar"
        case price
    }
}
