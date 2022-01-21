//
//  ProductVC.swift
//  Senfineco
//
//  Created by ahmed on 9/8/21.
//

import UIKit
import RxSwift
import RxCocoa
class ProductVC: UITableViewController {
    var product:ProductPayload?
    @IBOutlet weak var customView: UIView!{
        didSet{
            customView.floatView(raduis: 20)
        }
    }
    @IBOutlet weak var fromViewToView: NSLayoutConstraint!
    @IBOutlet weak var toop: NSLayoutConstraint!
    @IBOutlet weak var tooop: NSLayoutConstraint!
    @IBOutlet weak var topConstrains: NSLayoutConstraint!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var addProduct: UIButton!{
        didSet{
            addProduct.setTitle("addToCart".localizede, for: .normal)
        }
    }
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pricePerUnitLa: UILabel!{
        didSet{
            pricePerUnitLa.text =  "pricePerUnit".localizede
        }
    }
    @IBOutlet weak var ratings: UILabel!
    @IBOutlet weak var desciptionView: UIView!{
        didSet{
            desciptionView.floatView(raduis: 20)
            desciptionView.coloringboder(color: .borderColor)
            desciptionView.layer.borderWidth = 1
            desciptionView.addActionn(vc: self, action: #selector(showdescriptionLabel))
        }
    }
    @IBOutlet weak var desLa: UILabel!{
        didSet{
            desLa.text = "description".localizede
        }
    }
    @IBOutlet weak var howToUseLa: UILabel!{
        didSet{
            howToUseLa.text = "howToUse".localizede
        }
    }
    @IBOutlet weak var expandDesButton: UIButton!{
        didSet{
            expandDesButton.addActionn(vc: self, action: #selector(showdescriptionLabel))
        }
    }
    @IBOutlet weak var expandHowToUseButton: UIButton!{
        didSet{
            expandHowToUseButton.addActionn(vc: self, action: #selector(showUsingLabel))
        }
    }
    @IBOutlet weak var howToUseView: UIView!{
        didSet{
            howToUseView.floatView(raduis: 20)
            howToUseView.addActionn(vc: self, action: #selector(showUsingLabel))
            howToUseView.coloringboder(color: .borderColor)
            howToUseView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var howToUseDes: UILabel!{
        didSet{
            howToUseDes.floatView(raduis: 50)
            howToUseDes.layer.cornerRadius = 10
            howToUseDes.clipsToBounds = true
            howToUseDes.text = "d,a;ld,m;sam,dk;lmfkldsnmbvklmklbmglkfmbklgfmklbmgfklbmgklbmklmgbfkl;mgkl;bmgf;m"
        }
    }
    @IBOutlet weak var descriptionLa: UILabel!{
        didSet{
            descriptionLa.floatView(raduis: 50)
            descriptionLa.layer.cornerRadius = 10
            descriptionLa.clipsToBounds = true
            descriptionLa.text = "d,a;ld,m;sam,dk;lmfkldsnmbvklmklbmglkfmbklgfmklbmgfklbmgklbmklmgbfkl;mgkl;bmgf;m"
        }
    }
    @IBOutlet weak var numberOfUnitsView: UIView!{
        didSet{
            numberOfUnitsView.floatView(raduis: 20)
            numberOfUnitsView.coloringboder(color: .black)
            numberOfUnitsView.layer.borderWidth = 0.5
        }
    }
    @IBOutlet weak var numberofProduct: UILabel!
    @IBOutlet weak var IncreaseButton: UIButton!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var numberOfUnits: UILabel!{
        didSet{
            numberOfUnits.text = "numberOfUnits".localizede
        }
    }
    @IBOutlet weak var addToCartButton: UIView!{
        didSet{
            addToCartButton.floatView(raduis: 20)
            addToCartButton.addActionn(vc: self, action: #selector(addToCart))
        }
    }
    @IBOutlet weak var _1: UIButton!{
        didSet{
            _1.tintColor = .gray
        }
    }
    @IBOutlet weak var _2: UIButton!{
        didSet{
            _2.tintColor = .gray
        }
    }
    @IBOutlet weak var _3: UIButton!{
        didSet{
            _3.tintColor = .gray
        }
    }
    @IBOutlet weak var _4: UIButton!{
        didSet{
            _4.tintColor = .gray
        }
    }
    @IBOutlet weak var _5: UIButton!{
        didSet{
            _5.tintColor = .gray
        }
    }
    @IBOutlet weak var watchOnYoutubeButton: UIButton!{
        didSet{
            watchOnYoutubeButton.setTitle("watchOnYoutube".localizede, for: .normal)
            watchOnYoutubeButton.floatButton(raduis: 15)
        }
    }
    var numberOfUnit = 1
    var isDesHide = false
    var isUseHide = false
    var youtubeLink = String()
let productVm = ProductVM()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        ProductImage.downlodImage(str: product?.image ?? "")
        priceLabel.text = "\(product?.price ?? 0.0)" + "   OMR".localizede
        youtubeLink = product?.youtubeLink ?? ""
  //      rate(rating: product?.rate ?? 000)
        numberofProduct.text = "\(numberOfUnit)"
        if LocalizationManager.shared.getLanguage() == .English{
        productName.text = product?.title
       descriptionLa.text = product?.descriptionEn
            howToUseDes.text = product?.howToUseEn

        }else{
            productName.text = product?.titleAr
            descriptionLa.text = product?.descriptionAr
            howToUseDes.text = product?.howToUseAr
        }
hideDescriptionLa()
        hideUseLa()
        if HelperK.checkUserToken() == true{

        subscribeToAddToCartButton()
        subscribeToResponse()
        subscribeToFavoriteButton()
            OpenYoutubeLink()
        }else{
            HelperK.showError(title: "you have to login to continue".localizede, subtitle: "")

        }
    }
    func OpenYoutubeLink(){
        print(youtubeLink)
        watchOnYoutubeButton.rx.tap.subscribe {[weak self] _ in
            guard let self = self else {return}
            self.watchOnYoutubeButton.secAnimation()
            HelperK.openYoutube(youtube: self.youtubeLink)
        }.disposed(by: disposeBag)

    }
    @objc func addToCart(){
        if HelperK.checkUserToken() == true{
        productVm.AddToCart(productId: product?.id ?? 0, quantity: numberOfUnit, customer: true, vc: self)
        }else{
            HelperK.showError(title: "you have to login to continue".localizede, subtitle: "")

        }
    }
    @IBAction func increase(_ sender: UIButton) {
        numberOfUnit += 1
        numberofProduct.text = "\(numberOfUnit)"

    }
    @IBAction func decrease(_ sender: UIButton) {
        if numberOfUnit == 1 {
            
        }else{
            numberOfUnit -= 1
            numberofProduct.text = "\(numberOfUnit)"
        }}
    
    func subscribeToAddToCartButton(){
        addProduct.rx.tap.throttle(RxTimeInterval.microseconds(5000),scheduler: MainScheduler.instance)
            .subscribe {[weak self] (_) in
            guard let self = self else {return}
                self.addToCartButton.secAnimation()
                self.productVm.AddToCart(productId: self.product?.id ?? 0, quantity: self.numberOfUnit ?? 0, customer: true, vc: self)
            }.disposed(by: disposeBag)
    }
    func subscribeToResponse(){
        productVm.subscripeToCartResponse.subscribe { (data) in
            if data.element?.code == 200 {
                HelperK.showSuccess(title: data.element?.message ?? "addToCartSucess".localizede, subtitle: "")
            }else{
                HelperK.showError(title: data.element?.message ?? "product already exists in the cart".localizede, subtitle: "")
            }
        }.disposed(by: disposeBag)

    }
    // MARK: - Table view data source

    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

  
}

extension ProductVC {
    @objc func showdescriptionLabel(){
        if isDesHide == false {
            descriptionLa.backgroundColor = .borderColor
            animatingDescriptionLa()
        }else{
            hideDescriptionLa()
        }
    }
    @objc func showUsingLabel(){
        if isUseHide == false {
            howToUseDes.backgroundColor = .borderColor
            animatingUseLa()
            
        }else{
            hideUseLa()
            
        }
    }
    func hideDescriptionLa(){
        isDesHide = false
        desciptionView.backgroundColor = .white
        expandDesButton.setImage(UIImage(named: "plus-circle"), for: .normal)
        
        descriptionLa.isHidden = true
        let scaleDownTransorm = CGAffineTransform(scaleX: 0, y: 0)
        descriptionLa.transform = scaleDownTransorm
        topConstrains.constant = -130

    }
    func hideUseLa(){
        isUseHide = false
        howToUseView.backgroundColor = .white
        
        expandHowToUseButton.setImage(UIImage(named: "plus-circle"), for: .normal)
        
        howToUseDes.isHidden = true
        let scaleDownTransorm = CGAffineTransform(scaleX: 0, y: 0)
        howToUseDes.transform = scaleDownTransorm
       // toop.constant = 20
    }
    func animatingDescriptionLa(){
        isDesHide = true
        descriptionLa.isHidden = false
        expandDesButton.setImage(UIImage(named: "minus-circle"), for: .normal)
        // confirmPassTF.isHidden = false
        topConstrains.constant = 0
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.descriptionLa.transform = .identity
                self.view.layoutIfNeeded()
            }
            
        }
    }
    func subscribeToFavoriteButton(){
        favButton.rx.tap.throttle(RxTimeInterval.microseconds(5000), scheduler: MainScheduler.instance)
            .subscribe {[weak self] (_) in
                guard let self = self else {return}

                self.productVm.MakeFav(id: self.product?.id ?? 0, vc: self)
                self.favButton.imageView?.tintColor = .red
            }.disposed(by: disposeBag)

    }
    func animatingUseLa(){
        isUseHide = true
        expandHowToUseButton.setImage(UIImage(named: "minus-circle"), for: .normal)
        
        howToUseDes.isHidden = false
        // confirmPassTF.isHidden = false
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.howToUseDes.transform = .identity
            }
            
        }
    }
}

extension ProductVC {
    func rate(rating:Int){
        switch rating {
        case 0:
            print("")
            ratings.text = "havenorating".localizede
            
        case 1:
            _1.tintColor = .systemYellow
            ratings.text = "1StarRating".localizede
        case 2:
            _1.tintColor = .systemYellow
            _2.tintColor = .systemYellow
            ratings.text = "2StarRating".localizede
            
        case 3 :
            _1.tintColor = .systemYellow
            _2.tintColor = .systemYellow
            _3.tintColor = .systemYellow
            ratings.text = "3StarRating".localizede
            
        case 4 :
            _1.tintColor = .systemYellow
            _2.tintColor = .systemYellow
            _3.tintColor = .systemYellow
            _4.tintColor = .systemYellow
            ratings.text = "4StarRating".localizede
            
        case 5 :
            _1.tintColor = .systemYellow
            _2.tintColor = .systemYellow
            _3.tintColor = .systemYellow
            _4.tintColor = .systemYellow
            _5.tintColor = .systemYellow
            ratings.text = "5StarRating".localizede
            
        default:
            print("")
        }
    }
}
