//
//  EmptyVC.swift
//  Foody
//
//  Created by halil yılmaz on 19.07.2023.
//

import UIKit

class EmptyVC: UIViewController {
    
    var lbl: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
