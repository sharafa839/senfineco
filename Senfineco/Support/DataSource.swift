//
//  DataSource.swift
//  Senfineco
//
//  Created by ahmed on 9/7/21.
//

import Foundation
import UIKit
class DataSource: NSObject,UITableViewDelegate,UIScrollViewDelegate{
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
}
