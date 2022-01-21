//
//  CheckOutVC.swift
//  Senfineco
//
//  Created by ahmed on 9/11/21.
//

import UIKit
import RxSwift
import RxCocoa
class CheckOutVC: UIViewController, WhenPaymentSucessfull {
    func sucussfullRetuern() {
        Address.text = "your order is ready now , please wait".localizede
    }
    
    
    @IBOutlet weak var shipingPrice: UILabel!{
        didSet{
            shipingPrice.text = ""
        }
    }
    
    
    @IBOutlet weak var backButtton: UIButton!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var PurchaceCost: UILabel!{
        didSet{
            PurchaceCost.text = "purchaceCost".localizede
        }
    }
    @IBOutlet weak var shippingAddress: UILabel!{
        didSet{
            shippingAddress.text = "shippingAddress".localizede
        }
    }
    @IBOutlet weak var customViewAll: UIView!{
        didSet{
            customViewAll.floatView(raduis: 15)
        }
    }
    @IBOutlet weak var Address: UITextView!{
        didSet{
            Address.isEditable = false
        }
    }
    @IBOutlet weak var totalPrice: UILabel!{
        didSet{
            totalPrice.text = "totalPrice".localizede
        }
    }
    @IBOutlet weak var checkOut: UILabel!{
        didSet{
            checkOut.text = "checkOut".localizede
        }
    }
    @IBOutlet weak var customVieww: UIView!{
        didSet{
            customVieww.floatView(raduis: 10)
            customVieww.coloringboder(color: .black)
            customVieww.layer.borderColor = .init(red: 0, green: 0.68, blue: 0.71, alpha: 1)
        }
    }
    @IBOutlet weak var pricee: UILabel!
    @IBOutlet weak var payButton: UIButton!{
        didSet{
            payButton.setTitle("Pay".localizede, for: .normal)
           
                    payButton.floatView(raduis: 30)
                    payButton.backgroundColor = .black
        }
    }
    let confirmDelegate:PayVC? = nil
    var Pricee = String ()
    var address:AddressModelPayload?
    var orderID = Int()
    let disposeBag = DisposeBag()
    let addressVM = AddressVm()
    var totalPricee = Double()
var shipiingPrice = Double()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.Pricee)

        pricee.text = Pricee + "   OMR".localizede
        
        Address.text = address?.address?.street1
    getShippingPrice()
        print(self.orderID)
        subscribeToCheck()
        subscripeToShippingPrice()

    }
    func getShippingPrice (){
        addressVM.getShippingPrice()
    }
    func subscripeToShippingPrice(){
        addressVM.subscribeToshipingPrice.subscribe { [weak self] price in
            guard let self = self else {return}
            self.shipiingPrice = Double(price.element?.payload ?? 0)
            self.shipingPrice.text = "\(price.element?.payload ?? 000)"  + "   OMR".localizede
            self.totalPricee = Double(self.Pricee)! + self.shipiingPrice
            self.Price.text = "\(self.totalPricee)" +  "   OMR".localizede

        }.disposed(by: disposeBag)
    }
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func subscribeToCheck(){
        print(self.orderID)

        payButton.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
           
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "pay") as! PayVC
            vc.orderId = self.orderID
            vc.price = "\(self.totalPricee)"
            vc.delegate = self
                self.present(vc, animated: true, completion: nil)
           
        }.disposed(by: disposeBag)

    }
    
    // MARK: - Table view data source

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

