//
//  CustomGlassView.swift
//  HomeTail
//
//  Created by taeuk on 2021/07/21.
//

import UIKit

class CustomGlassView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        print(rect)
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 40, y: 10))
        path.addLine(to: CGPoint(x: 40, y: rect.height - 40))
        path.addQuadCurve(to: CGPoint(x: 60, y: rect.height - 20), controlPoint: CGPoint(x: 40, y: rect.height - 20))
        path.addLine(to: CGPoint(x: rect.width - 60, y: rect.height - 20))
        path.addQuadCurve(to: CGPoint(x: rect.width - 40, y: rect.height - 40),
                          controlPoint: CGPoint(x: rect.width - 40, y: rect.height - 20))
        path.addLine(to: CGPoint(x: rect.width - 40, y: 10))

        path.lineCapStyle = .round
        
        let layer = CAShapeLayer()
        
        layer.path = path.cgPath
        layer.strokeColor = UIColor.blue.cgColor
        layer.lineWidth = 5
        layer.fillColor = UIColor.orange.cgColor
        self.layer.addSublayer(layer)
    }
    
}
