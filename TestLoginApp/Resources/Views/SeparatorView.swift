//
//  SeparatorView.swift
//  TestLoginApp
//
//  Created by Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

final class SeparatorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        heightAnchor.constraint(equalToConstant: C.separatorHeight).isActive = true
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .veryLightPink
    }

}

// MARK: - Constants
private enum C {
    static let separatorHeight: CGFloat = 1
}
