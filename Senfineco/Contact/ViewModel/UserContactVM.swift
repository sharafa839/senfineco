//
//  UserContactVM.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import Foundation
import RxSwift
import RxCocoa
class contact{
    var name = BehaviorRelay<String>.init(value: "")
    var subject = BehaviorRelay<String>.init(value: "")
    var message = BehaviorRelay<String>.init(value: "")
    func sendMessage(vc:UIViewController) {
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApiWithPagination(pageNo: 0, url: URLS.sendContactMessage, method: .post, paameters: paramter.sendContactMessageParms(subject: subject.value, message: message.value, name: name.value), headers: Headers.AccepTTokenHeaders()) { (contact:ContactMessage?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                if err == nil {
                    HelperK.showSuccess(title: contact?.message ?? "", subtitle: "")
                
            }else{
                HelperK.showError(title: contact?.message ?? "", subtitle: "")
            }}else{
            HelperK.showError(title: contact?.message ?? "", subtitle: "")
        }
    }
}
}
