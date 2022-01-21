//
//  SendMessageVC.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import UIKit
import RxCocoa
import RxSwift
import MaterialComponents
class SendMessageVC: UIViewController {

    @IBOutlet weak var customView: UIView!{
        didSet{
            customView.floatView(raduis: 15)
            customView.applyShadowWithCornerRadius(color: .borderColor, opacity: 0.5, radius: 15, edge: .All, shadowSpace: 0.5, cornerRadius: 15)
        }
    }
    @IBOutlet weak var messageTF: MDCOutlinedTextField!{
        didSet{
            messageTF.label.text = "message".localizede
            messageTF.setOutlineColor(.borderColor, for: .normal)
            messageTF.setOutlineColor(.borderColor, for: .editing)
        }
    }
    @IBOutlet weak var subjectTF: MDCOutlinedTextField!{
        didSet{
            subjectTF.label.text = "subjectTF".localizede
            subjectTF.setOutlineColor(.borderColor, for: .normal)
            subjectTF.setOutlineColor(.borderColor, for: .editing)
        }
    }
    @IBOutlet weak var name: MDCOutlinedTextField!{
        didSet{
            name.label.text = "name".localizede
            name.setOutlineColor(.borderColor, for: .normal)
            name.setOutlineColor(.borderColor, for: .editing)

        }
    }
    @IBOutlet weak var titleLa: UILabel!{
        didSet{
            titleLa.text = "sendMessage".localizede
        }
    }
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var sendMessage: UIButton!{
        didSet{
            sendMessage.floatButton(raduis: 20)
            sendMessage.setTitle("send".localizede, for: .normal)
        }
    }
    let messagee = contact()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
subscribeToButton()
        backSubscribe()
        bindTextField()
        // Do any additional setup after loading the view.
    }
    func bindTextField(){
        name.rx.text.orEmpty.bind(to: messagee.name).disposed(by: disposeBag)
        messageTF.rx.text.orEmpty.bind(to: messagee.message).disposed(by: disposeBag)
        subjectTF.rx.text.orEmpty.bind(to: messagee.subject).disposed(by: disposeBag)

    }
    func subscribeToButton(){
        sendMessage.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            self.sendMessage.secAnimation()
            guard let namee = self.name.text,!namee.isEmpty else{
                self.name.shakeF()
                return}
            guard let subjectt = self.subjectTF.text,!subjectt.isEmpty else{
                self.subjectTF.shakeF()
                return}
            guard let message = self.messageTF.text,!message.isEmpty else{
                self.messageTF.shakeF()
                return}
            self.messagee.sendMessage(vc: self)
        }.disposed(by:disposeBag )
        
    }
    
    func backSubscribe(){
        back.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }


}
