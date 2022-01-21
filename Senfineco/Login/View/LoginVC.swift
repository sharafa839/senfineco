//
//  LoginVC.swift
//  Senfineco
//
//  Created by ahmed on 9/6/21.
//

import UIKit
import RxSwift
import RxCocoa
class LoginVC: UIViewController {
let disposeBag = DisposeBag()
    
    @IBOutlet weak var signInLa: UILabel!{
        didSet{
            signInLa.text = "signIn".localizede
        }
    }
    
    @IBOutlet weak var skip: UIButton!{
        didSet{
            skip.setTitle("skip".localizede, for: .normal)
            skip.floatButton(raduis: 15)
        }
    }
    @IBOutlet weak var phoneTF: UITextField!{
        didSet{
            phoneTF.placeholder = "phone".localizede
            phoneTF.floatView(raduis: 10)
            phoneTF.drawBorder(raduis: 10, borderColor:     .black)
            phoneTF.layer.borderWidth = 1
            phoneTF.placeHolderColor(color: .gray)
            phoneTF.keyboardType = .namePhonePad
}}
    @IBOutlet weak var passTF: UITextField!{
        didSet{
            passTF.placeholder = "password".localizede
            passTF.floatView(raduis: 15)
            passTF.drawBorder(raduis: 10, borderColor:     .black)
            passTF.layer.borderWidth = 1
            passTF.placeHolderColor(color: .gray)
            passTF.isSecureTextEntry = true
        }}
    @IBOutlet weak var visabilityButton: UIButton!{
        didSet{
            visabilityButton.tintColor = .black
        }}
    @IBOutlet weak var loginButton: UIButton!{
        didSet{
            loginButton.floatButton(raduis: 30)
            loginButton.setTitle("signIn".localizede, for: .normal)
        }}
    @IBOutlet weak var InfoLa: UILabel!{
        didSet{
            InfoLa.text = "ifudon'thave".localizede
        }}
    @IBOutlet weak var registerVcButton: UIButton!{
        didSet{
            registerVcButton.setTitle("signUp".localizede, for: .normal)
        }}
    @IBOutlet weak var forgetPassLa: UILabel!{
        didSet{
            forgetPassLa.text = "if you forget password".localizede
        }
    }
    @IBOutlet weak var forgetPassButton: UIButton!{
        didSet{
            forgetPassButton.setTitle("reset password".localizede, for: .normal)
        }
    }
    
    func checkValidUI(){
        guard  let phone = phoneTF.text,!phone.isEmpty else {
            phoneTF.shakeF()
            return
        }
        guard  let text = passTF.text,!text.isEmpty else {
            passTF.shakeF()
            return
        }
    }
    let login=loginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTextFieldToViewModel()
        checkValidateUi()
        subscribeToLoginButton()
      //  subscripeToVisabilityButton()
        subscribeToRespnse()
        resetPassword()
    }
    
    func resetPassword(){
        forgetPassButton.rx.tap.subscribe {[weak self] _ in
            guard let self = self else {return}
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "resetpassword")
            self.present(vc!, animated: true, completion: nil)
        }.disposed(by: disposeBag)

    }
    func bindTextFieldToViewModel() {
        phoneTF.rx.text.orEmpty.bind(to: login.phone).disposed(by: disposeBag)
        
        passTF.rx.text.orEmpty.bind(to: login.password).disposed(by: disposeBag)
         }
    func subscribeToLoginButton() {
        loginButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe {[weak self] (_) in
                guard let self = self else{return}
                self.login.login(vc: self)
            }.disposed(by: disposeBag)
    }
    func subscribeToRespnse(){
        login.loginModelObservable.subscribe { (dataa) in
            if dataa.element?.status == true {
                if dataa.element?.payload?.role == "wholesaler"{
                    HelperK.saveToken(token: dataa.element?.accessToken ?? "")
                    HelperK.setSellerData(phone: dataa.element?.payload?.phone ?? "", lname: dataa.element?.payload?.lname ?? "", fname: dataa.element?.payload?.fname ?? "", email: dataa.element?.payload?.email ?? "", type: dataa.element?.payload?.role ?? "", company: dataa.element?.payload?.company ?? "", crn: dataa.element?.payload?.crn ?? "")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "hom")
                    self.present(vc!, animated: true, completion: nil)
                }else{
                    HelperK.saveToken(token: dataa.element?.accessToken ?? "")
                    HelperK.setUserData(phone: dataa.element?.payload?.phone ?? "", lname: dataa.element?.payload?.lname ?? "", fname: dataa.element?.payload?.fname ?? "", email: dataa.element?.payload?.email ?? "", type: dataa.element?.payload?.role ?? "")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "hom")
                    self.present(vc!, animated: true, completion: nil)
                }
               
                
                
                
            }else{
                HelperK.showError(title: dataa.element?.message ?? "err".localizede, subtitle: "")
            }
        }.disposed(by: disposeBag)

    }
    func checkValidateUi()  {
        if login.isPhoneEmpty(){
            phoneTF.shakeF()
        }
    }
    func subscripeToVisabilityButton(){
        visabilityButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe { [weak self] (_) in
                guard let self = self else{return}
                self.passTF.isSecureTextEntry = !self.passTF.isSecureTextEntry
            }.disposed(by: disposeBag)
    }
}
