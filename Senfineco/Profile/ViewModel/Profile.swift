//
//  Profile.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import Foundation
import RxSwift
import RxCocoa

class Profile{
    private let profileResponse = PublishSubject<ProfileData>.init()
    var subscribeToRespnse : Observable<ProfileData> {
        return profileResponse
    }
    private let UpdateprofileResponse = PublishSubject<UpdateProfile>.init()
    var subscribeToUpdateRespnse : Observable<UpdateProfile> {
        return UpdateprofileResponse
    }
    func getData(vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApiWithPagination(pageNo: 0, url:URLS.profile, method: .post, paameters: nil, headers: Headers.AccepTTokenHeaders()) { (profile:ProfileData?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                if err == nil {
                    guard  let profile = profile else {
                        return
                    }
                    self.profileResponse.onNext(profile)
                }else{
                    HelperK.showError(title: "err", subtitle: "")
                }
            }else{
                HelperK.showError(title: "err", subtitle: "")

            }
        }
    }
    func updateData(user:UserType,fname:String,lname:String,phone:String,email:String,crn:String?,company:String?,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        switch user {
        case .Customer:
            APIs.genericApiWithPagination(pageNo: 0, url:URLS.updateProfile + "customer", method: .put, paameters: paramter.updateProfileParms(fname: fname, lname: lname, email: email, phone: phone), headers: Headers.AccepTTokenHeaders()) { (profile:UpdateProfile?, err:Error?, code:Int?) in
                LottieHelper.shared.hideAnimation()

                if code == 200 {
                    if err == nil {
                        guard  let profile = profile else {
                            return
                        }
                        self.UpdateprofileResponse.onNext(profile)
                    }else{
                        HelperK.showError(title: "err".localizede, subtitle: "")
                    }
                }else{
                    HelperK.showError(title: "err".localizede, subtitle: "")

                }
            }
        case.Seller :
            APIs.genericApiWithPagination(pageNo: 0, url:URLS.updateProfile + "wholesaler", method: .put, paameters: paramter.updateProfileseller(fname: fname, lname: lname, email: email, phone: phone, company: company ?? "", crn: crn ?? ""), headers: Headers.AccepTTokenHeaders()) { (profile:UpdateProfile?, err:Error?, code:Int?) in
                LottieHelper.shared.hideAnimation()

                if code == 200 {
                    if err == nil {
                        guard  let profile = profile else {
                            return
                        }
                        self.UpdateprofileResponse.onNext(profile)
                    }else{
                        HelperK.showError(title: "err", subtitle: "")
                    }
                }else{
                    HelperK.showError(title: "err", subtitle: "")

                }
            }
        default:
            print("")
        }
    }
    func getProfileData(user:UserType,vc:UIViewController)  {
        switch user {
        case .Customer:
            getData(vc: vc)
        case.Seller:
            getData(vc: vc)
        default:
            print("")
        }
    }
    
    
}
enum UserType {
    case Customer
    case Seller
}
