//
//  ProfileVC.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import UIKit
import RxCocoa
import RxSwift
class ProfileVC: UIViewController {

    @IBOutlet weak var regNumberTF: UITextField!{
        didSet{
            regNumberTF.isEnabled = false
        }
    }
    @IBOutlet weak var companyTf: UITextField!{
        didSet{
            companyTf.isEnabled = false
        }
    }
    @IBOutlet weak var fNameTF: UITextField!{
        didSet{
            fNameTF.isEnabled = false
            fNameTF.text = ""
        }
    }
    @IBOutlet weak var emailTF: UITextField!{
        didSet{
            emailTF.isEnabled = false
        }
    }
    @IBOutlet weak var phoneTF: UITextField!{
        didSet{
            phoneTF.keyboardType = .namePhonePad
            phoneTF.isEnabled = false
        }
    }
    @IBOutlet weak var changePasswordButton: UIButton!{
        didSet{
            changePasswordButton.setTitle("change".localizede, for: .normal)
            changePasswordButton.floatButton(raduis: 10)
        }
    }
    @IBOutlet weak var lNameTF: UITextField!{
        didSet{
            lNameTF.text = ""
            lNameTF.isEnabled = false
        }
    }
    @IBOutlet weak var registerationNumber: UILabel!{
        didSet{
            registerationNumber.text = "regnumber".localizede
        }
    }
    @IBOutlet weak var companyName: UILabel!{didSet{
        companyName.text = "companyName".localizede
    }}
    @IBOutlet weak var email: UILabel!{
        didSet{
            email.text = "email".localizede
        }
    }
    @IBOutlet weak var firstName: UILabel!{
        didSet{
            firstName.text = "firstName".localizede
        }
    }
    @IBOutlet weak var lastName: UILabel!{
        didSet{
            lastName.text = "lastName".localizede
        }
    }
    @IBOutlet weak var password: UILabel!{
        didSet{
            password.text = "password".localizede
        }
    }
    @IBOutlet weak var passla: UILabel!{
        didSet{
            passla.text = "*******"
        }
    }
    @IBOutlet weak var phoneNumber: UILabel!{
        didSet{
            phoneNumber.text = "phoneNumber".localizede
        }
    }
    @IBOutlet weak var editButton: UIButton!{
        didSet{
            editButton.setTitle("editProfile".localizede, for: .normal)
            editButton.floatButton(raduis: 15)
        }
    }
    let profile = Profile()
    let dispose = DisposeBag()
    @IBOutlet weak var line1: UIImageView!
    @IBOutlet weak var line2: UIImageView!
    var isEdit = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile".localizede
        if HelperK.checkUserToken() == true {
        if HelperK.getType() == "customer" {
            hideAnimating()

        }else{
            animateed()
        }
       getData()
        subcribeToResponse()
        subcribeToUpdateResponse()
        subscribeToButton()
        if isEdit == false {
            changePasswordButton.isHidden = true
            passla.isHidden = true
            view.sendSubviewToBack(changePasswordButton)
           // view.bringSubviewToFront(passla)

            passla.isHidden = false
        }else{
            changePasswordButton.isHidden = false
            view.bringSubviewToFront(changePasswordButton)
            view.sendSubviewToBack(passla)

            passla.isHidden = true
        }
        changePassbutton()
        }else{
            HelperK.showError(title: "you have to login to continue".localizede, subtitle: "")

            }
    }
    
    func getData(){
        if HelperK.getType() == "wholesaler"{
            profile.getProfileData(user: .Seller, vc: self)

        }else{
            profile.getProfileData(user: .Customer, vc: self)
        }
    }
    func subcribeToResponse()  {
        profile.subscribeToRespnse.subscribe {[weak self] (data) in
            guard let self = self else {return}

            self.fNameTF.text = data.element?.payload?.fname
            self.lNameTF.text = data.element?.payload?.lname
            self.phoneTF.text = data.element?.payload?.phone
            self.emailTF.text = data.element?.payload?.email
            if HelperK.getType() == "wholesaler"{
            self.companyTf.text = HelperK.getCompany()
            self.regNumberTF.text = HelperK.getCrn()
            }
        }.disposed(by: dispose)

    }
    func subcribeToUpdateResponse()  {
        profile.subscribeToUpdateRespnse.subscribe {[weak self] (data) in
            guard let self = self else {return}

            self.fNameTF.text = data.element?.payload?.fname
            self.lNameTF.text = data.element?.payload?.lname
            self.phoneTF.text = data.element?.payload?.phone
            self.emailTF.text = data.element?.payload?.email
            if HelperK.getType() == "wholesaler"{
            self.companyTf.text = HelperK.getCompany()
            self.regNumberTF.text = HelperK.getCrn()
            }
        }.disposed(by: dispose)

    }
    func changePassbutton(){
        changePasswordButton.rx.tap.subscribe { (_) in
            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "pass") as! ChangePasswordVC
            self.present(vc, animated: true, completion: nil)
        }.disposed(by: dispose)
    }
    func hideAnimating(){
        line1.isHidden = true
        line2.isHidden = true
        let scaleDownTransorm = CGAffineTransform(scaleX: 0, y: 0)
        companyTf.transform = scaleDownTransorm
        companyName.transform = scaleDownTransorm
        regNumberTF.transform  = scaleDownTransorm
        registerationNumber.transform = scaleDownTransorm
        let scaleDownFromObject = CGAffineTransform(translationX: 0, y: -emailTF.bounds.height - emailTF.frame.height)
        editButton.transform = scaleDownFromObject
    }
    func editProfile(){
        if HelperK.getType() == "wholesaler"{
            print("seller")
            profile.updateData(user: .Seller, fname: fNameTF.text ?? "", lname: lNameTF.text ?? "", phone: phoneTF.text ?? "", email: emailTF.text ?? "", crn: HelperK.getCrn(), company: HelperK.getCompany(), vc: self)
        }else{
            print("client")

            profile.updateData(user: .Customer, fname: fNameTF.text ?? "", lname: lNameTF.text ?? "", phone: phoneTF.text ?? "", email: emailTF.text ?? "", crn:"" , company: "", vc: self)
        }
    }
    func animateed(){
       
        editButton.transform = .identity
    }
    func subscribeToButton(){
        editButton.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}

            if self.isEdit == false {
                self.isEdit = true
                self.editButton.setTitle("saveChanges".localizede, for: .normal)
                self.fNameTF.isEnabled = true
                self.lNameTF.isEnabled = true
                self.phoneTF.isEnabled = true
                self.emailTF.isEnabled = true
                self.changePasswordButton.isHidden = false
              


            }else{
                self.isEdit = false
                self.editButton.setTitle("editProfile".localizede, for: .normal)
                self.fNameTF.isEnabled = false
                self.lNameTF.isEnabled = false
                self.phoneTF.isEnabled = false
                self.emailTF.isEnabled = false
                self.changePasswordButton.isHidden = true
              
                self.editProfile()
            }
        }.disposed(by: dispose)
    }
    // MARK: - Table view data source


}
