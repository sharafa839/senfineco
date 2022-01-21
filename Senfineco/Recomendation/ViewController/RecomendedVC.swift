//
//  RecomendedVC.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import UIKit
import RxSwift
import RxCocoa
class RecomendedVC: UIViewController {

    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var resultLa: UILabel!{
        didSet{
            resultLa.text = "result".localizede
        }
    }
    @IBOutlet weak var content: UILabel!{
        didSet{
            content.text = ""
        }
    }
    let results = Recomend()

    var make = String()
    var type = String()
    var model = String()
    let dispseBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
getResult()
        subscribeToResponse()
        // Do any additional setup after loading the view.
    }
    func getResult (){
        results.getRecomend(make: make, model: model, type: type, vc: self)
    }
    func subscribeToResponse(){
        results.subscribeRecomed.subscribe { [weak self]resultRecomended in
            guard let self = self else {return}
            guard let resutlt = resultRecomended.element?.first?.resutls else {return}
            self.content.text = resutlt
        }.disposed(by: dispseBag)

    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
