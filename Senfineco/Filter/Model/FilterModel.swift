//
//  FilterModel.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import Foundation
import RxDataSources
struct Brands: Codable {
    let payload: Brandspayload?
    let status: Bool?
    let code: Int?
}
struct Brandspayload : Codable {
    let brands : [String]
}
struct FilSection {
    var header:String
    var items : [String]
}
extension FilSection : SectionModelType{
    init(original: FilSection, items: [String]) {
        self = original
        self.items = items
    }
    
    
}
struct MakeType: Codable {
    let payload: MakeTypePayload?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct MakeTypePayload: Codable {
    let brand: String?
    let model, type: [String]?
}
struct MakeTypeSection{
    var header:String
    var items : [String]
}
extension MakeTypeSection : SectionModelType{
    init(original: MakeTypeSection, items: [String]) {
        self = original
        self.items =  items
    }
}


struct Model: Codable {
    let payload: ModelPayload
    let code: Int
    let status: Bool
    let message: String
}

// MARK: - Payload
struct ModelPayload: Codable {
    let brand: String
    let model: [String]
}
struct ModelSection {
    var header : String
    var items : [String]
}
extension ModelSection:SectionModelType{
    init(original:ModelSection,items:[String]) {
        self = original
        self.items  = items
    }
}
