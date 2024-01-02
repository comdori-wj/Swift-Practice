//
//  ViewAni - ViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var left: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        return view
    }()
    
    lazy var right: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        return view
    }()
    
    lazy var line: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityAttributedLabel = .init(string: "line")
        view.alpha = 0
        self.view.addSubview(view)
        return view
    }()
    
    lazy var spider: UIView = {
        let view = UIImageView(image: .init(named: "spider"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityAttributedLabel = .init(string: "spider")
        view.alpha = 0
        self.view.addSubview(view)
        return view
    }()
    
    @IBOutlet var spider2: UIImageView?
    
    lazy var safe = view.safeAreaLayoutGuide
    var top: NSLayoutConstraint?
    var lineCon: NSLayoutConstraint?
    var constraints: [NSLayoutConstraint] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        constraints.append(contentsOf: [
            line.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            line.widthAnchor.constraint(equalToConstant: 3),
            line.topAnchor.constraint(equalTo: safe.topAnchor),
            line.bottomAnchor.constraint(equalTo: spider.topAnchor),
            line.heightAnchor.constraint(greaterThanOrEqualToConstant: 10),
            
            spider.topAnchor.constraint(equalTo: safe.topAnchor),
            spider.widthAnchor.constraint(equalTo: safe.widthAnchor, multiplier: 0.2),
            spider.heightAnchor.constraint(equalTo: spider.widthAnchor),
            spider.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            
            left.widthAnchor.constraint(equalTo: safe.widthAnchor, multiplier: 0.25),
            left.heightAnchor.constraint(equalTo: safe.heightAnchor, multiplier: 0.5),
            left.topAnchor.constraint(equalTo: safe.topAnchor),
            left.trailingAnchor.constraint(equalTo: safe.centerXAnchor),
            
            right.widthAnchor.constraint(equalTo: safe.widthAnchor, multiplier: 0.25),
            right.heightAnchor.constraint(equalTo: safe.heightAnchor, multiplier: 0.5),
            right.topAnchor.constraint(equalTo: safe.topAnchor),
            right.leadingAnchor.constraint(equalTo: safe.centerXAnchor),
            
        ])
        
        top = spider.topAnchor.constraint(equalTo: safe.topAnchor, constant: 0)
        NSLayoutConstraint.activate(constraints + [top!])
        
        
        constraints.forEach {
            $0.priority = $0.firstAttribute == .width ? .required : .defaultHigh
        }
    }
    
    @IBAction func touchUpAnimationButton() {
        UIView.animate(withDuration: 0.5, animations: { [self] in
            spider.alpha = 1
            line.alpha = 1
            
            left.transform = CGAffineTransform(translationX: -50, y: 0)
            right.transform = CGAffineTransform(translationX: 50, y: 0)
            top?.constant = 200
            view.layoutIfNeeded()
        }, completion: { _ in
            UIView.animate(withDuration: 1, delay: 0.5) { [self] in
                spider.alpha = 0
                line.alpha = 0
                top?.constant = -0
                left.transform = CGAffineTransform(translationX: 0, y: 0)
                right.transform = CGAffineTransform(translationX: 0, y: 0)
                view.layoutIfNeeded()
            }
        })
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .repeat) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                self.spider2?.transform = CGAffineTransform(rotationAngle: 0.5)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.6) {
                self.spider2?.transform = CGAffineTransform(rotationAngle: -0.5)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 1) {
                self.spider2?.transform = .identity
            }
        }
    }
}

