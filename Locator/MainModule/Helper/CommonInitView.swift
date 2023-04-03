//
//  CommonInitView.swift
//  Locator
//
//  Created by Илья Шаповалов on 03.04.2023.
//

import UIKit

class CommonInitView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    func commonInit() { }
}
