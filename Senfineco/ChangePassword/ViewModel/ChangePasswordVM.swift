//
//  ChangePasswordVM.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import Foundation
import RxSwift
import RxCocoa
class ChangePassword {
    let oldPassword = BehaviorRelay<String>.init(value: "")
    let newPassword = BehaviorRelay<String>.init(value: "")
    func changePassword(vc:UIViewController) {
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.updatePassword, method: .post, paameters: paramter.updatePasswordParms(old: oldPassword.value, new: newPassword.value), headers: Headers.AccepTTokenHeaders()) { (pass:PasswordUpdateModel?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()
            if code == 200 {
                if err == nil {
                    
                    HelperK.showSuccess(title: pass?.message ?? "", subtitle: "")
                }else{
                    HelperK.showError(title: pass?.message ?? "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title: pass?.message ?? "err".localizede, subtitle: "")

            }
        }
    }
}
