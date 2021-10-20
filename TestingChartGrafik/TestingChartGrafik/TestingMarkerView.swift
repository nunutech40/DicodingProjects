//
//  TestingMarkerView.swift
//  TestingChartGrafik
//
//  Created by mac on 15/9/21.
//

import UIKit

class TestingMarkerView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeNib()
    }
    
    func initializeNib() {
        
        let nib: UIView = UINib.init(nibName: "TestingMarkerView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        self.addSubview(nib)
        nib.frame = self.bounds
       
    }
    
}
