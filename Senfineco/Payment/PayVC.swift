//
//  PayVC.swift
//  Senfineco
//
//  Created by ahmed on 9/11/21.
//

import UIKit
import RxCocoa
import RxSwift
import goSellSDK

class PayVC: UIViewController {

    @IBOutlet weak var payCreditView: UIView!
    @IBOutlet weak
    var cusomView: UIView!{
        didSet{
            cusomView.setBottomRoundedEdge(desiredCurve: 2)
        }
    }
    @IBOutlet weak var payButton: PayButton!
    
    @IBOutlet weak var payCredit: UIButton!{
        didSet{
            payCredit.setTitle("payCash".localizede, for: .normal)
        }
    }
    var am : Decimal?

    var orderId = Int()
    var price = String()
    var delegate : WhenPaymentSucessfull?
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.orderId)
        am = Decimal(string: price)
        print(555,orderId)
       
        payCreditView.isHidden = true

        let maskPath = UIBezierPath(roundedRect:cusomView.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                    cornerRadii: CGSize(width: 15, height: 15))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        cusomView.layer.mask = shape
        subscribeCash()
        payButton.delegate = self
        payButton.dataSource = self
        payButton.isEnabled = true
       updatePayButtonAmount()
        setData()
        if HelperK.getType() == "customer"{
          //  payCredit.isEnabled = false
        }
        // Do any additional setup after loading the view.
    }
   

    func subscribeCash(){
        payCredit.rx.tap.subscribe { (_) in
            print(self.orderId)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "cash") as!BankTransferVC
            vc.orderID = self.orderId
            print(self.orderId , "daddsdasda")
            self.present(vc, animated: true, completion: nil)
        }.disposed(by: disposeBag)

    }

}
extension PayVC : SessionDelegate,SessionDataSource{
   
    var mode: TransactionMode {
          
          return .purchase
      }
      var customer: Customer? {
          return self.newCustomer
      }
      
      /// Creating a customer with known identifier received from Tap before.
      var identifiedCustomer: Customer? {
          
          return try? Customer(identifier: "cus_to_mer")
      }
      
      /// Creating a customer with raw information.
    var newCustomer: Customer? {
            
        let emailAddress = try! EmailAddress(emailAddressString: HelperK.getemail())
        let phoneNumber = try! PhoneNumber(isdNumber:"968", phoneNumber: HelperK.getphone())
            
        return try? Customer(emailAddress:  emailAddress,
                             phoneNumber:   phoneNumber,
                             firstName:     HelperK.getname(),
                             middleName:    nil,
                             lastName:      nil)
    }
      var currency: Currency? {
          
          return .with(isoCode:"OMR")
      }
      var amount: Decimal {
          
        return am!
      }
      var postURL: URL? {
          
          return URL(string: "https://tap.company/post")
      }
      var paymentDescription: String? {
          
          return "";
      }
      var paymentMetadata: [String : String]? {
          
          return [:]
          
      }
    var paymentReference: Reference? {
            
        return Reference(transactionNumber: "tr_2352358020f",
                         orderNumber:       "ord_2352094823")
    }

      var paymentStatementDescriptor: String? {
          
          return "Payment statement descriptor will be here"
      }
      var require3DSecure: Bool {
          
          return true
      }
      var receiptSettings: Receipt? {
          
          return Receipt(email: true, sms: true)
      }
      var allowsToSaveSameCardMoreThanOnce: Bool {
          
          return false
      }
      var isSaveCardSwitchOnByDefault: Bool {
          
          return true
      }
      
   
    internal func updatePayButtonAmount() {
           
           self.payButton?.updateDisplayedState()
       }
       func setData(){
    
          // label.text = "Total Amount to pay ".localized+"\(Decimal(JSONData["tabData"]["totalAmount"].doubleValue))"
        func TabPaymentGatewayViewController() {
           
           self.payButton?.updateDisplayedState()
       }
}
    
    
    
    
    
    func paymentSucceed(_ charge: Charge, on session: SessionProtocol) {
           print(charge)
        delegate?.sucussfullRetuern()
        HelperK.showSuccess(title: "your order is ready now , please wait".localizede, subtitle: "")
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "payments")
        present(vc!, animated: true, completion: nil)
           
       }
       func paymentFailed(with charge: Charge?, error: TapSDKError?, on session: SessionProtocol) {
           print(charge?.status ?? "")
        delegate?.sucussfullRetuern()

           DispatchQueue.main.async{
               self.dismiss(animated: true, completion:nil)
               }
           }
       
    func sessionHasStarted(_ session: SessionProtocol) {
            print(session)
    
        }
        func sessionCancelled(_ session: SessionProtocol) {
            print(session)
            DispatchQueue.main.async{
                self.dismiss(animated: true, completion:nil)
            }
            
        }
        func sessionHasFailedToStart(_ session: SessionProtocol) {
            print(session)
        }
}

protocol WhenPaymentSucessfull{
    func sucussfullRetuern()
}
