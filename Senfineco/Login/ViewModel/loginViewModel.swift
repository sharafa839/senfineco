//
//  loginViewModel.swift
//  Senfineco
//
//  Created by ahmed on 9/6/21.
//

import Foundation
import RxCocoa
import RxSwift
class loginViewModel {
    var phone = BehaviorRelay<String>.init(value: "")
    var password = BehaviorRelay<String>.init(value: "")
    private var loginModelSubject = PublishSubject<LoginModel>()
    var loginModelObservable : Observable<LoginModel>{
        return loginModelSubject
    }
    var ispasswordValid:Observable<Bool>{
        return password.map { (pass) -> Bool in
            let ispasswordCorrect = pass.count > 5
            return ispasswordCorrect
        }
    }
    func isPhoneEmpty() ->Bool{
        if phone.value.isEmpty {
            return true
        }else{
            return false
        }
    }
    
    func login(vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApiWithPagination(pageNo: 0, url: URLS.login, method: .post, paameters: paramter.LoginParms(phone: phone.value, password: password.value), headers: Headers.AcceptContentHeader()) { [weak self](user:LoginModel?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()
            if code == 200 {
                if err == nil {
                    guard  let user = user else {return}
                    self.loginModelSubject.onNext(user)
                }else{
                    HelperK.showError(title: "err".localizede, subtitle: "")
                }}else{
                    HelperK.showError(title: "phoneOrPasswordwrong".localizede, subtitle: "")

            }}}
    func loginSeller(vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApiWithPagination(pageNo: 0, url: URLS.login, method: .post, paameters: paramter.LoginParms(phone: phone.value, password: password.value), headers: Headers.AcceptContentHeader()) { [weak self](user:LoginModel?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                if err == nil {
                    guard  let user = user else {return}
                    self.loginModelSubject.onNext(user)
                }else{
                    HelperK.showError(title: "err".localizede, subtitle: "")
                }}else{
                    HelperK.showError(title: "phoneOrPasswordwrong".localizede, subtitle: "")

            }}}

    
}
