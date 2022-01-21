//
//  User.swift
//  Senfineco
//
//  Created by ahmed on 9/5/21.
//

import Foundation
import RxSwift
import RxCocoa
class Userr {
    let  firstName : String?
    let lastName : String?
    let token:String?
    let phone:String?
    let code : String?
    let email:String?
    let role: String?
    let  group, company, crn: String?
    init(fname:String,lname:String,Btoken:String,phoneCode:String,Email:String,Phone:String,role:String,group:String,company:String,crn:String) {
        self.lastName = lname
        self.token = Btoken
        self.code = phoneCode
        self.email = Email
        self.phone = Phone
        self.firstName = fname
        self.role = role
        self.group = group
        self.company = company
        self.crn = crn
    }
    
    
    
}
