//
//  CartVm.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import Foundation
import RxSwift
import RxCocoa
class CartVm {
    private let cartResponse = PublishSubject<Cart>.init()
    var subscripeToResponse : Observable<Cart>{
        return cartResponse
    }
    private let fail = PublishSubject<FailModel>.init()
    var subscripeToFail : Observable<FailModel>{
        return fail
    }
    private let incResponse = PublishSubject<Increment>.init()
    var subscripeToincResponse : Observable<Increment>{
        return incResponse
    }
    private let decResponse = PublishSubject<Increment>.init()
    var subscripeTodecResponse : Observable<Increment>{
        return decResponse
    }
    private let delResponse = PublishSubject<deleteModel>.init()
    var subscripeTodelResponse : Observable<deleteModel>{
        return delResponse
    }
    var isResponsable:Observable<Bool>{
        return cartResponse.asObservable().map { (cart)->Bool in
            guard let product = cart.payload?.products?.isEmpty else {return false}
            return product
            
           
        }
    }
   
    
    func getCartData(vc:UIViewController)  {
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApi(Url: URLS.cart, methodd: .get, parms: nil, headers: Headers.AccepTTokenHeaders()){[weak self] (cart:Cart?,faill:FailModel?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                if err == nil {
                    guard  let cart = cart else {
                        return
                    }
                    self.cartResponse.onNext(cart)
                }else{
                    guard  let fal = faill else {
                        return
                    }
                    self.fail.onNext(fal)
                }}else{
                    guard  let fal = faill else {
                        return
                    }
                    self.fail.onNext(fal)

            }
        }}
    func getCartDataa()  {

        APIs.genericApi(Url: URLS.cart, methodd: .get, parms: nil, headers: Headers.AccepTTokenHeaders()){[weak self] (cart:Cart?,faill:FailModel?, err:Error?, code:Int?) in
            guard let self = self else {return}

            if code == 200 {
                if err == nil {
                    guard  let cart = cart else {
                        return
                    }
                    self.cartResponse.onNext(cart)
                }else{
                    guard  let fal = faill else {
                        return
                    }
                    self.fail.onNext(fal)
                }}else{
                    guard  let fal = faill else {
                        return
                    }
                    self.fail.onNext(fal)

            }
        }}
    func increaseQuantity(id:Int,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.incearsQuantity, method: .post, paameters: paramter.productID(productID: id), headers: Headers.AccepTTokenHeaders()) { [weak self] (inc:Increment?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()
            guard let self = self else {return}
            if code == 200 {
                if err == nil {
                    guard let inc = inc else {
                        return
                    }
                    self.incResponse.onNext(inc)
                    HelperK.showSuccess(title: inc.message ?? "", subtitle: "")

                }}}}
    
    func decreaseQuantity(id:Int,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApiWithPagination(pageNo: 0, url: URLS.decreaseQuantity, method: .post, paameters: paramter.productID(productID: id), headers: Headers.AccepTTokenHeaders()) { [weak self] (inc:Increment?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                if err == nil {
                    guard let inc = inc else {
                        return
                    }
                    self.incResponse.onNext(inc)
                    HelperK.showSuccess(title: inc.message ?? "", subtitle: "")
                }}}}
    func getPrice()->Double{
        var  pricePerItem = 0.0
        subscripeToResponse.subscribe { data in
            
            guard let product = data.element?.payload?.products else{return}
            for i in product {
                 pricePerItem += i.price ?? 0.0 * Double(i.quantity ?? 000)
            }
        }.disposed(by: DisposeBag())
return pricePerItem
    }
    
    func deleteProduct(id:Int,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApiWithPagination(pageNo: 0, url: URLS.deletedromCart+"\(id)", method: .delete, paameters: nil, headers: Headers.AccepTTokenHeaders()) { [weak self] (inc:deleteModel?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                if err == nil {
                    guard let inc = inc else {
                        return
                    }
                    self.delResponse.onNext(inc)
                    HelperK.showSuccess(title: inc.message ?? "", subtitle: "")

                }}}}
    
}
