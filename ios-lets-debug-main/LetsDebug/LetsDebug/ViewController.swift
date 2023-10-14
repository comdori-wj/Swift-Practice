//
//  LetsDebug - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeTextColor()
    }
    
    func changeTextColor() {
        titleLabel.textColor = .brown
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func debugDescription() -> String {
        return "이 객체의 debugDescription은 \(super.debugDescription) 입니다."
      }
    


}

