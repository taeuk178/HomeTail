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
        layer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = 0
//        animation.toValue = layer.position.y - 10
        animation.toValue = 1
        animation.duration = 2
        
        animation.isRemovedOnCompletion = false
        
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "loc")
        
        
        let gradientLayer = CAGradientLayer()
        let startLocations = [0, 0]
        let endLocations = [0.7, 0.7]

        gradientLayer.colors = [UIColor.appMainColor(.subSkyBlueColor).cgColor, UIColor.white.cgColor]
        gradientLayer.frame = path.bounds
        gradientLayer.frame.size.height = path.bounds.size.height / 3 + 10
        gradientLayer.frame.size.width = path.bounds.size.width - 4
        gradientLayer.locations = startLocations as [NSNumber]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        
        let shapeMask = CAShapeLayer()
        shapeMask.path = path.cgPath
        gradientLayer.mask = shapeMask.mask

        gradientLayer.anchorPoint = CGPoint(x: 0.48, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)

        let anim = CABasicAnimation(keyPath: "locations")
        anim.fromValue = startLocations
        anim.toValue = endLocations
        anim.duration = 1.0

//        anim.repeatDuration = .infinity
        gradientLayer.add(anim, forKey: "loc")
        gradientLayer.locations = endLocations as [NSNumber]
        
        //
        
        let blueGradientLayer = CAGradientLayer()
        let blueStartLocations = [-2, -2]
        let blueEndLocations = [0.9, 0.9]

        blueGradientLayer.colors = [UIColor.appMainColor(.subYelloColor).cgColor, UIColor.white.cgColor]
        blueGradientLayer.frame = path.bounds
        blueGradientLayer.frame.size.height = path.bounds.size.height / 3
        blueGradientLayer.frame.size.width = path.bounds.size.width - 4
        blueGradientLayer.locations = blueStartLocations as [NSNumber]
        blueGradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        blueGradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)

        let blueShapeMask = CAShapeLayer()
        blueShapeMask.path = path.cgPath
        blueGradientLayer.mask = blueShapeMask.mask
        
        blueGradientLayer.anchorPoint = CGPoint(x: 0.48, y: -0.55)
        layer.insertSublayer(blueGradientLayer, at: 0)
        
        let blueAnim = CABasicAnimation(keyPath: "locations")
        blueAnim.fromValue = blueStartLocations
        blueAnim.toValue = blueEndLocations
        blueAnim.duration = 3

//        anim.repeatDuration = .infinity
        blueGradientLayer.add(blueAnim, forKey: "location")
        blueGradientLayer.locations = blueEndLocations as [NSNumber]
        
        //green
        
        let greenGradientLayer = CAGradientLayer()
        let greenStartLocations = [-2, -2]
        let greenEndLocations = [0.9, 0.9]

        greenGradientLayer.colors = [UIColor.appMainColor(.subOrangeColor).cgColor, UIColor.white.cgColor]
        greenGradientLayer.frame = path.bounds
        greenGradientLayer.frame.size.height = path.bounds.size.height / 3
        greenGradientLayer.frame.size.width = path.bounds.size.width - 4
        
        greenGradientLayer.locations = greenStartLocations as [NSNumber]
        greenGradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        greenGradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)

        let greenShapeMask = CAShapeLayer()
        greenShapeMask.path = path.cgPath
        greenGradientLayer.mask = greenShapeMask.mask
        
        greenGradientLayer.anchorPoint = CGPoint(x: 0.48, y: -1.45)
        greenGradientLayer.cornerRadius = 15
        greenGradientLayer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.insertSublayer(greenGradientLayer, at: 0)
        
        let greenAnim = CABasicAnimation(keyPath: "locations")
        greenAnim.fromValue = greenStartLocations
        greenAnim.toValue = greenEndLocations
        greenAnim.duration = 3

//        anim.repeatDuration = .infinity
        greenGradientLayer.add(blueAnim, forKey: "location")
        greenGradientLayer.locations = greenEndLocations as [NSNumber]
        
    }
    
}
