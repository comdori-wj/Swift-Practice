//
//  ViewController.swift
//  Gesture
//
//  Created by Wonji Ha on 2023/11/15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var xy좌표: UILabel!
    
    @IBOutlet weak var swipeGestureRecongnizer: UISwipeGestureRecognizer!
    @IBOutlet weak var panGestureRecognizer: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        
        leftSwipeGesture.direction = .left
        rightSwipeGesture.direction = .right
        upSwipeGesture.direction = .up
        downSwipeGesture.direction = .down
        
        view.addGestureRecognizer(rightSwipeGesture)
        view.addGestureRecognizer(leftSwipeGesture)
        view.addGestureRecognizer(upSwipeGesture)
        view.addGestureRecognizer(downSwipeGesture)
        
    }
    
    @IBAction func swipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer) {
        
        if gestureRecognizer.state == .ended {
           
            print("ended")
        }
        
        if gestureRecognizer.direction == .left {
            
            directionLabel.text = "왼쪽"
            print("left")
        }
        
        if gestureRecognizer.direction == .right {
            
            directionLabel.text = "오른쪽"
            print("right")
        }
        
        if gestureRecognizer.direction == .up {
            directionLabel.text = "위"
            print("up")
        }
        
        if gestureRecognizer.direction == .down {
            directionLabel.text = "아래"
            print("down")
        }
    }
    
    @IBAction func didPan(_ recognizer: UIPanGestureRecognizer ) {
        let x = recognizer.location(in: self.view).x
        let y = recognizer.location(in: self.view).y
        xy좌표.text = "x:\(x), y:\(y)"
    }
    
}
