//
//  HomeVC.swift
//  Senfineco
//
//  Created by sharaf on 10/10/2021.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa
class HomeVC: UIViewController {
  
    
    @IBOutlet weak var carGuideButton: UIButton!{
        didSet{
            carGuideButton.setTitle("carGuide".localizede, for: .normal)
        }
    }
    @IBOutlet weak var viewOfCarGuide: UIStackView!{
        didSet{
            viewOfCarGuide.floatView(raduis: 10)
            viewOfCarGuide.layer.borderWidth = 2
            viewOfCarGuide.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    @IBOutlet weak var oilPic: UIImageView!
    @IBOutlet weak var searchGuide: UIButton!{
        didSet{
            searchGuide.floatButton(raduis: 10)
            searchGuide.layer.borderWidth = 0.8
            searchGuide.coloringboder(color: .black)
            searchGuide.setTitleColor(.black, for: .normal)
            searchGuide.setTitle("search".localizede, for: .normal)
        }
    }
    @IBOutlet weak var welcomeStatement: UILabel!{
        didSet{
            welcomeStatement.text = "hi ".localizede + ""
        }
    }
    @IBOutlet weak var welcomeSt: UILabel!{
        didSet{
            welcomeSt.text = "Welcome to our shop".localizede
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var tableView: UITableView!
    let homeVm = HomeVM()
    let product = ProductVM()
    let transiton = SlideInTransition()

    let disposeBag = DisposeBag()
    var dataSource : RxTableViewSectionedReloadDataSource<productsSection>?
    override func viewDidLoad() {
        super.viewDidLoad()
        if HelperK.checkUserToken() == true {
            welcomeStatement.text = "hi ".localizede + HelperK.getname()
        }
        dataSource = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in

            tablView.rowHeight = 210
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTVC
            cell.configCell(product: Item)
            cell.addProductButton.rx.tap.subscribe {[weak self] (_) in
                guard let self = self else {return}
                guard let x  = Item.id else {return}
                print(x)
                self.product.AddToCart(productId: Item.id!, quantity: 1, customer: true, vc: self)
                HelperK.restartApp()
            }.disposed(by: cell.bag)
           

            return cell
            
        })

       
        getCategory()
        getProduct()
        subscribeToCategoryResponse()
        subscribeToProductResponse()
        subscribeToCategorySelection()
        subscribeToTableSelection()
        carGuidePerson()
        searchButton()
        unSubscribeSelection()
    }
    
    // MARK: - Table view data source
    func carGuidePerson(){
        carGuideButton.rx.tap.subscribe { [weak self]_ in
            guard let self = self else {return}
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "filter")
            self.present(vc!, animated: true, completion: nil)
        }.disposed(by: disposeBag)
        

    }
    func searchButton(){
        searchGuide.rx.tap.subscribe{[weak self]_ in
            guard let self = self else {return}
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "search")
            self.present(vc!, animated: true, completion: nil)
        }.disposed(by:disposeBag)
    }
    @IBAction func scrollLeftButton(_ sender: UIButton) {
        collectionView.setContentOffset(CGPoint(x: +50, y:0), animated: true)
        print(collectionView.contentOffset)
    }
    @IBAction func scrollRightButton(_ sender: UIButton) {
        collectionView.setContentOffset(CGPoint(x: -50, y:0), animated: true)
        print(collectionView.contentOffset)
    }
    @IBAction func sidemenueButtton(_ sender: UIButton) {
        GoToDrawer()
    }
    
    @IBAction func carguideButton(_ sender: UIButton) {
    }
    
  
        
    
    func getCategory(){
        homeVm.getCategory(vc: self)
        
    }
    func getProduct(){
        homeVm.getProduct(vc: self)
        
    }
    func subscribeToCategoryResponse(){
        homeVm.subscribeCategoryResponse.bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: HomeCVC.self)){row,data,cell in
            cell.cellShadowWithCornerRadius(color: .borderColor, opacity: 0.05, radius: 10, edge: .All, shadowSpace: 0.1, cornerRadius: 15)
            cell.configCell(categoty: data)
            //cell.sizeToFit()
            cell.layer.borderWidth = 0.5
        }.disposed(by: disposeBag)
        
    }
    func subscribeToProductResponse(){
        homeVm.subscribeProductResponse.map({ produst in
            [productsSection(headers: "", items: produst)]
        }).bind(to: tableView.rx.items(dataSource: dataSource!)).disposed(by: disposeBag)
        tableView.rowHeight = 230
    }
    func subscribeToCategorySelection(){
        Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(CategoryPayload.self)).bind { [weak self] (selectedIndex,data) in
            
            guard let self = self else {return}
            print(selectedIndex)
            let cell = self.collectionView.cellForItem(at: selectedIndex)
            
            cell?.coloringboder(color: .borderColor)
            guard let name = data.categoryNameEn else {return}

            self.subscripeToProductByCatID(name:name)
        }.disposed(by: disposeBag)
        
    }
    func unSubscribeSelection()  {
        Observable.zip(collectionView.rx.itemDeselected,collectionView.rx.modelDeselected(CategoryPayload.self)).bind{[weak self] (selectedIndex,data) in
            guard let self = self else {return}

            let cell = self.collectionView.cellForItem(at: selectedIndex)
            
            cell?.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
            cell?.layer.borderWidth = 1
        }.disposed(by: disposeBag)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.frame
        return CGSize(width: cell.size.width, height: cell.size.height)
    }
    func subscribeToTableSelection(){
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(ProductPayload.self)).bind{[weak self] selectedIndex,data in
            guard let self = self else {return}
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProducteDetailes") as!  ProductVC
            vc.product = data
            self.present(vc, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    func subscripeToProductByCatID(name:String){
        homeVm.getProductByCategory(productName: name, vc: self)    }
    
}
extension HomeVC: UIViewControllerTransitioningDelegate {
    
    
    @objc func GoToDrawer(){
        guard let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DrawerVC") as? DrawerVC else { return }
        menuViewController.modalPresentationStyle = .overFullScreen
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
   /*
    @objc func GoToCart(){
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartVC") as? CartVC else { return }
        vc.modalTransitionStyle   = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func GoToNotifications(){
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        vc.modalTransitionStyle   = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    private func initBottomView(model:homeModel) {
        let vc = ProductContentVC()
        vc.modalPresentationStyle = .custom
        vc.isHome = true
        vc.recModel = model
        self.present(vc, animated: true, completion: nil)
    }
    */
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
