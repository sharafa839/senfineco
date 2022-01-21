//  APIs.swift
//  Key Sale
//
//  Created by Ghoost on 4/7/20.
//  Copyright © 2020 Khalij. All rights reserved.
//
import Foundation
import Alamofire
class CustomInterceptor :RequestInterceptor{
    private let retryLimit=3
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        if let statusCode = request.response?.statusCode,statusCode == 500,request.retryCount < retryLimit{
            completion(.retryWithDelay(2))
        }else{
            completion(.doNotRetry)
        }
    }
}
