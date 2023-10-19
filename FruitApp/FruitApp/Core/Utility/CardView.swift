//
//  CardView.swift
//  FruitApp
//
//  Created by Pawan Sharma on 23/08/23.
//

import Foundation
import UIKit

final class CardView: UIView {

//    var radius: CGFloat = 1
    @IBInspectable internal var radius:CGFloat = 1
    @IBInspectable internal var shadowOpticity:CGFloat = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = radius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1);
        layer.shadowOpacity = 0.5
        layer.shadowPath = shadowPath.cgPath
    }

}
