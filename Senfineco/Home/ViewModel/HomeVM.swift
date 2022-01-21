//
//  HomeVM.swift
//  Senfineco
//
//  Created by ahmed on 9/7/21.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
class HomeVM {
    private let publishCategoryResponse = PublishSubject<[CategoryPayload]>.init()
    var subscribeCategoryResponse : Observable<[CategoryPayload]>{
        return publishCategoryResponse
    }
    private let publishProductResponse = PublishSubject<[ProductPayload]>.init()
    var subscribeProductResponse : Observable<[ProductPayload]>{
        return publishProductResponse
    }
    func getCategory(vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.category, method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) {[weak self] (category:Category?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                guard let self = self else {return}

                if err == nil {
                    guard  let cat = category?.payload  else {
                        return
                    }
                    self.publishCategoryResponse.onNext(cat)
                }else{
                    HelperK.showError(title: category?.message ?? "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title: category?.message ?? "err".localizede, subtitle: "")

            }
        }
    }
    func specialCallApi(productName:String,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        let url = URLS.ProductInOneCategoty + productName
       let ur =  url.replacingOccurrences(of: " ", with: "%20")
        AF.request(ur, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: Headers.AccepTTokenHeaders(), interceptor: CustomInterceptor.self as? RequestInterceptor).responseJSON { (response) in
            LottieHelper.shared.hideAnimation()

            if response.response?.statusCode  == 200 {
            guard let data = response.data else {return}
            do {
                let res = try JSONDecoder().decode(Product.self, from: data)
                guard let res = res.payload else {
                    return
                }
                self.publishProductResponse.onNext(res)
            }catch{
                HelperK.showError(title: "err".localizede, subtitle: "")
            }
            
            }else{
                HelperK.showError(title: "err".localizede, subtitle: "")
            }}
    }
    func getProduct(vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.fetchAllProducts, method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) {[weak self] (category:Product?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                guard let self = self else {return}

                if err == nil {
                    guard  let cat = category?.payload  else {
                        return
                    }
                    self.publishProductResponse.onNext(cat)
                }else{
                    HelperK.showError(title: category?.message ?? "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title: category?.message ?? "err".localizede, subtitle: "")

            }
        }
    }
    func getProductByCategory(productName:String,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.ProductInOneCategoty  , method: .post, paameters: paramter.Products(title: productName), headers: Headers.TokenAcceptContentHeader()) { (products:Product?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                if err == nil {
                    guard  let cat = products?.payload  else {
                        return
                    }
                    self.publishProductResponse.onNext(cat)
                }else{
                    HelperK.showError(title: products?.message ?? "err".localizede, subtitle: "hhh")
                }
            }else{
                HelperK.showError(title: products?.message ?? "err".localizede, subtitle: "")
            }
        }
    }
}
