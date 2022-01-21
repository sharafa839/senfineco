//
//  AboutVC.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import UIKit
import RxSwift
import RxCocoa
class AboutVC: UIViewController {
    @IBOutlet weak var titlela: UILabel!{
        didSet{
            titlela.text = "aboutUs".localizede
        }
    }
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var instaramButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var snapchatButton: UIButton!
    @IBOutlet weak var about: UITextView!{
        didSet{
            about.isEditable = false
            about.floatView(raduis: 10)
        }
    }
    let disposeBag = DisposeBag()
let abouts = Abouts()
    var twitter = String()
    var facbook = String()
    var instgram = String()
    var snapchat = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        subscribeToData()
        
        backSubscribe()
        twitterSubscribe()
        faceBookSubscribe()
        instgramSubscribe()
instgramSubscribe()
    }
    func getData() {
        abouts.getAbout(vc: self)
       
        
    }
    func subscribeToData(){
        abouts.subscribeToRes.subscribe { [weak self ](data) in
            guard let self = self else {return}

            guard let about = data.element?.payload?.aboutUs else {return}
            if LocalizationManager.shared.getLanguage() == .Arabic {
                self.about.text = about.bodyAr
            }else{
                self.about.text = about.body
            }
                guard let twitter =  data.element?.payload?.social?.twitter else {return}
            guard let facebook =  data.element?.payload?.social?.facebook else {return}
            guard let instgram =  data.element?.payload?.social?.instagram else {return}
            guard let snapchat =  data.element?.payload?.social?.snapchat else {return}

            self.twitter = twitter
            self.facbook = facebook
            self.instgram = instgram
            self.snapchat = snapchat
            
        }.disposed(by: disposeBag)

    }

    func backSubscribe(){
        back.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    func twitterSubscribe(){
        twitterButton.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            HelperK.openTwitter(twitter: self.twitter)
        }.disposed(by: disposeBag)
    }
    func faceBookSubscribe(){
        facebookButton.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            HelperK.openFacebook(facebook: self.facbook)
        }.disposed(by: disposeBag)
    }
    func instgramSubscribe(){
        instaramButton.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            HelperK.openInstagram(instgram: self.instgram)
        }.disposed(by: disposeBag)
    }
    func snapchatSubscribe(){
        snapchatButton.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            HelperK.openSnapChat(username: self.snapchat)
        }.disposed(by: disposeBag)
    }
    
}
