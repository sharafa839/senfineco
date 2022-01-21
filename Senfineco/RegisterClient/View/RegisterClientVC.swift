//
//  RegisterClientVC.swift
//  Senfineco
//
//  Created by ahmed on 9/6/21.
//

import UIKit
import MaterialComponents
import RxSwift
import RxCocoa
class RegisterClientVC: UIViewController {

    @IBOutlet weak var customView: UIView!{
        didSet{
            customView.floatView(raduis: 15)
        }
    }
    @IBOutlet weak var signUp: UILabel!{
        didSet{
            signUp.text = "signUp".localizede
        }
    }
    @IBOutlet weak var backButton: UIButton!{
        didSet{
            backButton.addActionn(vc: self, action: #selector(back))
        }
    }
    
    @IBOutlet weak var fNameTF: MDCOutlinedTextField!{
        didSet{
            fNameTF.label.text = "firstName".localizede
            fNameTF.setOutlineColor(.borderColor, for: .normal)
            fNameTF.setOutlineColor(.borderColor, for: .editing)

        }
    }
    @IBOutlet weak var lNameTF: MDCOutlinedTextField!{
        didSet{
            lNameTF.label.text = "lastName".localizede
            lNameTF.setOutlineColor(.borderColor, for: .normal)
            lNameTF.setOutlineColor(.borderColor, for: .editing)

        }
    }
    @IBOutlet weak var emailTF: MDCOutlinedTextField!{
        didSet{
            emailTF.label.text = "email".localizede
            emailTF.setOutlineColor(.borderColor, for: .normal)
            emailTF.setOutlineColor(.borderColor, for: .editing)

        }
    }
    @IBOutlet weak var phoneTF: MDCOutlinedTextField!{
        didSet{
            phoneTF.label.text = "phone".localizede
            phoneTF.keyboardType = .phonePad
            phoneTF.setOutlineColor(.borderColor, for: .normal)
            phoneTF.setOutlineColor(.borderColor, for: .editing)


        }
    }
    @IBOutlet weak var passTF: MDCOutlinedTextField!{
        didSet{
            passTF.label.text = "pass".localizede
            passTF.isSecureTextEntry = true
            passTF.setOutlineColor(.borderColor, for: .normal)
            passTF.setOutlineColor(.borderColor, for: .editing)

        }
    }
    @IBOutlet weak var confirmPassTF: MDCOutlinedTextField!{
        didSet{
            confirmPassTF.label.text = "Confirmpass".localizede
            confirmPassTF.isSecureTextEntry = true
            confirmPassTF.setOutlineColor(.borderColor, for: .normal)
            confirmPassTF.setOutlineColor(.borderColor, for: .editing)

        }
    }
    @IBOutlet weak var signUPButton: UIButton!{
        didSet{
            signUPButton.setTitle("signUp".localizede, for: .normal)
            signUPButton.setTitleColor(.gray, for:.disabled)
            signUPButton.floatButton(raduis: 30)
        }
    }
    @IBOutlet weak var infoLa: UILabel!{
        didSet{
            infoLa.text = "ifuhaveacc".localizede
        }
    }
    @IBOutlet weak var signInButton: UIButton!{
        didSet{
            signInButton.setTitle("signIn".localizede, for: .normal)
        }
    }
    @objc func back(){
        dismiss(animated: true, completion: nil)
    }
    let registerVm  = RegisterViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTextField()
       // subscribeToIsSignUpButtonEnabled()
        subscribeToSignupButton()
        subscribeToResponse()
    }
    func bindTextField(){
        fNameTF.rx.text.orEmpty.bind(to: registerVm.firstName).disposed(by: disposeBag)
        lNameTF.rx.text.orEmpty.bind(to: registerVm.lastName).disposed(by: disposeBag)
        emailTF.rx.text.orEmpty.bind(to: registerVm.email).disposed(by: disposeBag)
        passTF.rx.text.orEmpty.bind(to: registerVm.password).disposed(by: disposeBag)
        phoneTF.rx.text.orEmpty.bind(to: registerVm.phone).disposed(by: disposeBag)

    }
    func checkValidat(){
        
      
        guard let fName = fNameTF.text , !fName.isEmpty else {
            fNameTF.shakeF()
            return
        }
        guard  let lName = lNameTF.text ,!lName.isEmpty else {
            lNameTF.shakeF()
            return
        }
        guard  let email  = emailTF.text , !email.isEmpty else {
            emailTF.shakeF()
            return
        }
        guard  let phone  = phoneTF.text , !phone.isEmpty else {
            phoneTF.shakeF()
            return
        }
        guard  let pass = passTF.text , !pass.isEmpty else {
            passTF.shakeF()
            return
        }
        guard let passConfirm = confirmPassTF.text , !passConfirm.isEmpty else {
            confirmPassTF.shakeF()
            return
        }
        guard passConfirm == pass else {
            return
        }
    }
    func subscribeToSignupButton()  {
        signUPButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance).subscribe {[weak self] (_) in
            guard let self = self else {return}
            self.signUPButton.secAnimation()
            self.checkValidat()
            if self.confirmPassTF.text == self.passTF.text {
            self.registerVm.register(vc: self)
            }else {
                HelperK.showError(title: "notMatch".localizede, subtitle: "")

            }

        }.disposed(by: disposeBag)
}
    func subscribeToIsSignUpButtonEnabled() {
        registerVm.isSignUpButtonIsEnabled.bind(to: signUPButton.rx.isEnabled).disposed(by: disposeBag)
    }
    func subscribeToResponse() {
        registerVm.observableRegisterModel.subscribe { (data) in
            guard let payload = data.element else {
                return
            }
            if payload.status == true {
                HelperK.saveToken(token: payload.accessToken ?? "")
                HelperK.setUserData(phone: payload.payload?.phone ?? "", lname: data.element?.payload?.lname ?? "", fname: data.element?.payload?.fname ?? "", email: data.element?.payload?.email ?? "", type: "customer")
                let vc  = self.storyboard?.instantiateViewController(withIdentifier: "hom")
               
                self.present(vc!, animated: true, completion: nil)
               
                
            }else{
                HelperK.showError(title:"err".localizede , subtitle: "")
            }
        }.disposed(by: disposeBag)

    }

}
