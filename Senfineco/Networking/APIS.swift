//
//  APIS.swift
//  Store Joud
//
//  Created by ahmed on 6/14/21.
//
import UIKit
import Alamofire
import SwiftyJSON

class APIs: NSObject {

    class func isConnectedToInternet() -> Bool {
           return NetworkReachabilityManager()!.isReachable
       }
    class  func  genericApi <T:Codable,E:Codable>(Url:String,methodd:HTTPMethod,parms:Parameters?,headers:HTTPHeaders,compeletion:@escaping(T?,E?,Error?,Int?)->()) {
        AF.request(Url, method: methodd,parameters:parms, headers: headers, interceptor: CustomInterceptor()).validate(statusCode: 200..<500).responseJSON { (response) in
            print (response)

         switch response.response?.statusCode {
            case (200..<300)?:
                
                switch response.result{
                case .success(_):
                  guard let data=response.data else {return}
                        print("response data to json",JSON(data))
                    do{
                        let data = try JSONDecoder().decode(T.self, from: data)
                        compeletion(data,nil, nil, 200)
                    }catch{
                        print("errrror",error.localizedDescription)
                       
                    }
                    
                case .failure(let error):
                    ActivityIndicatorManager.shared.hideProgressView()
                    guard let data=response.data else {return}
                          print("response data to json",JSON(data))
                      do{
                          let data = try JSONDecoder().decode(E.self, from: data)
                          compeletion(nil,data, nil, 404)
                      }catch{
                          print("errrror",error.localizedDescription)
                         
                      }
                }
         case 404 :
            guard let data=response.data else {return}
                  print("response data to json",JSON(data))
              do{
                  let data = try JSONDecoder().decode(E.self, from: data)
                  compeletion(nil,data, nil, 404)
              }catch{
                  print("errrror",error.localizedDescription)
                 
              }
        
            default: compeletion(nil, nil,nil, response.response?.statusCode)
        }}
    }

    class func genericApiWithPagination<T:Decodable>( pageNo:Int,url:String,method:HTTPMethod,paameters:Parameters?,headers:HTTPHeaders?,completion:@escaping (T?,Error?,Int?) -> ()) {
        AF.request(url, method: method,parameters:paameters,encoding: JSONEncoding.default, headers: headers, interceptor: CustomInterceptor()).validate(statusCode: 200..<505).responseJSON { (response) in
            print (response)
         switch response.response?.statusCode {
            case (200..<505)?:
                
                switch response.result{
                case .success(_):
                  guard let data=response.data else {return}
                        print("response data to json",JSON(data))
                    do{
                        let data = try JSONDecoder().decode(T.self, from: data)
                        completion(data, nil, 200)
                    }catch{
                        print("errrror",error.localizedDescription)
                        ActivityIndicatorManager.shared.hideProgressView()
                        completion(nil, nil, 200)
                    }
                case .failure(let error):
                    ActivityIndicatorManager.shared.hideProgressView()
                    print(error.localizedDescription)
                    completion(nil, error, 200)
                }
            default: completion(nil, nil, response.response?.statusCode)
        }}}
    
    
    class func sendOrders<T:Decodable>(url:String , method: HTTPMethod , headers:HTTPHeaders,params : Parameters , completion: @escaping(T?,Error?,Int?)->Void){

               let url = URL(string: url)
               var request = URLRequest(url: url!)
               request.method = method
              // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               request.headers = headers
               if (!JSONSerialization.isValidJSONObject(params)) {
                   print("is not a valid json object")
                   return
               }
        request.httpBody = try! JSONSerialization.data(withJSONObject: params)
        AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
            print(response.response?.statusCode)

            switch response.response?.statusCode {
//            case 405?:
//                if let da = response.data {
//                    print(JSON(da))
//                }
//            case 422? :
//                if let dat = response.data {
//                    print(JSON(dat))
//                }
//
            case (200..<202)?:
                switch response.result{
                case .success(_):
                    guard let data=response.data else {return}
                    print(JSON(data))
                    do{
                        let data = try JSONDecoder().decode(T.self, from: data)
                        completion(data, nil, 200)
                    }catch{
              //          print("errrror",error.localizedDescription)
                        ActivityIndicatorManager.shared.hideProgressView()
                        completion(nil, nil, 200)
                    }
                case .failure(let error):
                    ActivityIndicatorManager.shared.hideProgressView()
                    print(error.localizedDescription)
                    completion(nil, error, 200)
                }
                
            default: completion(nil, nil, response.response?.statusCode)
            }}}
        
    

   /* class func registerProvider(
                           image:UIImage,
                           params:Parameters,
                           completion: @escaping(_ error:Error?, _ data: CustomerRegister?, _ code:Int?)->()) {
              let urlString = URLS.register
              let headers: HTTPHeaders = [
                  "Content-type": "application/x-www-form-urlencoded",
                  "Accept": "application/json"
              ]
        print(params)
    AF.upload( multipartFormData: { multipartFormData in
        for (key, value) in params{
                   if value is String || value is Int{
                       multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }}
            if image.size.width != 0 {
                multipartFormData.append(image.jpegData(compressionQuality: 0.6)!, withName: "national_id_photocopy", fileName: "national_id.jpeg", mimeType: "image/jpeg")
            }},
               to: urlString,
               method: .post,
               headers: headers).validate(statusCode: 200..<500).responseJSON { (resp) in
           //    print(resp.response?.statusCode)
                print(resp)
                switch resp.response?.statusCode {
                case (200...201)?:
                    switch resp.result {
                    case .failure(let error):
        HelperK.showError(title: "", subtitle: General.stringForKey(key: "error"))
                        completion(error,nil,200)
                          case .success(_):
                            guard let dat = resp.data else { return }
                              do {
                                  let res = try JSONDecoder().decode(CustomerRegister.self, from: dat)
                                completion(nil,res, 200)
                              } catch {
        // print("register Provider errrooorrr", error.localizedDescription)
                HelperK.showError(title: General.stringForKey(key: "somethingWentWrong"), subtitle: "")
                                completion(nil,nil, 200)
                       }}
                    default: HelperK.showError(title: General.stringForKey(key: "somethingWentWrong"), subtitle: "")
                  }}}

    
    
    
    class func updateProfile(
                             image:UIImage,
                             params:Parameters,
                             urlString:String,
                             completion: @escaping(_ error:Error?, _ data: CheckModel?, _ code:Int?)->()) {
               // let urlString = URLs.update_profile
                let headers: HTTPHeaders = [
                    "Content-type": "multipart/form-data",
                    "Accept": "application/json"
                ]

      AF.upload( multipartFormData: { multipartFormData in
              for (key, value) in params {
                  multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                  }
              if image.size.width != 0 {
                  multipartFormData.append(image.jpegData(compressionQuality: 0.6)!, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
              }},
                    to: urlString,
                    method: .post,
                    headers: headers).validate(statusCode: 200..<300).responseJSON { (resp) in
                      switch resp.response?.statusCode {
                      case (200...201)?:
                         switch resp.result {
                            case .failure(let error):
                                HelperK.showError(title: "", subtitle: General.stringForKey(key: "error"))
                          completion(error,nil,200)
                            case .success(_):
                              guard let dat = resp.data else { return }
                                do {
                                    let res = try JSONDecoder().decode(CheckModel.self, from: dat)
                                  completion(nil,res, 200)
                                } catch {
                                   // print("register Provider errrooorrr", error.localizedDescription)
                                    HelperK.showError(title: General.stringForKey(key: "somethingWentWrong"), subtitle: "")
                                  completion(nil,nil, 200)
                         }}
                      default: HelperK.showError(title: General.stringForKey(key: "somethingWentWrong"), subtitle: "")
                    }}}
 
  */

    class func updateImage(image : UIImage,headers:HTTPHeaders, completion: @escaping(_ error:Error?, _ data: UploadImageModel?,_ code: Int?)->()) {
        let urlString = "https://senfineco-oman.co/api/v1/banks/media"

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(image.jpegData(compressionQuality: 0.6)!, withName: "file", fileName: "transfer.jpeg", mimeType: "image/jpeg")
        },
            to: urlString,
            method: .post,
            headers: headers).validate(statusCode: 200..<300).responseJSON { (resp) in
   //             print(resp.response?.statusCode)
                switch resp.response?.statusCode {
                case (200..<201)?:
                    switch resp.result {
                    case .failure(_):
                        HelperK.showError(title: "", subtitle: General.stringForKey(key: "error"))
                    case .success(_):
                        guard let dat = resp.data else { return }
             //              print(JSON(dat))
                        do {
                            let data = try JSONDecoder().decode(UploadImageModel.self, from: dat)
      
                      ActivityIndicatorManager.shared.hideProgressView()
                             completion(nil,data,200)
                        } catch {
                            HelperK.showError(title: General.stringForKey(key: "somethingWentWrong"), subtitle: "")
                        }}
                default: HelperK.showError(title: General.stringForKey(key: "somethingWentWrong"), subtitle: "")
                }}}
    
    
}

