//
//  SearchVM.swift
//  Senfineco
//
//  Created by Ahmed on 04/10/2021.
//

import Foundation
import RxSwift
import RxDataSources
import RxCocoa
class SearchVm {
    private var  searchResult  = PublishSubject<[ProductPayload]>.init()
    var searchResultObservable : Observable<[ProductPayload]>{
        return searchResult
    }
    func  getSearch(title:String){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.searche , method: .post, paameters: ["title":title], headers: Headers.AccepTTokenHeaders()) {(search:Product?, err:Error?, code:Int? )in
            if code == 200 {
                if err  == nil {
                    guard let result = search?.payload else {return}
                    self.searchResult.onNext(result)
                }else{
                    HelperK.showError(title: "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title: "err".localizede, subtitle: "")
            }
        }
    }
}
