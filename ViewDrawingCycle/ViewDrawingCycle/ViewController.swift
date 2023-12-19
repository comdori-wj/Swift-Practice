//
//  ViewController.swift
//  ViewDrawingCycle
//
//  Created by Wonji Ha on 12/18/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myView: MyView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func check(_ sender: Any) {
        self.myView.setNeedsDisplay()
//        self.myView.isHidden = true
    }
    
    @IBAction func viewNoHidden(_ sender: Any) {
//        myView.isHidden = false
        
    }
        
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews() // 1. viewWill 걸림
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews() // 2. viewDid 걸림
    }
}
