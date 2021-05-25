//
//  testVC.swift
//  Square Frame
//
//  Created by Komal Gupta on 20/11/19.
//

import UIKit

class testVC: UIViewController {

    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var hght: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hight = ((testButton.bounds.height)/testButton.bounds.width)*(UIScreen.main.bounds.width)
            self.hght.constant = hight
        print(hight)
        // Do any additional setup after loading the view.
    }
    

   

}
