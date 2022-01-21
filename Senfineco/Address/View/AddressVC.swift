//
//  AddressVC.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import UIKit
import RxSwift
import RxCocoa
import MaterialComponents
import RxDataSources
class AddressVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLa: UILabel!{
        didSet{
            titleLa.text = "addAddress".localizede
        }
    }
    @IBOutlet weak var addAddressla: UILabel!{
        didSet{
            addAddressla.text = "SelectYourAddress".localizede
        }
    }
    @IBOutlet weak var address: UILabel!{
        didSet{
            address.text = "addAddress".localizede
        }
    }
    @IBOutlet weak var addaddress: UIButton!
   
    @IBOutlet weak var tableVieww: UITableView!{
        didSet{
            tableVieww.floatView(raduis: 15)
        }
    }
    
   
    
    @IBOutlet weak var AddAddressButton: UIButton!{
        didSet{
            AddAddressButton.setTitle("addAddress".localizede, for: .normal)
            AddAddressButton.floatButton(raduis: 20)
        }
    }
    var dataSource : RxTableViewSectionedReloadDataSource<AddressSection>?
    var isOpen : Bool = false
    let disposeBag = DisposeBag()
    var price = Double()
    let addressVM = AddressVm()
    var adressSelected:AddressModelPayload?
    var State = false
    var orderID = Int()
    var addressId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
    }
    override func viewDidAppear(_ animated: Bool) {
        dataSource = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in

            tablView.rowHeight = 50
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddressTVC
            cell.confCell(address:Item)
            cell.editAddress.rx.tap.subscribe {[weak self] _ in
                guard let self = self else {return}
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "addAdress") as! AddAdressVC
                vc.adressSelected = Item
                vc.tag = 2
                self.present(vc, animated: true, completion: nil)
            }.disposed(by: self?.disposeBag ?? DisposeBag())
           cell.deleteAddress.rx.tap.subscribe { [weak self] _ in
                guard let self = self else {return}
                self.addressVM.deleteAddress(addressId: Item.id ?? 00, vc: self )
            }.disposed(by:self?.disposeBag ??  DisposeBag())

            return cell
            
        })
        tableVieww.isHidden = true
        getData()
        subscribeToRes()
        subscribeToRespnse()
        seletctedCell()
addAddress()
        backButtonz()
        subscribeToCheckOutPutton()
        subscribe()
    }
    override func viewDidDisappear(_ animated: Bool) {
        dataSource = nil
        tableVieww.dataSource = nil
        tableVieww.delegate = nil

    }
   
    func getData(){
        addressVM.getAllAddress()
    }
    func  subscribeToRespnse()  {
        addressVM.subscribeToMyAddress.map { addres in
            [AddressSection(headers: "", items: addres)]
        }.bind(to: tableVieww.rx.items(dataSource: dataSource!)).disposed(by: disposeBag)
    }
    func addAddress(){
        addaddress.rx.tap.subscribe { _ in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addAdress") as! AddAdressVC
            vc.price = self.price
            vc.orderID = self.orderID
            self.present(vc, animated: true, completion: nil)
        }.disposed(by: disposeBag)

    }
func subscribeToRes(){
    addressVM.subscribeToMyAddress.subscribe { [weak self]addresses in
        guard let self = self else {return}
        guard let adress = addresses.element else {return}
        if !adress.isEmpty {
            self.tableVieww.isHidden  = false
        }
    }.disposed(by: disposeBag)

}
    func seletctedCell(){
        Observable.zip(tableVieww.rx.itemSelected, tableVieww.rx.modelSelected(AddressModelPayload.self)).bind{index , data in
            self.adressSelected = data
            guard let ad = self.adressSelected else{return}
            self.addressId = ad.id ?? 00
    
        
        }.disposed(by: disposeBag)
    }
  
    
    func backButtonz(){
        backButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe {[weak self] (_) in
                guard let self = self else {return}

                let vc = self.storyboard?.instantiateViewController(identifier: "hom")
                self.present(vc!, animated: true, completion: nil)
            }.disposed(by: disposeBag)

    }
   
    func subscribe(){
        addressVM.subscribeTonewOrder.subscribe { (data) in
            self.orderID = data.element?.payload?.id ?? 0
            print("ahmed",self.price)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "checkout") as! CheckOutVC
                vc.Pricee = "\(self.price)"
            vc.orderID = self.orderID
            self.present(vc, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }

    
    func subscribeToCheckOutPutton(){

        AddAddressButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe { [weak self](_) in

                guard let self = self else {return}
                self.AddAddressButton.secAnimation()
                if self.addressId != nil {
                    self.addressVM.makeNewOrder(addressId: self.addressId ?? 00, vc: self)
                }
                
            }.disposed(by: disposeBag)
    
    
    // MARK: - Table view data source


   

    }}
