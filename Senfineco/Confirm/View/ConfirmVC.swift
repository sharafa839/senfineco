//
//  ConfirmVC.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import UIKit
import RxSwift
import RxCocoa
class ConfirmVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!{
        didSet{
            confirmButton.setTitle("confirm".localizede, for: .normal)
            confirmButton.floatButton(raduis: 20)
        }
    }
    @IBOutlet weak var confrmLA: UILabel!{
        didSet{
            confrmLA.text = "confirm".localizede
        }
    }
    @IBOutlet weak var _tf1: UITextField!
    @IBOutlet weak var _tf2: UITextField!
    @IBOutlet weak var _tf3: UITextField!
    @IBOutlet weak var _tf4: UITextField!
    var kind = String()
    var id = String()
    var Otp = String()
let conf = Confirm()
    let disposbaag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        setupView()
       subscribeToButton()
backButtonn()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavigationBar()
        self.setTranslucentForNavigation()
          _tf1.becomeFirstResponder()
        self.view.layoutIfNeeded()
    }
    func backButtonn(){
        backButton.rx.tap.subscribe { [weak self ]_ in
            guard let self = self else {return}
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposbaag)
    }
    func setupView(){
      //  hideKeyboardWhenTappedAround()
        _tf1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        _tf2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        _tf3.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        _tf4.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
      
    }
    
    @objc func textFieldDidChange(textField:UITextField) {
        let text=textField.text
        if text?.utf16.count == 1 {
            switch textField{
            case _tf1:
                _tf2.becomeFirstResponder()
            case _tf2:
                _tf3.becomeFirstResponder()
            case _tf3:
                _tf4.becomeFirstResponder()
            case _tf4:
                _tf4.resignFirstResponder()
            
            default:
                break
                
            }} else{ }}
    func subscribeToButton(){
        confirmButton.rx.tap.throttle(RxTimeInterval.microseconds(5000), scheduler: MainScheduler.instance)
            .subscribe {[weak self] (_) in
                
                guard let self = self else {return}
                self.confirmButton.secAnimation()

                guard let code1 = self._tf1.text , !code1.isEmpty else {return}
                guard let code2 = self._tf2.text , !code2.isEmpty else {return}
                guard let code3 = self._tf3.text , !code3.isEmpty else {return}
                guard let code4 = self._tf4.text , !code4.isEmpty else {return}
                let code = code1 + code2 + code3 + code4
                self.conf.confirm(OTP:Int(code) ?? 1111, userID: self.id, vc: self)
                self.subToRes()

            }.disposed(by: disposbaag)

    }
    func subToRes(){
        print("mdlsamdlksamdslamd",5555)
        conf.loginModelObservable.subscribe { (data) in
            if self.kind == "customer"{
                print("mdlsamdlksamdslamd",6666)

                if data.element?.status == true {
                 
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "hom")
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                HelperK.saveToken(token: data.element?.accessToken ?? "")
                HelperK.setSellerData(phone: data.element?.payload?.phone ?? "", lname: data.element?.payload?.lname ?? "", fname: data.element?.payload?.fname ?? "", email: data.element?.payload?.email ?? "", type: data.element?.payload?.role ?? "", company: data.element?.payload?.company ?? "", crn: data.element?.payload?.crn ?? "")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "hom")
                self.present(vc!, animated: true, completion: nil)
            }
        }.disposed(by: disposbaag)

    }
   

}
