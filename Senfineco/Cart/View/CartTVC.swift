//
//  CartTVC.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import UIKit
import RxCocoa
import RxSwift
class CartTVC: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var summtion: UIButton!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var customView: UIView!{
        didSet{
            customView.floatView(raduis: 20)
            customView.coloringboder(color: .borderColor)
            customView.layer.borderWidth = 1
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
    func getCart(cart:Products){
        productImage.downlodImage(str: cart.image ?? "")
        if LocalizationManager.shared.getLanguage() == .English {
        productName.text = cart.name
        } else{
            productName.text = cart.nameAr
        }
        productPrice.text = "\(cart.price ?? 000)"
        quantity.text = "\(cart.quantity ?? 000)"
    }

}
