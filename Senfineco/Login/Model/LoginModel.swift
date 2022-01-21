//
//  LoginModel.swift
//  Senfineco
//
//  Created by ahmed on 9/6/21.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    let payload: Payload?
    let accessToken: String?
    let status: Bool?
    let code :Int?
    let message:String?
    enum CodingKeys: String, CodingKey {
        case payload
        case accessToken = "access_token"
        case status,code,message
    }
}

// MARK: - Payload
struct Payload: Codable {
    let fname, lname, email, role: String?
    let phone, group, company, crn: String?

    enum CodingKeys: String, CodingKey {
        case fname, lname, email, role, phone, group, company
        case crn = "CRN"
    }
}
