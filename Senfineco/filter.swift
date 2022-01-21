//
//  filter.swift
//  Senfineco
//
//  Created by sharaf on 07/10/2021.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
class filter: UIViewController{
    
    var Brand = String()
    var type = String()
    var model = String()
    @IBOutlet weak var titleLa: UILabel!{
        didSet{
            titleLa.text = "Filter".localizede
        }
    }
    @IBOutlet weak var kind: UILabel!{
        didSet{
            kind.text = "carModel".localizede
        }
    }
    @IBOutlet weak var Marka: UILabel!{
        didSet{
            Marka.text = "Marka".localizede
        }
    }
    @IBOutlet weak var recomended: UIButton!{
        didSet{
            recomended.setTitle("viewRecomed".localizede, for: .normal)
            recomended.floatButton(raduis: 20)
        }
    }

    @IBOutlet weak var chooseYourCar: UILabel!{
        didSet{
            chooseYourCar.text = "choose your car".localizede
        }
        
    }
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var makeTableView: UITableView!{
        didSet{
            makeTableView.floatView(raduis: 15)
            makeTableView.coloringboder(color: .borderColor)
            makeTableView.layer.borderWidth = 0.8
        }
    }
   @IBOutlet weak var typeTableView: UITableView!{
        didSet{
            typeTableView.floatView(raduis: 15)
            typeTableView.coloringboder(color: .borderColor)
            typeTableView.layer.borderWidth = 0.8
        }
    }
   @IBOutlet weak var modelTableView: UITableView!{
        didSet{
            modelTableView.floatView(raduis: 15)
            modelTableView.coloringboder(color: .borderColor)
            modelTableView.layer.borderWidth = 0.8
        }
    }
    @IBOutlet weak var carModel: UILabel!{
        didSet{
            carModel.text = "kkind".localizede
        }
    }
    @IBOutlet weak var typeButton: UIButton!{
        didSet{
            typeButton.setTitle("choosekkind".localizede, for: .normal)
            typeButton.floatButton(raduis: 15)
            typeButton.coloringboder(color: .borderColor)
            typeButton.setTitleColor(.black, for: .normal)
            typeButton.layer.borderWidth = 0.8
            typeButton.backgroundColor = .white
        }
        
    }
    
    @IBOutlet weak var makeButton: UIButton!{
        didSet{
            makeButton.setTitle("choosemarka".localizede, for: .normal)
            makeButton.floatButton(raduis: 15)
            makeButton.coloringboder(color: .borderColor)
            makeButton.setTitleColor(.black, for: .normal)
            makeButton.layer.borderWidth = 0.8
            makeButton.backgroundColor = .white
        }
        
    }
  
    @IBOutlet weak var ModelButton: UIButton!{
        didSet{
            ModelButton.setTitle("choosemodel".localizede, for: .normal)
            ModelButton.floatButton(raduis: 15)
            ModelButton.coloringboder(color: .borderColor)
            ModelButton.setTitleColor(.black, for: .normal)
            ModelButton.layer.borderWidth = 0.8
            ModelButton.backgroundColor = .white
        }
        
    }
    
    @IBOutlet weak var carType: UILabel!{
        didSet{
            carType.text = "carType".localizede
        }
    }
    @IBOutlet weak var carTtpe: UILabel!{
        didSet{
            carTtpe.text = "carTtpe".localizede
        }
    }
    func dismss(){
        backButton.rx.tap.subscribe { [weak self]_ in
            guard let self = self else {return}
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)

    }
    var dataSource1 : RxTableViewSectionedReloadDataSource<FilSection>!
    var dataSource2 : RxTableViewSectionedReloadDataSource<MakeTypeSection>?
    var dataSource3 : RxTableViewSectionedReloadDataSource<ModelSection>?
let filterr = Filter()
    let wish = Wish()
    var result = String()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
       // typeTableView.isHidden = true
      //  modelTableView.isHidden = true
        makeTableView.isHidden = true
        
        dataSource1 = RxTableViewSectionedReloadDataSource.init(configureCell: { (dataSourcse, tablView, indexPath,Item)   in
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = Item
            cell.textLabel?.font = UIFont(name: "System", size: 8)
            return cell
            
        })
       dataSource2 = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
            cell.textLabel?.text = Item
        cell.textLabel?.font = UIFont(name: "System", size: 12)


            return cell
            
        })
        dataSource3 = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in

            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = Item
            cell.textLabel?.font = UIFont(name: "System", size: 12)

            return cell
            
        })
        dismss()
        getData()
     subscribeToResponse()
selectTypeCell()
selectBrandCell()
        selectModelCell()
        subscribeToButton()
        makeButtonSubscribe()
        SubscribeToTypeResponse()
        typeButtonSubscribe()
       modelButtonSubscribe()
       
    }
    func getData(){
        filterr.fetchBrands(vc: self)
        
    }
 func makeButtonSubscribe(){
        makeButton.rx.tap.subscribe { [weak self]_ in
            guard let self = self else {return}
            self.makeButton.secAnimation()
            UIView.animate(withDuration: 0.5) {
                DispatchQueue.main.async {
                    self.makeTableView.isHidden =  !self.makeTableView.isHidden
                }
            }
        }.disposed(by: disposeBag)

    }
    func typeButtonSubscribe(){
           typeButton.rx.tap.subscribe { [weak self]_ in
               guard let self = self else {return}
               self.typeButton.secAnimation()
               UIView.animate(withDuration: 0.5) {
                   DispatchQueue.main.async {
                       self.typeTableView.isHidden =  !self.typeTableView.isHidden
                   }
               }
           }.disposed(by: disposeBag)

       }
    func modelButtonSubscribe(){
           ModelButton.rx.tap.subscribe { [weak self]_ in
               guard let self = self else {return}
               self.ModelButton.secAnimation()
               UIView.animate(withDuration: 0.5) {
                   DispatchQueue.main.async {
                       self.modelTableView.isHidden =  !self.modelTableView.isHidden
                   }
               }
           }.disposed(by: disposeBag)

       }
    func selectBrandCell(){
       Observable.zip(makeTableView.rx.itemSelected, makeTableView.rx.modelSelected(String.self)).bind{[weak self]selectedUndex,data in
            guard let self = self else {return}
        self.makeTableView.isHidden = true
        

       
        self.Brand = data
        self.makeButton.setTitle(self.Brand, for: .normal)
        self.ModelButton.setTitle("choosemodel".localizede, for: .normal)
        self.typeButton.setTitle("choosekkind".localizede, for: .normal)

        self.filterr.fetchMakeType(vc: self, title: data)
        
    }.disposed(by: disposeBag)
  
    }
    func selectTypeCell(){
        Observable.zip(typeTableView.rx.itemSelected, typeTableView.rx.modelSelected(String.self)).bind{[weak self]selectedUndex,data in
             guard let self = self else {return}
         self.typeTableView.isHidden = true

         self.type = data
         self.typeButton.setTitle(self.type, for: .normal)
            self.filterr.fetchModelType(vc: self, brand: self.Brand, type: self.type)
         
     }.disposed(by: disposeBag)
        
    }
    func selectModelCell(){
        Observable.zip(modelTableView.rx.itemSelected, modelTableView.rx.modelSelected(String.self)).bind{[weak self]selectedUndex,data in
             guard let self = self else {return}
         self.modelTableView.isHidden = true

         self.model = data
         self.ModelButton.setTitle(self.model, for: .normal)
         
         
     }.disposed(by: disposeBag)
        
    }
    func SubscribeToTypeResponse(){
        filterr.subscribeToMakeResponse.map { makeType in
            [MakeTypeSection(header: "", items: makeType.type ?? [String].init())]
        }.bind(to: typeTableView.rx.items(dataSource: dataSource2!)).disposed(by: disposeBag)
        filterr.subscribeToModelRespons.map { makeType in
            [ModelSection(header: "", items: makeType.model ?? [String].init())]
        }.bind(to: modelTableView.rx.items(dataSource: dataSource3!)).disposed(by: disposeBag)
        
    }
    func subscribeToButton() {
        recomended.rx.tap.subscribe { [weak self](_) in
            guard let self = self else {return}
            self.recomended.secAnimation()
           
            guard !self.Brand.isEmpty else{
                self.makeTableView.shakeF()
                return}
            guard !self.type.isEmpty else{
                    self.typeTableView.shakeF()
                    return}
            guard !self.model.isEmpty else{
                self.modelTableView.shakeF()
                return}
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "result") as! RecomendedVC
            vc.type = self.type
            vc.make = self.Brand
            vc.model = self.model
            self.present(vc, animated: true, completion: nil)
            
        }.disposed(by: disposeBag)


    }
    func subscribeToResponse(){
        print(40000000000)
        filterr.subscribeToRespons.map { SectionMode  in
            [FilSection(header: "", items: SectionMode.brands)]
            
        }.bind(to: makeTableView.rx.items(dataSource: dataSource1)).disposed(by: disposeBag)
       

    }

    // MARK: - Table view data source

  /*  override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
*/
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
