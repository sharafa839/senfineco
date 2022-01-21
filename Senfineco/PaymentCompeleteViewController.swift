//
//  PaymentCompeleteViewController.swift
//  Senfineco
//
//  Created by sharaf on 26/10/2021.
//

import UIKit

class PaymentCompeleteViewController: UIViewController {

    @IBOutlet weak var cusomView: UIView!{
        didSet{
            cusomView.floatView(raduis: 20)
        }
    }
    @IBOutlet weak var paymentSucess: UILabel!{
        didSet{
            paymentSucess.text = "sucessfullyPayment".localizede
        }
    }
    @IBOutlet weak var GotoHomeButton: UIButton!{
        didSet{
            GotoHomeButton.setTitle("GoToHome".localizede, for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func Home(_ sender: UIButton) {
        HelperK.restarttApp()
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
