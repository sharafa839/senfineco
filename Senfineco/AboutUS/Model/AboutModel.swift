//
//  AboutModel.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//


import Foundation

// MARK: - About
struct About: Codable {
    let payload: AboutPayload?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct AboutPayload: Codable {
    let aboutUs: AboutUs?
    let terms: Terms?
    let social: Social?

    enum CodingKeys: String, CodingKey {
        case aboutUs = "about_us"
        case terms, social
    }
}

// MARK: - AboutUs
struct AboutUs: Codable {
    let title, body, titleAr, bodyAr: String?

    enum CodingKeys: String, CodingKey {
        case title, body
        case titleAr = "title_ar"
        case bodyAr = "body_ar"
    }
}

// MARK: - Social
struct Social: Codable {
    let facebook: String?
    let twitter, instagram, snapchat: String?
}

// MARK: - Terms
struct Terms: Codable {
    let title, body, titleAr, bodyAr: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case body
        case titleAr = "Title_ar"
        case bodyAr = "body_ar"
    }
}
