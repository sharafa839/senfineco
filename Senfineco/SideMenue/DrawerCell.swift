//
//  DrawerCell.swift
//  Ommah
//
//  Created by Mohamed on 9/16/20.
//  Copyright © 2020 Elsheikh. All rights reserved.
//

import UIKit

//MARK:- MenuCell
class TopSideMenuCell: UITableViewCell {
    @IBOutlet weak var personName:UILabel!
    @IBOutlet weak var ordersNumber: UILabel!
    @IBOutlet weak var imageV: UIView!{
        didSet{
           // imageV.floatView(raduis: 5)
          //  imageV.applyShadowWithCornerRadius(color: .borderColor, opacity: 0.5, radius: 15, edge: .All, shadowSpace: 5, cornerRadius: 5)
        }
    }
    
    @IBOutlet weak var wallet: UILabel!{
        didSet{
            wallet.text = "wallet".localizede

            wallet.floatView(raduis: 15)
            wallet.setRoundCorners(15)
        }
    }
    @IBOutlet weak var IMAGEPROFILE:UIImageView!{
        didSet{
           // IMAGEPROFILE.setRoundCorners(IMAGEPROFILE.frame.size.height / 2)
            //
            IMAGEPROFILE.image = UIImage(named: "suoq-oman-1")
            
        }
    }
    @IBOutlet weak var welcomLab: UILabel!
    
    func initCell(name:String,balance:String) {
        personName.initLabel(title: name, titleColor: .white, backgroundColor: .clear, roundCorner: 0, fontSize: 20,alignment: .center)
       welcomLab.initLabel(title: balance, titleColor: .white, backgroundColor: .clear, roundCorner: 0, fontSize: 15,alignment: .center)
        
    }
}


//MARK:- MenuCell
//class BottomSideMenuCell: UITableViewCell {
//    @IBOutlet weak var terms:UIButton!
//    @IBOutlet weak var privacy:UIButton!
//    @IBOutlet weak var edition:UILabel!
//    @IBOutlet weak var ownerEdition:UILabel!
//
//    func initCell() {
//        edition.initLabel(title: "All right reserved @ 2020", titleColor: .AppBlood, backgroundColor: .clear, roundValue: 0, index: .Regular, fontSize: 10,alignment: .center)
//        ownerEdition.initLabel(title: "Edition 1.0.0.1", titleColor: .AppDarkGray, backgroundColor: .clear, roundValue: 0, index: .Regular, fontSize: 10,alignment: .center)
//        terms.initButton(title: "Terms Conditions".localized(), titleColor: .AppOrange, backgroundColor: .clear, roundValue: 0, index: .Bold, fontSize: 10)
//        privacy.initButton(title: "Privacy Policy".localized(), titleColor: .AppOrange, backgroundColor: .clear, roundValue: 0, index: .Bold, fontSize: 10)
//    }
//}



class DrawerCell: UITableViewCell {
    @IBOutlet weak var titleName:UILabel!
    @IBOutlet weak var titleArrow:UIImageView!
    @IBOutlet weak var img: UIImageView!
    
    
    func initView(model:DrawerModel) {
    //titleName.initButton(title: model.titleName ?? "", titleColor: .darkGray, backgroundColor: .clear, roundValue: 0, index: .Medium, fontSize: 17)
        titleName.initLabel(title: model.titleName ?? "", titleColor: .darkGray, backgroundColor: .clear, roundCorner: 0, fontSize: 17)
        self.img.image = UIImage(named: model.titleImage!)
    }

    
    
}
