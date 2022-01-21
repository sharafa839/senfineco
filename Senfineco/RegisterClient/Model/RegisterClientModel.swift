//
//  RegisterClientModel.swift
//  Senfineco
//
//  Created by ahmed on 9/6/21.
//

import Foundation

// MARK: - RegisterClientModel
struct RegisterClientModel: Codable {
        let payload: RegisterPayload?
        let accessToken: String?
        let status: Bool?

        enum CodingKeys: String, CodingKey {
            case payload
            case accessToken = "access_token"
            case status
        }
    }

    // MARK: - Payload
    struct RegisterPayload: Codable {
        let id, fname, lname, email: String?
        let phone, group: String?
        let wholesaler: Wholesaler?
    }

    // MARK: - Wholesaler
    struct Wholesaler: Codable {
        let company, crn: String?

        enum CodingKeys: String, CodingKey {
            case company
            case crn = "CRN"
        }
    }
