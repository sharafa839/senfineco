//
//  BankTransferViewModel.swift
//  Senfineco
//
//  Created by ahmed on 9/19/21.
//

import Foundation
import RxSwift
import RxCocoa
class BankTransfer {
    private let response = PublishSubject<Info>.init()
    var subResponse : Observable<Info>{
        return response
    }
    private let responseImage = PublishSubject<UploadImageModel>.init()
    var subResponseImage : Observable<UploadImageModel>{
        return responseImage
    }
    func GetData(vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.bankInfo, method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) {[weak self] (info:BankInfo?, err:Error?, code:Int?) in
            guard let self = self else {return}

            guard let info = info?.info else{return}
            self.response.onNext(info)
        }
    }
    func uploadImage(image:UIImage,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.updateImage(image: image, headers: Headers.AccepTTokenHeaders()) {[weak self] (err:Error?, image:UploadImageModel?, code:Int?) in
            LottieHelper.shared.hideAnimation()
            guard let image = image else {return}
            guard let self = self else {return}

            self.responseImage.onNext(image)
            
        }
    }
    func uploadName(imageName:String,orderID:Int){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.uploadTransferImage, method: .post, paameters: paramter.BankTransfer(oederId: orderID, ImageName: imageName), headers: Headers.AccepTTokenHeaders()) { (bank:BankInfo?, err:Error?, code:Int?) in
            print(bank)
            HelperK.showSuccess(title: "suceessfully", subtitle: "")
        }
    }
}
