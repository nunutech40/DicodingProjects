//
//  GloblaExtension.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 2/10/21.
//

import UIKit

extension UIView {
    
    func customRounded(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func rounded() {
        self.layer.cornerRadius         = self.frame.size.width/2
        self.clipsToBounds              = true
        self.layer.borderColor          = UIColor.white.cgColor
        self.layer.borderWidth          = 0
    }
    
    func dropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
    }
    
}
