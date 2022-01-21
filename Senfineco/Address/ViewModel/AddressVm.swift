//
//  File.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import Foundation
import RxCocoa
import RxSwift
class AddressVm {
    let state = BehaviorRelay<String>.init(value: "")
    let city = BehaviorRelay<String>.init(value: "")
    let notes = BehaviorRelay<String>.init(value: "")
    let phone = BehaviorRelay<String>.init(value: "")
    let addId = BehaviorRelay<String>.init(value: "")
 
    var iscityValid : Observable<Bool>{
        return city.asObservable().map { (stereet1) -> Bool in
           return stereet1.isEmpty
        }
    }
   
   
    var isnotesValid : Observable<Bool>{
        return notes.asObservable().map { (stereet1) -> Bool in
           return stereet1.isEmpty
        }
    }
    var isStateValid : Observable<Bool>{
        return state.asObservable().map { (stereet1) -> Bool in
           return stereet1.isEmpty
        }
    }
    var isPhoneValid : Observable<Bool>{
        return phone.asObservable().map { (stereet1) -> Bool in
           return stereet1.isEmpty
        }
    }
    var obs : Observable<Bool>{
        return Observable.combineLatest( iscityValid,isStateValid,isnotesValid,isPhoneValid){ (a,b,c,d)  in
        
            let valid = !a && !b && !c && !d
            return valid
        }
    }

    private let myAddressSubject = PublishSubject<[AddressModelPayload]>.init()
    var subscribeToMyAddress : Observable <[AddressModelPayload]>{
        return myAddressSubject
    }
    private let newOrder = PublishSubject<MakeNewOrder>.init()
    var subscribeTonewOrder : Observable <MakeNewOrder>{
        return newOrder
    }
    private let shipingPrice = PublishSubject<shippingPrice>.init()
    var subscribeToshipingPrice : Observable <shippingPrice>{
        return shipingPrice
    }
    func getShippingPrice(){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.shippingPrice, method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) { (price:shippingPrice?, err:Error?, code:Int?) in
            
            if code == 200 {
                if err == nil {
                    guard  let price = price else {
                        return
                    }
                    self.shipingPrice.onNext(price)
                }else{
                    HelperK.showError(title: "err", subtitle: "")

                }
            }else{
                HelperK.showError(title: "err", subtitle: "")

            }
        }
    }
    func getAllAddress(){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.allAdress, method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) {[weak self] (address:AddressModel?, err:Error?, code:Int?) in
            guard let self = self else {return}

            if code == 200 {
                if err == nil {
                    guard  let addresss = address?.payload else {
                        return
                    }
                    self.myAddressSubject.onNext(addresss)
                }else{
                    HelperK.showError(title: "err", subtitle: "")
                }
            }else{
                HelperK.showError(title: "err", subtitle: "")

            }
        }
    }
    func makeNewOrderTextField(){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.shipping, method:.post, paameters: paramter.shippingOrder(city: city.value, state: state.value,notes: notes.value , phone: phone.value, addId:000 ), headers: Headers.AccepTTokenHeaders()) { [weak self](order:MakeNewOrder?, err:Error?, code:Int?) in
            guard let self = self else {return}

            if code == 200 {
                if err == nil {
                   
                    guard  let order = order else {
                        return
                    }
                    self.newOrder.onNext(order)
                    HelperK.showSuccess(title: order.message ?? "", subtitle: "")
                }
            }
        }
    }
    func makeNewOrder(addressId:Int,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.shipping, method:.post, paameters: paramter.shippingOrder( city: "", state: "", notes: "", phone: "", addId: addressId), headers: Headers.AccepTTokenHeaders()) { [weak self](order:MakeNewOrder?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                if err == nil {
                    guard  let order = order else {
                        return
                    }
                    self.newOrder.onNext(order)
                    HelperK.showSuccess(title: order.message ?? "", subtitle: "")
                }
            }
        }
    }
    
    func deleteAddress(addressId:Int,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.deleteAddress + "\(addressId)", method:.delete, paameters: nil, headers: Headers.AccepTTokenHeaders()) { [weak self](order:CheckModel?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()
            if code == 200 {
                if err == nil {
                    guard  let order = order else {
                        return
                    }
                   
                    HelperK.showSuccess(title: order.payload ?? "", subtitle: "")
                }
            }
    }
}
    func updateAddress(addressId:Int,city:String,state:String,phone:String,notes:String,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.deleteAddress + "\(addressId)", method:.put, paameters: paramter.updateAdressParms(city: city, phone: phone, state: state, notes: notes), headers: Headers.AccepTTokenHeaders()) { [weak self](order:CheckModel?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()
            if code == 200 {
                if err == nil {
                    guard  let order = order else {
                        return
                    }
                   
                    HelperK.showSuccess(title: order.payload ?? "", subtitle: "")
                }
            }
    }
}
}
