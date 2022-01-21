//
//  RecomendVm.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//
import RxCocoa
import RxSwift
import Foundation
class Recomend {
    private let recomend = PublishSubject<[RecomendedModelPayload]>()
    var subscribeRecomed : Observable<[RecomendedModelPayload]>{
        return recomend
    }
    func getRecomend(make:String,model:String,type:String,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.review, method: .post, paameters: paramter.resultRecomend(make: make, model: model, type: type), headers: Headers.AccepTTokenHeaders()) { (recom:RecomendedModel?, errr:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()
            if code == 200 {
                if errr == nil {
                    guard  let recomendition = recom?.payload else {
                        return
                    }
                    self.recomend.onNext(recomendition)
                }else{
                    HelperK.showError(title: recom?.message ?? "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title: recom?.message ?? "err".localizede, subtitle: "")

            }
        }
    }
}
