//
//  OrderViewModel.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import Foundation
import RxSwift
import RxCocoa

class Order {
    private let OrdersResponse = PublishSubject<[OrdersPayload]>.init()
    var subscribeResponse : Observable <[OrdersPayload]>{
        return OrdersResponse
    }
    private let TrackRespone = PublishSubject<TrackOrderPayload>.init()
    var subscribeTrackRespone : Observable <TrackOrderPayload>{
        return TrackRespone
    }
    func GetOrders(status:String,vc:UIViewController)  {
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApiWithPagination(pageNo: 0, url: URLS.activeOrders, method: .post, paameters: paramter.OrderParms(status: status), headers: Headers.AccepTTokenHeaders()) {[weak self] (orders:Orders?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                if err == nil {
                    guard  let orders = orders?.payload else {
                        return
                    }
                    guard let self = self else {return}

                    self.OrdersResponse.onNext(orders)
                }else{
                    HelperK.showError(title: orders?.message ?? "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title: orders?.message ?? "err".localizede, subtitle: "")

            }}}
    func trackOrder(id:String,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApiWithPagination(pageNo: 0, url: URLS.activeOrders + "/" + "\(id)", method: .get, paameters: nil, headers: Headers.TokenAcceptContentHeader()) {[weak self] (tracking:TrackOrder?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()

            guard let self = self else {return}

            if code == 200 {
                if err == nil {
                    guard  let track = tracking?.payload else {return}
                    self.TrackRespone.onNext(track)
                }
            }
        }
    }
}

