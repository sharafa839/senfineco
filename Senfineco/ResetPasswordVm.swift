//
//  ResetPasswordVm.swift
//  Senfineco
//
//  Created by Ahmed on 31/10/2021.
//

import Foundation
import RxSwift
import RxCocoa
class ResetPassword {
   private let resetpassord = PublishSubject<ResetPasswordModel>()
    var resetPassowrdSubscribe : Observable<ResetPasswordModel>{
        return resetpassord
    }
    func resetPassword(phone:String,password:String){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.resetPassword, method: .post, paameters: paramter.ResetPassowrd(phone: phone, password: password), headers: Headers.AccepTHeaders()) { (reset:ResetPasswordModel?, err:Error?, code:Int?) in
            if code == 200 {
                if err == nil {
                    HelperK.showSuccess(title: "password changed successfully".localizede, subtitle: "")
                    guard  let password = reset else {
                        return
                    }
                    self.resetpassord.onNext(password)
                }else{
                    HelperK.showError(title: reset?.message ?? "", subtitle: "")
                }
            }else{
                HelperK.showError(title: "err".localizede, subtitle: "")
            }
        }
    }
}

