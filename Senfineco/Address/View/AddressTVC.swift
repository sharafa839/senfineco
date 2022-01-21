//
//  AddressTVC.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import UIKit
import RxCocoa
import RxSwift
class AddressTVC: UITableViewCell {

    @IBOutlet weak var addressP: UILabel!
    @IBOutlet weak var editAddress: UIButton!
    @IBOutlet weak var deleteAddress: UIButton!
    
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
    func confCell(address:AddressModelPayload){
        addressP.text = address.address?.city
    }
}
