//
//  HomeCVC.swift
//  Senfineco
//
//  Created by ahmed on 9/7/21.
//

import UIKit

class HomeCVC: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    func configCell(categoty:CategoryPayload){
        guard  let imge = categoty.image else {
            categoryImage.image = UIImage(named: "Logo-01 1")
            return
        }
        categoryImage.downlodImage(str:imge)
    }
}


