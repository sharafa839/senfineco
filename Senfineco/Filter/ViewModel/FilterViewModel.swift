//
//  FilterViewModel.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import Foundation
import RxCocoa
import RxSwift
class Filter {
    private let FilterRespnse = PublishSubject<Brandspayload>()
    var subscribeToRespons : Observable<Brandspayload>{
        return FilterRespnse
    }
    private let ModelRespnse = PublishSubject<ModelPayload>()
    var subscribeToModelRespons : Observable<ModelPayload>{
        return ModelRespnse
    }
    private let MakeResponse = PublishSubject<MakeTypePayload>()
    var subscribeToMakeResponse : Observable<MakeTypePayload>{
        return MakeResponse
    }
    func fetchBrands(vc:UIViewController)  {
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.Brands, method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) {[weak self] (filter:Brands?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                if err == nil {
                    guard let fil = filter?.payload else {
                        return
                    }
                    self.FilterRespnse.onNext(fil)
                }else{
                    HelperK.showError(title: "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title:  "err".localizede, subtitle: "")

            }
        }
    }
    func fetchMakeType(vc:UIViewController,title:String){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.Brands + "/get", method: .post, paameters: ["brand":title], headers: nil) { [weak self] (make:MakeType?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()
            if code == 200 {
                if err == nil {
                    guard let fil = make?.payload else {
                        return
                    }
                    self?.MakeResponse.onNext(fil)
                }else{
                    HelperK.showError(title: "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title:  "err".localizede, subtitle: "")

            }
        }

    }
    func fetchModelType(vc:UIViewController,brand:String,type:String){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.getModel, method: .post, paameters: ["brand":brand,"type":type], headers: nil) { [weak self] (make:Model?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()
            if code == 200 {
                if err == nil {
                    guard let fil = make?.payload else {
                        return
                    }
                    self?.ModelRespnse.onNext(fil)
                }else{
                    HelperK.showError(title: "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title:  "err".localizede, subtitle: "")

            }
        }

    }
    
}
