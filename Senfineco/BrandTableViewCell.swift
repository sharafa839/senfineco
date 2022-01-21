//
//  BrandTableViewCell.swift
//  Senfineco
//
//  Created by sharaf on 23/10/2021.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
class BrandTableViewCell: UITableViewCell {

    @IBOutlet weak var brandName: UILabel!
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
    func confCell(brand:String)  {

        brandName.text = brand
    }

}
