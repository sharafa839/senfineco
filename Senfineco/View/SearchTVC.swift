//
//  SearchTVC.swift
//  Senfineco
//
//  Created by Ahmed on 04/10/2021.
//

import UIKit

class SearchTVC: UITableViewCell {

    @IBOutlet weak var customView: UIView!{
        didSet{
            customView.floatView(raduis: 15)
        }
    }
    @IBOutlet weak var addToCart: UIButton!{
        didSet{
            addToCart.floatButton(raduis: 10)
            addToCart.setTitle("addToCart".localizede, for: .normal)
        }
    }
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(product:ProductPayload){
       
        productPrice.text = "\(product.price ?? 0.0)"
        if LocalizationManager.shared.getLanguage() == .Arabic {
            productName.text = product.titleAr
        }else{
            productName.text = product.title

        }
        guard  let image = product.image else {
            return
        }
        itemImage.downlodImage(str: image)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
