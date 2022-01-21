//
//  ResetPassVC.swift
//  Senfineco
//
//  Created by Ahmed on 31/10/2021.
//

import UIKit
import RxCocoa
import RxSwift
import MaterialComponents
class ResetPassVC: UIViewController {
    @IBOutlet weak var resetLa: UILabel!{
        didSet{
            resetLa.text = "reset password".localizede
        }
    }
    @IBOutlet weak var newPasswordTF: MDCOutlinedTextField!{
        didSet{
            newPasswordTF.label.text = "New password".localizede
        }
    }
    @IBOutlet weak var confirmNewPassord: MDCOutlinedTextField!{
        didSet{
            confirmNewPassord.label.text = "Confirm password".localizede
        }
    }
    @IBOutlet weak var changePasswordButton: UIButton!{
        didSet{
            changePasswordButton.setTitle("Change password".localizede, for: .normal)
            changePasswordButton.floatButton(raduis: 15)
        }
    }
    @IBOutlet weak var backButton: UIButton!
    let disposeBag = DisposeBag()
    var phone = String()
    let password = ResetPassword()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(phone)
back()
        changePassword()
        subscribeToResponse()
        // Do any additional setup after loading the view.
    }
    func back(){
        backButton.rx.tap.subscribe { _ in
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    func changePassword(){
        changePasswordButton.rx.tap.subscribe {[weak self] _ in
            guard let self = self else {return}
            self.changePasswordButton.secAnimation()
            guard let newpassword = self.newPasswordTF.text , !newpassword.isEmpty else {return}
            guard let confirm = self.confirmNewPassord.text , !confirm.isEmpty else {return}
            if newpassword == confirm {
            self.password.resetPassword(phone: self.phone, password: newpassword)
            }else{
                HelperK.showError(title: "notMatchin".localizede, subtitle: "")
            }
        }.disposed(by: disposeBag)

    }
    func subscribeToResponse(){
        password.resetPassowrdSubscribe.subscribe {[weak self] data in
            guard let self = self else {return}
            if data.element?.code == 200 {
                if data.element?.status == true {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
                    self.present(vc!, animated: true, completion: nil)
                    
                }
            }
          
          
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
