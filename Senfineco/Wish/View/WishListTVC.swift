//
//  WishListTVC.swift
//  Senfineco
//
//  Created by ahmed on 9/12/21.
//

import UIKit
import RxCocoa
import RxSwift
class WishListTVC: UITableViewCell {

    @IBOutlet weak var customView: UIView!{
        didSet{
            //customView.floatView(raduis: 15)
            customView.applyShadowWithCornerRadius(color: .borderColor, opacity: 0.5, radius: 8, edge: .All, shadowSpace: 1, cornerRadius: 8)
        }
    }
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var addToCart: UIButton!{
        didSet{
            addToCart.setTitle("addToCart".localizede, for: .normal)
            addToCart.floatButton(raduis: 15)
        }
    }
    @IBOutlet weak var delete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var bag = DisposeBag()
          override func prepareForReuse() {
              super.prepareForReuse()
              bag = DisposeBag()
          }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func confCell(wish:WishListPayload){
        productPrice.text = "\(wish.price ?? "0")" + "   OMR".localizede
        productImage.downlodImage(str: wish.image ?? "")
        if LocalizationManager.shared.getLanguage() == .Arabic {
            productName.text = wish.nameAr
        }else{
        productName.text = wish.name
        }
    }
}
