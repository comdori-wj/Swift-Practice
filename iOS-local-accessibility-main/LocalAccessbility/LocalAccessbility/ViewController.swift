//
//  LocalAccessbility - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    private func addBottomLabel() {
        
        let bottomLabel = UILabel()
        bottomLabel.frame = CGRect(x: 20, y: view.bounds.size.height - 150, width: view.bounds.size.width - 40, height: 50)
        
        bottomLabel.text = "Touch the button below!".localized()
        
        bottomLabel.font = UIFont.systemFont(ofSize: 20)
        
        bottomLabel.textColor = .red
        
        bottomLabel.textAlignment = .center
        
        view.addSubview(bottomLabel)
    }
    
    private func addButton() {
        // Do any additional setup after loading the view.
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 20, y: view.bounds.size.height - 80, width: view.bounds.size.width - 40, height: 50)
        
        button.setTitle("Touch Me!".localized(), for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        button.setTitleColor(.blue, for: .normal)
        
        view.addSubview(button)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomLabel()
        addButton()
        
        dateTimeLabel.text = date()
        currency()
        
    }
    
    func date() -> String{
        let date = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium)
        return date
    }
    
    func numbers() -> String {
        let quantity = NumberFormatter.localizedString(from: 3941036.60, number: .currency)
        return quantity
    }
    
    func currency() {
        let locale = Locale.current
        let price = 3000.34 as NSNumber
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.currencyCode = locale.currencyCode
        formatter.locale = locale
        
        numberLabel.text = formatter.string(from: price)
    }
}

