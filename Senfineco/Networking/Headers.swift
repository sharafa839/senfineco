//  APIs.swift
//  Key Sale
//
//  Created by Ghoost on 4/7/20.
//  Copyright © 2020 Khalij. All rights reserved.
//

import Foundation
import Alamofire
class Headers {
// singlton
//MARK: create only one instense
static let header=Headers()
       // MARK: login + userAds Headers
    
    
    class func getHeader()-> HTTPHeaders{
        //   API.api.token = UserDefaults.standard.object(forKey: "token") as! String
        let dict:HTTPHeaders = [
        .accept("application/json"),
        .contentType("application/json"),
        .authorization("Bearer \(HelperK.getUserToken())")
           ]
          return  dict
       }
     
  class func getUpdateLogoHeader()->HTTPHeaders {
    let dict:HTTPHeaders = [
            .accept("application/json"),
            .contentType("multipart/form-data"),
            .authorization("Bearer \(HelperK.getUserToken())")
           ]
          return  dict
       }
       // MARK: home Headers
 class func TokenAcceptContentHeader()-> HTTPHeaders {
              let dict:HTTPHeaders = [
                  .accept("application/json"),
                  .contentType("application/json"),
                .authorization(bearerToken:HelperK.getUserToken())              ]
             return  dict
       }
  class func AcceptContentHeader()-> HTTPHeaders {
           let dict:HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
           ]
          return  dict
     }
    class func AcceptContentHeaderSearch()-> HTTPHeaders {
             let dict:HTTPHeaders = [
              .contentType("application/json ; charset=utf-8"),
              .accept("application/json")
             ]
            return  dict
       }
    class func getLoginHeader()-> HTTPHeaders {
          let dict:HTTPHeaders = [
                  .contentType("application/x-www-form-urlencoded")
          ]
         return  dict
    }
    class func AccepTTokenHeaders()->HTTPHeaders {
        let dict : HTTPHeaders = [
            .accept("application/json"),
            .authorization(bearerToken:HelperK.getUserToken())
            ]
        return dict
    }
    class  func tokenHeaders()->HTTPHeaders {
        let dict : HTTPHeaders = [.authorization(bearerToken: HelperK.getUserToken())]
        return dict

    }
    class func AccepTHeaders()->HTTPHeaders {
        let dict : HTTPHeaders = [
            .accept("application/json") ]
        return dict
    }
    

    class func ContentTypeAccept()-> HTTPHeaders {
        let dict : HTTPHeaders = [.accept("application/json"),
                                  .contentType("application/x-www-form-urlencoded")]
        return dict
    }
}
