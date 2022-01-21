//
//  AboutVM.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import Foundation
import RxCocoa
import RxSwift
class Abouts {
    private let  aboutResponse = PublishSubject<About>.init()
    var subscribeToRes : Observable <About>{
        return aboutResponse
    }
    func getAbout(vc:UIViewController) {
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApiWithPagination(pageNo: 0, url: URLS.about, method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) {[weak self] (contact:About?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()
            if code == 200 {
                if err == nil {
                    HelperK.showSuccess(title: contact?.message ?? "", subtitle: "")
                    guard  let res = contact else {
                        return
                    }
                    self.aboutResponse.onNext(res)
            }else{
                HelperK.showError(title: contact?.message ?? "", subtitle: "")
            }}else{
            HelperK.showError(title: contact?.message ?? "", subtitle: "")
        }
    }
}
}
