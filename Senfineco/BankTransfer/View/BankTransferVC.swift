//
//  BankTransferVC.swift
//  Senfineco
//
//  Created by ahmed on 9/19/21.
//

import UIKit
import RxCocoa
import RxSwift
import Gallery
class BankTransferVC: UIViewController {
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var bankNumber: UILabel!
    @IBOutlet weak var uploadImage: UIImageView!{
        didSet{
            uploadImage.floatView(raduis: 20)
            uploadImage.addActionn(vc: self, action: #selector(UploadPhoto1))
            uploadImage.isUserInteractionEnabled = true
            
        }
    }
    
    @IBOutlet weak var upload: UIButton!{
        didSet{
            upload.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var addTransfer: UIButton!{
        didSet{
            addTransfer.setTitle("Upload Bank Transfer", for: .normal)
            addTransfer.floatButton(raduis: 20)
        }
    }
    let addressVM = AddressVm()

    var orderID=Int()
    let bankVm = BankTransfer()
    let disposeBag = DisposeBag()
    var gallery = GalleryController()
    var arrayOfImage:[UIImage?] = []
    var pickedImg: UIImage?
    var imageCard = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(orderID)
getData()
        subscribeToResponse()
        subToImage()
subToButton()
        // Do any additional setup after loading the view.
    }
    func getData(){
        bankVm.GetData(vc: self)
    }
    func subscribeToResponse(){
        bankVm.subResponse.subscribe { [weak self](info) in
            guard let self = self else {return}

            self.bankName.text = info.element?.bankname
            self.bankNumber.text = info.element?.bankNumber
        }.disposed(by: disposeBag)

    }
    @IBAction func upload(_ sender: UIButton) {
        upload.secAnimation()
        print(555555)
        gallery = GalleryController()
            gallery.delegate = self
            Config.tabsToShow = [.cameraTab,.imageTab]
            Config.Camera.imageLimit = 1
            self.present(self.gallery,animated: true,completion: nil)
    }
    
    func subToImage(){
        bankVm.subResponseImage.subscribe {[weak self] (data) in
            guard let self = self else {return}

            self.imageCard = data.element?.name ?? ""
        }.disposed(by: disposeBag)

    }
    func subToButton(){
       
            addTransfer.rx.tap.subscribe { (_) in
                if self.imageCard.isEmpty {
                   // uploadImage.shakeF()
                }else{
                self.bankVm.uploadName(imageName: self.imageCard, orderID: self.orderID)
                }
            }.disposed(by: disposeBag)

        
    }
    @objc func UploadPhoto1 (){
        
    }
}
extension BankTransferVC : GalleryControllerDelegate {
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        if images.count > 0 {
            Image.resolve(images: images) { [weak self] (resolvedImage) in
               
                guard let self = self else {return}
                self.arrayOfImage = resolvedImage
                self.pickedImg = self.arrayOfImage.first as? UIImage
                self.bankVm.uploadImage(image: self.pickedImg ?? UIImage(),vc: self
                )
                controller.dismiss(animated: true, completion: nil)

    }
        }
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        self.dismiss(animated: true, completion: nil)

    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
}
