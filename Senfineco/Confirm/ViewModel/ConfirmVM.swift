//
//  Confirm.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import Foundation
import RxCocoa
import RxSwift
class Confirm {
    private var loginModelSubject = PublishSubject<LoginModel>()
    var loginModelObservable : Observable<LoginModel>{
        return loginModelSubject
    }
    func confirm(OTP:Int,userID:String,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.confirm, method: .post, paameters: paramter.confirm(otp: OTP, userID: userID), headers: Headers.AccepTHeaders()) { (conf:LoginModel?, err:Error?, code:Int?) in
            if code == 200 {
                if err == nil {
                    guard let user = conf else {
                        return
                    }
                    self.loginModelSubject.onNext(user)
                }else {
                    HelperK.showError(title: "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title: "err".localizede, subtitle: "")

            }
        }
    }
}
    
