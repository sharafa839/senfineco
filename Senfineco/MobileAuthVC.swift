//
//  MobileAuthVC.swift
//  Senfineco
//
//  Created by Ahmed on 31/10/2021.
//

import UIKit

class MobileAuthVC: UIViewController {
    @IBOutlet weak var resetPasswordLa: UILabel!{
        didSet{
            resetPasswordLa.text = "reset password".localizede
        }
    }
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var PhoneTF: UITextField!{
        didSet{
            PhoneTF.placeholder = "phone".localizede
        }
    }
    @IBOutlet weak var verifuButton: UIButton!{
        didSet{
            verifuButton.setTitle("verify".localizede, for: .normal)
            verifuButton.floatButton(raduis: 15)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func verifyButton(_ sender: UIButton) {
        verifuButton.secAnimation()
        guard let phone = PhoneTF.text , !phone.isEmpty else {
            return
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "verify") as! PhoneVerifyVC
        vc.codeNum = "+968"
        vc.phoneNumber = phone
        present(vc, animated: true, completion: nil)
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
