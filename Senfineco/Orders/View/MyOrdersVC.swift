//
//  MyOrdersVC.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
class MyOrdersVC: UIViewController {
    @IBOutlet weak var titleLa: UILabel!{
        didSet{
            titleLa.text = "myOrders".localizede
        }
    }
    @IBOutlet weak var switcher: UISegmentedControl!{
        didSet{
            switcher.selectedSegmentTintColor = .orange
            switcher.setTitle("Closed orders".localizede, forSegmentAt: 0)
            switcher.setTitle("Open orders".localizede, forSegmentAt: 1)
            
        }
    }
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var dataSource : RxTableViewSectionedReloadDataSource<OrdersModel>?
    let disposeBag = DisposeBag()
let order = Order()
    override func viewDidLoad() {
        super.viewDidLoad()
        if HelperK.checkUserToken() == true{
            
            tableView.tableFooterView?.isHidden = true
            
            
            dataSource = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in
                
                tablView.rowHeight = 260
                let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyOrderTVC
                cell.confCell(order: Item)
                cell.trackButton.rx.tap.subscribe { [weak self](_) in
                    print(indexPath)
                    guard let self = self else {return}
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tracking") as!TrackOrderVC
                    vc.id = Item.id ?? ""
                    vc.order = Item
                    self.present(vc, animated: true, completion: nil)
                }.disposed(by: self?.disposeBag ?? DisposeBag() )

                return cell
            })
            getData()
            responseToOrders()
        }else{
            HelperK.showError(title: "you have to login to continue".localizede, subtitle: "")
        }
       
        // Do any additional setup after loading the view.
    }
    @IBAction func Backing(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func getData(){
        order.GetOrders(status: "pending", vc: self)
    }
    func responseToOrders(){
        order.subscribeResponse.map ({ order  in
          [OrdersModel(section: "", items: order)]
            
          
        }).bind(to: tableView.rx.items(dataSource: dataSource!)).disposed(by: disposeBag)
    }
    @IBAction func `switch`(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            order.GetOrders(status: "pending", vc: self)
        }else{
            order.GetOrders(status: "accepted", vc: self)
        }
    }
    
}
