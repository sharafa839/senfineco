//
//  CartVC.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class CartVC: UIViewController {

    @IBOutlet weak var titleLa: UILabel!{
        didSet{
            titleLa.text = "CART".localizede
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLa: UILabel!{
        didSet{
            totalPriceLa.text = "totalPrice".localizede
        }
    }
    @IBOutlet weak var priceLa: UILabel!{
        didSet{
            priceLa.text = "0 OMR".localizede
        }
    }
    @IBOutlet weak var payButton: UIButton!{
        didSet{
            payButton.setTitle("Continue to checkout".localizede, for: .normal)
            payButton.floatButton(raduis: 20)
            payButton.isHidden = true
        }
    }
   
    
    var price = 0.0

    let cartVm = CartVm()
    var id = Int()
    var dataSource : RxTableViewSectionedReloadDataSource<sectionCart>?

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        }
    override func viewDidAppear(_ animated: Bool) {
        dataSource = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in
            tablView.rowHeight = 150
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartTVC
            cell.getCart(cart: Item)
            cell.delete.rx.tap.subscribe { [weak self](_) in
                guard let self = self else {return}
                self.cartVm.deleteProduct(id: Item.productID ?? 0, vc: self)
                tablView.dataSource = nil
                tablView.delegate = nil
                
                HelperK.restarttApp()
            }.disposed(by: cell.bag)
            cell.minus.rx.tap.subscribe { [weak self](_) in
                guard let self = self else {return}
                self.cartVm.decreaseQuantity(id: Item.productID ?? 0, vc: self)
               // self.cartVm.getCartData()
                tablView.dataSource = nil
                tablView.delegate = nil
                self.getData()
                self.subscribeToRes()
                self.getDataInTableView()
                
         

            }.disposed(by: cell.bag)
            cell.summtion.rx.tap.subscribe {[weak self] (_) in
                guard let self = self else {return}
                self.cartVm.increaseQuantity(id: Item.productID ?? 0, vc: self)
                tablView.dataSource = nil
                tablView.delegate = nil
                self.getData()
                self.subscribeToRes()
                self.getDataInTableView()
              //  self.cartVm.getCartData()
               

               
            }.disposed(by:cell.bag)

            return cell
            })
    
        
        getData()
        subscribeToRes()

        subscribeToFail()
        getDataInTableView()
        subscribeTocheckOut()

subscribeWhenTappedInCell()
    }
    override func viewDidDisappear(_ animated: Bool) {
        price = 0
        dataSource = nil
        tableView.dataSource = nil
        tableView.delegate = nil
        payButton.isHidden = true
        priceLa.text = "0"
    }
    func getData(){
        cartVm.getCartData(vc: self)
    }
    func subscribeToFail(){
        cartVm.subscripeToFail.subscribe { [weak self] fail in
            guard let self = self else {return}

            self.payButton.isHidden = true
            self.priceLa.text = "no Items in cart".localizede
        }.disposed(by: disposeBag)

    }
    func sumofEachProduct(number:Double){
        cartVm.subscripeToResponse.subscribe {[weak self] (data) in
            guard let self = self else {return}
        guard let pro = data.element?.payload?.products else {return}
            guard let pricce = data.element?.payload?.total else {return}
        for i in pro{
            self.price += Double(i.total!)*number
            self.priceLa.text = "\(pricce)" + "   OMR".localizede
        }}.disposed(by: disposeBag)
    }
    func subscribeToRes(){
        cartVm.subscripeToResponse.subscribe {[weak self] (data) in
            guard let self = self else {return}
            guard let pricce = data.element?.payload?.total else {return}

            self.payButton.isHidden = false
            self.price = 0.0

         
         
                self.price = pricce
                self.priceLa.text = "\(pricce)" + "   OMR".localizede
            
           
        }.disposed(by: disposeBag)
        
    }
    func subscribeTocheckOut(){
        payButton.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
           
            self.payButton.secAnimation()

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "address") as! AddressVC
            vc.price = self.price
            self.present(vc, animated: true, completion: nil)
        }.disposed(by: disposeBag)

    }
    func getDataInTableView(){
        
        cartVm.subscripeToResponse.map{ cart in
            [sectionCart(items: cart.payload?.products ?? [Products](), heades: "")]
        }.bind(to: tableView.rx.items(dataSource: dataSource!)).disposed(by: disposeBag)
        
}
    func subscribeWhenTappedInCell(){
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Products.self)).bind {[weak self]selectedInsex,model in
            guard let self = self else {return}

            self.id = model.productID ?? 0
            print(self.id)
        }.disposed(by: disposeBag)
       
    }
    @objc func minusQuantity (sender:UIButton){
        cartVm.decreaseQuantity(id:id, vc: self)
        subscribeToRes()
}
    @objc func addQuantity (sender:UIButton){
        cartVm.increaseQuantity(id: id, vc: self)
        subscribeToRes()
}
    @objc func delete (sender:UIButton){
        cartVm.deleteProduct(id: id, vc: self)
}

}

