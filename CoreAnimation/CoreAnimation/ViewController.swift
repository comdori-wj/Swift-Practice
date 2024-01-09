//
//  ViewController.swift
//  CoreAnimation
//
//  Created by Wonji Ha on 1/9/24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var plusButton: PlusButton = {
        let button = PlusButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapBtn), for: .touchUpInside)
        return button
    }()
    
    lazy var isRotated = false
    
    @objc
    func tapBtn(_ sender: PlusButton) {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        if isRotated == false {
            isRotated = true
            rotation.fromValue = 0 //시작 점
            rotation.toValue = Double.pi / 4.5 // 끝점
            rotation.duration = 0.25 // 도는데 걸리는 시간
            rotation.fillMode = .both // 애니메이션이 끝나고 나서 유지할지 말지?
            rotation.isRemovedOnCompletion = false
            plusButton.layer.add(rotation, forKey: "transform.rotation")
        } else {
            isRotated = false
            rotation.fromValue = Double.pi / 4.5
            rotation.toValue = 0
            rotation.duration = 0.25
            rotation.fillMode = .backwards
            rotation.isRemovedOnCompletion = false
            plusButton.layer.add(rotation, forKey: "transform.rotation")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setting()
    }
    
    func setting() {
        view.addSubview(plusButton)
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 268),
            plusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  40),
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            plusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -268)
        ])
    }
}

final class PlusButton: UIButton {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(20.0)
        context?.addEllipse(in: CGRect(x: rect.origin.x + 10, y: rect.origin.y + 10, width: rect.width - 20, height: rect.height - 20))
        context?.move(to: CGPoint(x: rect.width / 2, y: 50))
        context?.addLine(to: CGPoint(x: rect.width / 2, y: rect.height - 50))
        context?.move(to: CGPoint(x: 50, y: rect.height / 2))
        context?.addLine(to: CGPoint(x: rect.width - 50, y: rect.height / 2))
        context?.setLineCap(.round)
        context?.setStrokeColor(UIColor.systemGreen.cgColor)
        context?.strokePath()
    }
}
