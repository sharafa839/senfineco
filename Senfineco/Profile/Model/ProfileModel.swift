//
//  ProfileModel.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import Foundation
struct ProfileData: Codable  {
    var payload: ProfileDataPayload?
    var message: String?
    var status: Bool?
    var code: Int?
}

// MARK: - Payload
struct ProfileDataPayload: Codable {
    var email: String?
    var id: Int?
    var phone, lname, fname: String?
}

struct UpdateProfile:Codable {
    var status: Bool?
    var payload: UpdateProfilePayload?
    var code: Int?
    var message: String?
}

// MARK: - Payload
struct UpdateProfilePayload: Codable {
    var id: Int?
    var phone, email, lname, fname: String?
}

// MARK: - Wholesaler
