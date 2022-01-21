//
//  ProductVM.swift
//  Senfineco
//
//  Created by ahmed on 9/8/21.
//

import Foundation
import RxSwift
import RxCocoa
class ProductVM {
    
    private let CartResponse = PublishSubject<AddToCart>.init()
    var subscripeToCartResponse : Observable<AddToCart>{
        return CartResponse
    }
    private let favoriteResponse = PublishSubject<FavModel>.init()
    var subscripeTofavoriteResponse : Observable<FavModel>{
        return favoriteResponse
    }
    func AddToCart(productId:Int,quantity: Int,customer:Bool,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.addToCart, method: .post, paameters: paramter.AddToCart(customer: customer, productID: productId, quantity: quantity), headers: Headers.AccepTTokenHeaders()) {[weak self] (addTocart:AddToCart?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()

            guard let self = self else {return}
            if code == 200 {
                if err == nil {
                    guard let status = addTocart else {return}
                    self.CartResponse.onNext(status)
                    HelperK.showSuccess(title: addTocart?.message ?? "", subtitle: "")
                }else{
                   HelperK.showError(title: addTocart?.message ?? "err", subtitle: "")
                }
            }else{
                HelperK.showError(title: addTocart?.message ?? "err", subtitle: "")
            }
        }
    }
    func MakeFav(id:Int,vc:UIViewController) {
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApiWithPagination(pageNo: 0, url: URLS.markAsFavorite, method: .post, paameters: paramter.MakeFavorite(customer: true, productId: id), headers: Headers.AccepTTokenHeaders()) {[weak self] (fav:FavModel?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()
            if code == 200 {
                if err == nil {
                    guard let status = fav else {return}
                    self.favoriteResponse.onNext(status)
                    HelperK.showSuccess(title: status.message ?? "", subtitle: "")
                }else{
                    HelperK.showError(title: fav?.message ?? "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title: fav?.message ?? "err".localizede, subtitle: "")
            }
        }
    }
}


