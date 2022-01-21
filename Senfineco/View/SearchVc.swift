//
//  SearchVc.swift
//  Senfineco
//
//  Created by Ahmed on 04/10/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class SearchVc: UIViewController ,UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let product = ProductVM()

    let disposeBag = DisposeBag()
    var dataSource : RxTableViewSectionedReloadDataSource<productsSection>?
    let searchVm = SearchVm()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        dataSource = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tableView, indexPath,Item)   in

            tableView.rowHeight = 210
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTVC
                
            cell.configCell(product: Item)
            cell.addToCart.rx.tap.subscribe(onDisposed:  {[weak self] () in
                guard let self = self else {return}
                
                self.product.AddToCart(productId: Item.id ?? 0, quantity: 1, customer: true, vc: self)
            }).disposed(by: self?.disposeBag ?? DisposeBag())
           

            return cell
            
        })
        getresultOfSearch()
    }
    func getresultOfSearch(){
        searchVm.searchResultObservable.map { (Products) in
               [productsSection(headers: "", items: Products)]
           }.bind(to: tableView.rx.items(dataSource: dataSource!)).disposed(by: disposeBag)
        } 

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchVm.getSearch(title: searchBar.text ?? "")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}
