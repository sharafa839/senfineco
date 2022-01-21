//
//  WholeSellerTVC.swift
//  Senfineco
//
//  Created by ahmed on 9/16/21.
//

import UIKit

class WholeSellerTVC: UITableViewCell {
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
            seeDetailes.text = "see detailes"
        }
    }
    @IBOutlet weak var addProductButton: UIButton!{
        didSet{
            addProductButton.setTitle("add Product", for: .normal)
            addProductButton.setTitleColor(.white, for: .normal)
            addProductButton.floatButton(raduis: 15)
        }
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
        itemImage.downlodImage(str: product.image ?? "")
        productName.text = product.title
    }
}
