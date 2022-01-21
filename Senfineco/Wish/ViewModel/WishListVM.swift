//
//  WishListVM.swift
//  Senfineco
//
//  Created by ahmed on 9/12/21.
//


import Foundation
import RxCocoa
import RxSwift
class Wish {
    private let wishResponse = PublishSubject<[WishListPayload]>()
    var wishRespnseObservable : Observable<[WishListPayload]>{
        return wishResponse
    }
    func getWishes(){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.listAllFavs, method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) { (wishs:WishList?, err:Error?, code:Int?) in
            if code == 200 {
                if err == nil {
                    guard  let wish = wishs?.payload else {
                        return
                    }
                    self.wishResponse.onNext(wish)
                }else{
                    HelperK.showError(title: wishs?.message ?? "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title: wishs?.message ?? "err".localizede, subtitle: "")

            }}}
    func AddToCart(id:Int)  {
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.addToCart, method: .post, paameters: paramter.AddToCart(customer: true, productID: id, quantity: 1), headers: Headers.TokenAcceptContentHeader()) { (cart:AddToCart?, err:Error?, code:Int?) in
            if code == 200 {
                if err == nil {
                    HelperK.showSuccess(title: cart?.message ?? "", subtitle: "")
                }else{
                    HelperK.showError(title: cart?.message ?? "err".localizede, subtitle: "")
                }}else{
                    HelperK.showError(title: cart?.message ?? "err".localizede, subtitle: "")

            }
        }
    }
    func deleteFromWishList(id:Int,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApiWithPagination(pageNo: 0, url: URLS.delete+"\(id)", method: .delete, paameters:nil, headers: Headers.AccepTTokenHeaders()) { (del:DeleteModell?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()
            if code == 200 {
                if err == nil {
                    HelperK.showSuccess(title: del?.message ?? "", subtitle: "")
                }else{
                    HelperK.showError(title: del?.message ?? "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title: del?.message ?? "err".localizede, subtitle: "")

            }
        }
    }
}
