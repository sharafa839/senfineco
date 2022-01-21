//
//  MyOrderTVC.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import UIKit

class MyOrderTVC: UITableViewCell {

    @IBOutlet weak var status: UILabel!{
        didSet{
            status.text = "status".localizede
        }
    }
    @IBOutlet weak var customView: UIView!{
        didSet{
            customView.floatView(raduis: 20)
            customView.applyShadowWithCornerRadius(color: .borderColor, opacity: 0.3, radius: 15, edge: .All, shadowSpace: 5, cornerRadius: 15)
        }
    }
    @IBOutlet weak var orderAtSncfico: UILabel!{
        didSet{
            orderAtSncfico.text = "order at senfinceo".localizede
        }
    }
    @IBOutlet weak var orderStatus: UILabel!{
        didSet{
            orderStatus.text = "status".localizede
        }
    }
    @IBOutlet weak var items: UILabel!{
        didSet{
            items.text = "items".localizede
        }
    }
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var numberOfItems: UILabel!
    @IBOutlet weak var price: UILabel!{
        didSet{
            price.text = "price".localizede
        }
    }
    @IBOutlet weak var amountOfMoney: UILabel!
    @IBOutlet weak var trackButton: UIButton!{
        didSet{
            trackButton.setTitle("trackOrder".localizede, for: .normal)
            trackButton.floatButton(raduis: 20)
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
    func confCell(order:OrdersPayload){
        numberOfItems.text = "\(order.items?.count ?? 0)" + "items".localizede
        amountOfMoney.text = "\(order.totalCost ?? "0")"+"   OMR".localizede
        orderId.text = ""
        if order.status == "pending"{
            status.text = "pending".localizede
        }
            else{
                status.text = order.status
            }
    }

}
