//
//  ChangePasswordVC.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import UIKit
import RxCocoa
import RxSwift
class ChangePasswordVC: UIViewController {

    @IBOutlet weak var visableOld: UIButton!
    @IBOutlet weak var visableNew: UIButton!
    @IBOutlet weak var old: UITextField!{
        didSet{
            old.placeholder = "oldPass".localizede
        }
    }
    @IBOutlet weak var newPassTF: UITextField!{
        didSet{
            newPassTF.placeholder = "newPass".localizede
        }
    }
    @IBOutlet weak var titlela: UILabel!{
        didSet{
            titlela.text = "changepassword".localizede
        }
    }
    @IBOutlet weak var changePass: UIButton!{
        didSet{
            changePass.setTitle("changePass".localizede, for: .normal)
            changePass.floatButton(raduis: 20)
        }
    }
    @IBOutlet weak var back: UIButton!
let updatePass = ChangePassword()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
bindTextField()
        backSubscribe()
        subscribeToChangeButton()
        subscribeToViableOld()
        subscribeToViableNew()
        // Do any additional setup after loading the view.
    }
    func bindTextField(){
        old.rx.text.orEmpty.bind(to: updatePass.oldPassword).disposed(by: disposeBag)
        newPassTF.rx.text.orEmpty.bind(to: updatePass.newPassword).disposed(by: disposeBag)

    }
   
    func backSubscribe(){
        back.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }

    func subscribeToChangeButton(){
        changePass.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe {[weak self] (_) in
                guard let self = self else {return}

                self.changePass.secAnimation()
                guard let old = self.old.text , !old.isEmpty else{
                    return
                }
                guard let new = self.newPassTF.text , !new.isEmpty else{
                    return
                }
                self.updatePass.changePassword(vc: self)
            }.disposed(by: disposeBag)

    }
    func subscribeToViableOld() {
        visableOld.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}

            self.old.isSecureTextEntry = !self.old.isSecureTextEntry
        }.disposed(by: disposeBag)

    }
    func subscribeToViableNew() {
        visableNew.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}

            self.newPassTF.isSecureTextEntry = !self.newPassTF.isSecureTextEntry
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
