//
//  Parameters.swift
//  Store Joud
//
//  Created by ahmed on 6/14/21.
//

import Foundation
import Alamofire
class paramter {
    let shared = paramter()
    class func registerParms(email:String,phone:String,firstName:String,lastName:String,password:String)->Parameters{
        let parms = ["email":email,
                     "phone":phone,
                     "fname":firstName,
                     "lname":lastName,
                     "password":password, "user_id":0,"role":"customer","group":"price_group_6"] as [String:Any]
        return parms
    }
    
    class func BankTransfer(oederId:Int,ImageName:String) ->Parameters{
        let parms = ["orderId":oederId,"image_name":ImageName] as [String:Any]
        return parms
    }
    class func resultRecomend (make:String,model:String,type:String)->Parameters {
        let parms = ["brand":make,"model":model,"type":type] as [String:Any]
        return parms
    }
    class func MakeFavorite(customer:Bool,productId:Int)->Parameters {
        let parms = ["productID":productId] as [String:Any]
        return parms
    }
    class func ResetPassowrd(phone:String,password:String)->Parameters {
        let parms = ["phone":phone,"password":password] as [String:Any]
        return parms
    }
    class func addToCart(customer:Bool,productId:String,quantity:Int)->Parameters {
        let parms = ["customer":customer,"productID":productId,"quantity":quantity] as [String:Any]
        return parms
    }
    class func registerseller(email:String,phone:String,firstName:String,lastName:String,password:String,company:String,serilNumber:String)->Parameters{
        let parms = ["email":email,
                     "phone":phone,
                     "fname":firstName,
                     "lname":lastName,
                     "password":password, "user_id":0,"role":"wholesaler","group":"price_group_6","wholesaler":["company":company,"CRN":serilNumber]] as [String:Any]
        return parms
    }

    class func registerProviderParms(email:String,phone:String,name:String,password:String,type:String,workfields:String,nationality:String)->Parameters{
        let parms = ["email":email,
                     "phone":phone,
                     "full_name":name,
                     "password":password, "type":type,
                     "work_fields[]":workfields,
                     "nationality":nationality] as [String:Any]
        return parms
    }
    class func LoginParms (phone:String,password:String)->Parameters {
        let parms = ["username":phone,
        "password":password] as [String:Any]
        return parms
    }
    class func updateLocation (lat:Double,lon:Double)->Parameters {
        let parms = ["lat":lat,
        "lng":lon] as [String:Any]
        return parms
    }
    class func Lang(language:String)->Parameters {
        let parms = ["lang":language] as [String:Any]
        return parms
    }
    class func Products(title:String)->Parameters {
        let parms = ["title":title] as [String:Any]
        return parms
    }
    class func updateName(language:String)->Parameters {
        let parms = ["full_name":language] as [String:Any]
        return parms
    }
    class func productID(productID:Int)->Parameters {
        let parms = ["productID":productID] as [String:Any]
        return parms
    }
    class func updatePhone(language:String)->Parameters {
        let parms = ["phone":language] as [String:Any]
        return parms
    }
    class func updateEmail(language:String)->Parameters {
        let parms = ["email":language] as [String:Any]
        return parms
    }
    class func shippingOrder (city:String,state:String,notes:String,phone:String,addId:Int?)->Parameters{
        let parms = ["shipping":["address":["city":city,"state":state,"notes":notes],"phone":phone],"addressID":addId ?? "null"] as [String : Any]
        return parms
    }
    class  func AdreessParms(name: String,street:String,phone:String,city:String,postalCode:String,country:String) ->Parameters {
        let parms = ["name":name,
                     "phone":phone,
                     "street_name":street,
                     "city":city,
                     "postal_code":postalCode,
                     "country":country] as [String:Any]
        return parms
    }
    class func AddToCart(customer:Bool,productID:Int,quantity:Int)->Parameters {
        let parms = ["productID":productID,
                     "quantity":quantity,
        ] as [String:Any]
return parms
    }
    class func updateAdressParms(city:String,phone:String,state:String,notes:String)->Parameters {
        let parms = ["city"  : city,
                     "state" : state,"phone":phone] as [String:Any]
        return parms
    }
    class func updateLogoParms (logo:UIImage)->Parameters {
        let parms = ["logo":logo] as [String:Any]
        return parms
    }
    class func updateProfileParms (fname:String,lname:String,email:String,phone:String)->Parameters {
        let parms = ["fname":fname,
                     "lname":lname,
                     "email":email,
                     "phone":phone] as [String:Any]
        return parms
    }
    class func updateProfileseller(fname:String,lname:String,email:String,phone:String,company:String,crn:String)->Parameters {
        let parms = ["fname":fname,
                     "lname":lname,
                     "email":email,
                     "phone":phone,
                     "wholesaler":["company":company,"CRN":crn]] as [String:Any]
        return parms
    }
    class func updatePasswordParms(old:String,new:String)->Parameters {
        let parms = ["old":old,
                     "new":new] as [String:Any]
    return parms
    }
    class func sendContactMessageParms(subject:String,message:String,name:String)->Parameters {
        let parms = ["name":name,
                     "subject":subject,
                     "message":message,] as [String:Any]
        return parms
        
    }
    class func ReviewParms(rate:Int,review:String) ->Parameters {
        let parms = ["rate":rate,
        "review":review] as [String:Any]
        return parms
    }
    
    class func updateQuantityParms(updateQuantity:String)->Parameters {
        let parms = ["update_quantity":updateQuantity] as [String:Any]
        return parms
    }
    class func promoCodeParms(Code:String)->Parameters {
        let parms = ["promo_code":Code] as [String:Any]
        return parms
    }
    class func confirm(otp:Int,userID:String)->Parameters{
        let parms = ["OTP":otp,"userID":userID] as [String:Any]
        return parms
    }
    class  func newOrdersParms(description:String,service_id:String,lat:Double,lon:Double,address:String,time:String,date:String)->Parameters {
        let parms = ["description"     : description ,
                     "service_id"        : service_id,
                     "lat"     : lat,
                     "lng" : lon ,
                     "address": address,
                     "time":time,
                     "date":date] as [String:Any]
        return parms
    }
    class  func newOrderswithCodeParms(description:String,service_id:String,lat:Double,lon:Double,address:String,time:String,date:String,promoCode:String)->Parameters {
        let parms = ["description"     : description ,
                     "service_id"        : service_id,
                     "lat"     : lat,
                     "lng" : lon ,
                     "address": address,
                     "time":time,
                     "date":date,
                     "promo_code":promoCode] as [String:Any]
        return parms
    }
    
    
    class func trackOrderParms(invoiceID:String)-> Parameters{
        let parms = ["invoice_id":invoiceID] as [String:Any]
        return parms
    }
    class func OrderParms(status:String)-> Parameters{
        let parms = ["status":status,"count":0,"Page":0] as [String:Any]
        return parms
    }
    
    class  func searchParms(withKey:String,recently:String,popular:String,priceHigh:String,priceLow:String,priceFrom:String,priceTo:String)->Parameters {
        let parms = ["price_from":priceFrom,
                     "price_to":priceTo,
                     "price_low":priceLow,
                     "price_high":priceHigh,
                     
                     "most_popular":popular,
                     
                     "most_recently":recently,
                     
                     "search_with_key":withKey
        ] as [String:Any]
        
        return parms
    }
    
    
    
    
    
    
    
    
}
