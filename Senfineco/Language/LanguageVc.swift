//
//  LanguageVc.swift
//  Joud
//
//  Created by ahmed on 7/2/21.
//

import UIKit

class LanguageVc: UIViewController {

  
  
    @IBOutlet weak var lang: UILabel!{
        didSet{
            lang.text = "Lang".localizede
        }
    }
   
    @IBOutlet weak var arab: UIStackView!{
        didSet{
            arab.floatView(raduis: 10)
            arab.clipsToBounds = true
            arab.layer.borderWidth = 0.5
            arab.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    @IBOutlet weak var eng: UIStackView!{
    didSet{
        eng.floatView(raduis: 10)
        eng.clipsToBounds = true
        eng.layer.borderWidth = 0.5
        eng.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
    @IBOutlet weak var engLangButton: UIButton!{
        didSet{
            engLangButton.setTitle("en".localizede, for: .normal)
            engLangButton.addTarget(self, action:  #selector(chooseLanguage), for: .touchUpInside)
            
        }
    }
   
    @IBOutlet weak var arabLangButton: UIButton!{
        didSet{
            arabLangButton.setTitle("ar".localizede, for: .normal)
            arabLangButton.addTarget(self, action:  #selector(chooseLanguage1), for: .touchUpInside)
            arabLangButton.layer.cornerRadius = 10
            arabLangButton.clipsToBounds = true

        }
    }
    @IBOutlet weak var englishImage: UIImageView!{
        didSet{
            englishImage.addActionn(vc: self, action: #selector(chooseLanguage))
        }
    }
    
    @IBOutlet weak var arabImage: UIImageView!{
        didSet{
            arabImage.addActionn(vc: self, action: #selector(chooseLanguage1))
        }
    }
    @objc func chooseLanguage(){
        eng.layer.borderWidth = 0

        eng.backgroundColor = .init(red: 0.960, green: 0.550, blue: 0.120, alpha: 1)
        arab.backgroundColor = .clear
        arabLangButton.setTitleColor(.init(red: 0, green: 0.31, blue: 0.62, alpha: 1), for: .normal)
        eng.floatView(raduis: 15)
        eng.setRoundCorners(15)
        engLangButton.setTitleColor(.white, for: .normal)
        LocalizationManager.shared.setLanguage(language:.English)
        UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        HelperK.saveFristTime(token: 1)
        HelperK.saveLang(Lang:LocalizationManager.shared.getLanguage()?.rawValue ?? "en")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginVC
            self.present(vc, animated: true, completion: nil)
        }
      
    }
    @objc func chooseLanguage1(){
        arab.layer.borderWidth = 0

        arab.backgroundColor = .init(red: 0.960, green: 0.550, blue: 0.120, alpha: 1)

        eng.backgroundColor = .clear
        engLangButton.setTitleColor(.init(red: 0, green: 0.31, blue: 0.62, alpha: 1), for: .normal)
        arabLangButton.setTitleColor(.white, for: .normal)
        arab.floatView(raduis: 15)
        arab.setRoundCorners(15)
        LocalizationManager.shared.setLanguage(language: .Arabic)
       UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        HelperK.saveFristTime(token: 1)
        HelperK.saveLang(Lang:LocalizationManager.shared.getLanguage()?.rawValue ?? "ar")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginVC
            self.present(vc, animated: true, completion: nil)
        }
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: UIButton) {
        HelperK.saveFristTime(token: 1)
        HelperK.saveLang(Lang:LocalizationManager.shared.getLanguage()?.rawValue ?? "en")
        HelperK.restartApp()
//performSegue(withIdentifier: "go", sender: self)
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
