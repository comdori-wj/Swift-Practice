//
//  MyView.swift
//  ViewDrawingCycle
//
//  Created by Wonji Ha on 12/18/23.
//

import UIKit

class MyView: UIView {
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect) // 2. 두번째 뷰를 그려준다.
        
    }
    
    override func setNeedsDisplay() {
        super.setNeedsDisplay() // 1. 첫번째 시스템한테 뷰 그릴꺼야~ 라고 알려준다.
    }
    

}
