//
//  URLS.swift
//  Store Joud
//
//  Created by ahmed on 6/14/21.
//

import Foundation
class URLS {
    static let resetPassword = main + "api/v1.0/user/password/reset"
    static let incearsQuantity = main + "api/v1.0/cart/inc"
    static let decreaseQuantity = main + "api/v1.0/cart/dec"
    static let inc = main + "api/v1.0/cart/inc"
    static let deletedromCart = main + "api/v1.0/cart/"
    static let delete = main + "api/v1.0/whish/"
static let searche = main + "api/v1.0/product/search"
    static let confirm = main + "api/v1.0/user/confirm"
    static let Brands = "https://senfineco-oman.co/api/dropdown"
    static let getModel = "https://senfineco-oman.co/api/dropdown/model/get"
static let filter  = main + "api/v1.0/filter"
    static let main = "https://senfineco-oman.co/"
    static let login = main + "api/v1.0/user/login"
    static let register = main + "api/v1.0/user/customer/register"
    static let registerSeller = main + "api/v1.0/user/wholesaler/register"
static let category = main + "api/v1.0/categories/categories"
    static let ProductInOneCategoty = main + "api/v1.0/product/category/products"
    static let logout = main + "/api/logout"
    static let updatePassword = main + "api/v1.0/user/password/change"
    static let services = main + "/api/services"
    static let getProvidersInLocation = main + "/api/orders/"
    static let updateLocation = main + "/api/profile/update/location"
    static let AccomplisheOrder = main + "/api/"
    static let shippingPrice = main + "api/v1.0/shipping"
    static let addNewAddress = main + "api/user/addresses"
    static let allAdress = main + "api/v1.0/shipping/shipping"
    static let updateAddress = main + "api/v1.0/address/"
    static let deleteAddress = main + "api/v1.0/address/"
    static let getNotification = main + "/api/orders/notifications"
    static let getNotificationByID = main + "/api/orders/notifications/{{\(String.self)}}"
    static let deliverdOrders = main + "/api/customer/profile/orders/delivered"
    static let activeOrders = main + "api/v1.0/orders"
    static let profile = main + "api/v1.0/user"
    static let updateProfileLogo = main + "/api/profile/update/logo"
    static let updateProfilePassword = main + "/api/profile/update/password"
    static let updateProfile =  main + "api/v1.0/user/"
    static let generalList = main + "/api/general"
    static let sendContactMessage = main + "api/v1.0/contact/contact"
    static let makeThisProudctFav = main + "/api/products/"
    static let markAsFavorite = main + "api/v1.0/whish"
    static let listAllFavs = main + "api/v1.0/whish"
    static let removeThisProductFromFav = main + "/api/products/"
    static let markAsUnFavorite = "/api//mark-as-un-favorite"
    static let addReview = main + "/api/providers/"
    static let submitReview = "/api/rate-us/submit-review"
    static let getAllReviews = main + "/api/products/"
    static let reviews = "/api/reviews"
    static let shipping = main + "api/v1.0/checkout"
    static let fetchAllProducts = main + "api/v1.0/product/"
    static let fetchTopselling = fetchAllProducts + "/top-selling?lang="
    static let fetchTopRated = fetchAllProducts + "/top-rated?lang="
    static let fetchOffres = fetchAllProducts + "/offers"
    static let fetchProductByID = fetchAllProducts + "/"
    static let bankInfo = main + "api/v1.0/pay/account/info"
    static let addToCart = main + "api/v1.0/cart"
    static let cart = main + "api/v1.0/product/cart"
    static let GetAllCar = main + "/api/v1.0/cart"
    static let removeSingleProductFromCart = GetAllCar + "/destroy/"
    static let updateQuantatyOfProductInCart = GetAllCar + "/"
    static let update = main + "/api/cart/"
    static let promoCode = main + "/api/promo-codes/check"
    static let makeNewOrder = main + "/api/services/order"
    static let markAsPaid = main + "/api/orders//mark-as-paid"
    static let cancelOrder = main + "/api/orders/cancel-request-by-provider/"
    static let acceptOrder = main + "/api/orders/"

    static let trackOrder = main + "/api/order/tracking"
    static let listAllCat = main + "/api/categories?lang="
static let listspecificCat = main + "/api/categories/"
    static let listnearbyCategories = listspecificCat
    static let products = "/api//products"
    static let listAllBrands = main + "/api/brands"
    static let readSpecificBrand = listAllBrands + "/"
    static let listAllBrandProducts = readSpecificBrand
    static let search = main + "/api/search"
    static let uploadTransferImage = main + "api/v1.0/pay/bank"
    static let review = main + "api/v1.0/filter"
    static let about = main + "api/v1.0/contact/info"
static let getImage = main + "api/v1/banks/media"
    
    
    
    
    
    

    
    
    
    
    
    
}
