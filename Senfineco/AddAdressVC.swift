//
//  AddAdressVC.swift
//  Senfineco
//
//  Created by sharaf on 25/10/2021.
//

import UIKit
import MaterialComponents
import RxSwift
import RxCocoa
class AddAdressVC: UIViewController {
    @IBOutlet weak var address: UILabel!{
        didSet{
            address.text = "addAddress".localizede
        }
    }
    @IBOutlet weak var city: MDCOutlinedTextField!{
        didSet{
            city.label.text = "city".localizede
            city.setOutlineColor(.borderColor, for: .editing)
            city.setOutlineColor(.borderColor, for: .normal)
        }
    }
    @IBOutlet weak var state: MDCOutlinedTextField!{
        didSet{
            state.label.text = "state".localizede
            state.setOutlineColor(.borderColor, for: .editing)
            state.setOutlineColor(.borderColor, for: .normal)
        }
    }
    @IBOutlet weak var Notes: MDCOutlinedTextField!{
        didSet{
            Notes.label.text = "markPlace".localizede
            Notes.setOutlineColor(.borderColor, for: .editing)
            Notes.setOutlineColor(.borderColor, for: .normal)

        }
    }
  
    @IBOutlet weak var PhoneTF: MDCOutlinedTextField!{
        didSet{
            PhoneTF.label.text = "whats app".localizede
            PhoneTF.setOutlineColor(.borderColor, for: .editing)
            PhoneTF.setOutlineColor(.borderColor, for: .normal)
            PhoneTF.keyboardType = .phonePad

        }
    }
  
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var AddAddressButton: UIButton!{
        didSet{
            AddAddressButton.setTitle("addAddress".localizede, for: .normal)
            AddAddressButton.floatButton(raduis: 20)
        }
    }
    var price = Double()
    var tag = Int()

    let addressVM = AddressVm()
    var adressSelected:AddressModelPayload?
    var State = false
    var orderID = Int()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        if tag == 2 {
            AddAddressButton.tag = 2
            AddAddressButton.setTitle("updateAddress".localizede, for: .normal)
            city.text = adressSelected?.address?.city
            Notes.text = adressSelected?.address?.notes
            PhoneTF.text = adressSelected?.address?.phone
            state.text =  adressSelected?.address?.state


        }
        bindtextFields()
        subscribe()
        subscribeToButton()
        subscribeToCheckOutPutton()
        backButtonz()
        // Do any additional setup after loading the view.
    }
    
    func bindtextFields(){
       
        city.rx.text.orEmpty.bind(to: addressVM.city).disposed(by: disposeBag)

        PhoneTF.rx.text.orEmpty.bind(to: addressVM.phone).disposed(by: disposeBag)
        Notes.rx.text.orEmpty.bind(to: addressVM.notes).disposed(by: disposeBag)
        state.rx.text.orEmpty.bind(to: addressVM.state).disposed(by: disposeBag)

    }
    
     func subscribe(){
         addressVM.subscribeTonewOrder.subscribe { (data) in
             self.orderID = data.element?.payload?.id ?? 0
             print("ahmed",self.price)
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "checkout") as! CheckOutVC
                 vc.Pricee = "\(self.price)"
             vc.orderID = self.orderID
             self.present(vc, animated: true, completion: nil)
         }.disposed(by: disposeBag)
     }
    func subscribeToButton(){
        addressVM.obs.bind(to: AddAddressButton.rx.isEnabled).disposed(by: disposeBag)
    }
    func subscribeToCheckOutPutton(){
        if AddAddressButton.tag == 0 {
        AddAddressButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe { [weak self](_) in

                guard let self = self else {return}
                self.AddAddressButton.secAnimation()
                self.addressVM.makeNewOrderTextField()
                self.addressVM.subscribeTonewOrder.subscribe { (data) in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "checkout") as! CheckOutVC
                    vc.Pricee = "\(self.price)"
                        vc.address = self.adressSelected
                    vc.orderID = data.element?.payload?.id ?? 0
                self.present(vc, animated: true, completion: nil)
                }.disposed(by: self.disposeBag)

                   
            }.disposed(by: disposeBag)
        }else{
            AddAddressButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
                .subscribe { [weak self](_) in

                    guard let self = self else {return}
                    self.AddAddressButton.secAnimation()
                   
                    self.addressVM.updateAddress(addressId: self.adressSelected?.id ?? 00, city: self.city.text ?? "", state: self.state.text ?? "" , phone: self.PhoneTF.text ?? "", notes: self.Notes.text ?? "", vc: self)
                    self.dismiss(animated: true, completion: nil)
                    }.disposed(by: self.disposeBag)

                       
               
        }
      
    }
    func backButtonz(){
        backButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe {[weak self] (_) in
                guard let self = self else {return}

                self.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
