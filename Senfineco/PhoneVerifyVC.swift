import UIKit
import Firebase
import FirebaseAuth
class PhoneVerifyVC: UIViewController {
    @IBOutlet weak var TF1: UITextField!
    @IBOutlet weak var TF2: UITextField!
    @IBOutlet weak var TF3: UITextField!
    @IBOutlet weak var TF4: UITextField!
    @IBOutlet weak var TF5: UITextField!
    @IBOutlet weak var TF6: UITextField!
    @IBOutlet weak var weSent: UILabel!{
        didSet{
            weSent.text = "WeSent".localized + phoneNumber
        }
    }
    @IBOutlet weak var verify: UILabel!{
        didSet{
            verify.text = "verify".localizede
        }
    }
    @IBOutlet weak var verifyButton: UIButton! {
        didSet {
            self.verifyButton.setTitle("verify".localizede,for: .normal)
            self.verifyButton.floatButton(raduis: self.verifyButton.bounds.height/2)
        }}
  
  
    
    var phoneNumber=""
    lazy var codeNum = "0"
    lazy var phon = ""
    var recType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

      callVerifyFunc()
        setupView()
        print(recType)
        print(codeNum + phoneNumber)

    }
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // keyboard appers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavigationBar()
        self.setTranslucentForNavigation()
          TF1.becomeFirstResponder()
        self.view.layoutIfNeeded()
    }
    
    func setupView(){
      //  hideKeyboardWhenTappedAround()
        verifyButton.layer.cornerRadius=verifyButton.frame.height / 2
        TF1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        TF2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        TF3.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        TF4.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        TF5.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        TF6.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(textField:UITextField) {
        let text=textField.text
        if text?.utf16.count == 1 {
            switch textField{
            case TF1:
                TF2.becomeFirstResponder()
            case TF2:
                TF3.becomeFirstResponder()
            case TF3:
                TF4.becomeFirstResponder()
            case TF4:
                TF5.becomeFirstResponder()
            case TF5:
                TF6.becomeFirstResponder()
            case TF6:
                TF6.resignFirstResponder()
            default:
                break
                
            }} else{ }}
    
    
    @IBAction func validateButton(_ sender: UIButton) {
        sender.springAnimate()
        Vibration.medium.vibrate()
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        var code=TF1.text!+TF2.text!+TF3.text!+TF4.text!
        code=code+TF5.text!+TF6.text!
        let verificationCode=code
       if verificationID?.isEmpty == false {
        let credential = PhoneAuthProvider.provider().credential(
                        withVerificationID: verificationID!,
                        verificationCode: verificationCode)
        
            Auth.auth().signIn(with: credential) { (authResult, error) in
                    if let error = error {
                    print(error.localizedDescription)
                        HelperK.showError(title: "Code Not matching".localizede, subtitle: "")
                return
            }
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "reset") as! ResetPassVC
                vc.phone = self.phoneNumber
                self.present(vc, animated: true, completion: nil)
           //  print("sign in success")
                
                
            }}}
 
    
    func callVerifyFunc()  {
        //Auth.auth().settings?.isAppVerificationDisabledForTesting=true
        PhoneAuthProvider.provider().verifyPhoneNumber(codeNum + phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
             //   self.showMessagePrompt(error.localizedDescription)
                print("error \(error.localizedDescription)")
                return
            }
            if verificationID != nil {
              //  print("gg")
            } else {
               // print("empty")
            }
        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            UserDefaults.standard.synchronize()
        }}

    
}
