//
//  WholeSellerVC.swift
//  Senfineco
//
//  Created by ahmed on 9/16/21.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
class WholeSellerVC: UITableViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableVieww: UITableView!
    let homeVm = HomeVM()
    let product = ProductVM()
    let transiton = SlideInTransition()

    let disposeBag = DisposeBag()
    var dataSource : RxTableViewSectionedReloadDataSource<productsSection>?
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in

            tablView.rowHeight = 210
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WholeSellerTVC
            cell.configCell(product: Item)
            cell.addProductButton.rx.tap.subscribe {[weak self] (_) in
                guard let self = self else {return}

                self.product.AddToCart(productId: Item.id ?? 0, quantity: 1, customer: true, vc: self)
            }.disposed(by: self?.disposeBag ?? DisposeBag())
           

            return cell
            
        })

        collectionView.delegate = nil
        collectionView.dataSource = nil
        getCategory()
        getProduct()
        subscribeToCategoryResponse()
        subscribeToProductResponse()
        subscribeToCategorySelection()
        subscribeToTableSelection()
    }
    
    // MARK: - Table view data source
    
    @IBAction func scrollLeftButton(_ sender: UIButton) {
        collectionView.setContentOffset(CGPoint(x: 50, y:0), animated: true)
        print(collectionView.contentOffset)
    }
    @IBAction func scrollRightButton(_ sender: UIButton) {
        collectionView.setContentOffset(CGPoint(x: -50, y:0), animated: true)
        print(collectionView.contentOffset)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func getCategory(){
        homeVm.getCategory(vc: self)
        
    }
    func getProduct(){
        homeVm.getProduct(vc: self)
        
    }
    func subscribeToCategoryResponse(){
        homeVm.subscribeCategoryResponse.bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: wholeSellerCVC.self)){row,data,cell in
            
            cell.configCell(categoty: data)
            
        }.disposed(by: disposeBag)
        
    }
    func subscribeToProductResponse(){
        homeVm.subscribeProductResponse.map({ produst in
            [productsSection(headers: "", items: produst)]
        }).bind(to: tableVieww.rx.items(dataSource: dataSource!)).disposed(by: disposeBag)
        tableVieww.rowHeight = 230
    }
    func subscribeToCategorySelection(){
        Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(CategoryPayload.self)).bind { [weak self] selectedIndex,data in
            guard let self = self else {return}
            print(selectedIndex)
            print(data.id)
            self.subscripeToProductByCatID(name: data.categoryNameEn ?? "")
        }.disposed(by: disposeBag)
        
    }
    func subscribeToTableSelection(){
        Observable.zip(tableVieww.rx.itemSelected, tableVieww.rx.modelSelected(ProductPayload.self)).bind{[weak self] selectedIndex,data in
            guard let self = self else {return}
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProducteDetailes") as!  ProductVC
            vc.product = data
            self.present(vc, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    func subscripeToProductByCatID(name:String){
        homeVm.getProductByCategory(productName: name, vc: self)
    }
    
}
