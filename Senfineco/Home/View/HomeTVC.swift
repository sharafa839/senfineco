//
//  HomeTVC.swift
//  Senfineco
//
//  Created by ahmed on 9/7/21.
//

import UIKit
import RxSwift
import RxCocoa
class HomeTVC: UITableViewCell {

    @IBOutlet weak var customView: UIView!{
        didSet{
            customView.floatView(raduis: 15)
            customView.coloringboder(color: .borderColor)
            customView.layer.borderWidth = 0.5
        }
    }
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var seeDetailes: UILabel!{
        didSet{
            seeDetailes.text = "see detailes".localizede
        }
    }
    @IBOutlet weak var addProductButton: UIButton!{
        didSet{
            addProductButton.setTitle("add Product".localizede, for: .normal)
            addProductButton.setTitleColor(.white, for: .normal)
            addProductButton.floatButton(raduis: 15)
        }
    }
    var bag = DisposeBag()
          override func prepareForReuse() {
              super.prepareForReuse()
              bag = DisposeBag()
          }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell (product:ProductPayload){
        guard  let image = product.image else {
            itemImage.image = UIImage(named: "Logo-01 1")
            return
        }
        itemImage.downlodImage(str: image)
        if LocalizationManager.shared.getLanguage() == .English {
        productName.text = product.title
        }else{
            productName.text = product.titleAr
        }
        productPrice.text = "\(product.price ?? 0.0)"
    }
}
