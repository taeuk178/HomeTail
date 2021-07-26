//
//  CustomGlassView.swift
//  HomeTail
//
//  Created by taeuk on 2021/07/21.
//

import UIKit

class CustomGlassView: UIView {
    
    // MARK: - Properties
    
    private let path = UIBezierPath()
    
    // GradientLayer
    private let alcoholGradientLayer = CAGradientLayer()
    private let baseGradientLayer = CAGradientLayer()
    private let tasteGradientLayer = CAGradientLayer()
    
    // Top Location
    private let topStartLocations = [-2, -2]
    private let topEndLocations = [0.7, 0.7]
    
    // Middle, Bottom Location
    private let startLocations = [-2, -2]
    private let endLocations = [0.9, 0.9]
    
    private let duration = 1.0
    
    // MARK: - LifeCycle
    
    override func draw(_ rect: CGRect) {
        
        print(rect)
        
        // Drawing BezierPath
        drawPath(rect: rect)
        drawAllLayer()
        
    }
    
    // MARK: - BezierPath
    
    private func drawPath(rect: CGRect) {
        
        path.move(to: CGPoint(x: 40, y: 10))
        path.addLine(to: CGPoint(x: 40, y: rect.height - 40))
        path.addQuadCurve(to: CGPoint(x: 60, y: rect.height - 20),
                          controlPoint: CGPoint(x: 40, y: rect.height - 20))
        path.addLine(to: CGPoint(x: rect.width - 60, y: rect.height - 20))
        path.addQuadCurve(to: CGPoint(x: rect.width - 40, y: rect.height - 40),
                          controlPoint: CGPoint(x: rect.width - 40, y: rect.height - 20))
        path.addLine(to: CGPoint(x: rect.width - 40, y: 10))

        path.lineCapStyle = .round
    }
    
    // MARK: - Layer
    
    private func drawAllLayer() {
        
        let layer = CAShapeLayer()
        
        layer.path = path.cgPath
        layer.strokeColor = UIColor.gray.cgColor
        layer.lineWidth = 5
        layer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(layer)
        
        drawAlcoholGradientLayer()
        drawBaseGradientLayer()
        drawTasteGradientLayer()
    }
    
    private func drawAlcoholGradientLayer() {
        // 위에서 부터 첫 번째
        
        alcoholGradientLayer.frame = path.bounds
        alcoholGradientLayer.frame.size.height = path.bounds.size.height / 3 + 12
        alcoholGradientLayer.frame.size.width = path.bounds.size.width - 4
        alcoholGradientLayer.locations = topStartLocations as [NSNumber]
        alcoholGradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        alcoholGradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        alcoholGradientLayer.anchorPoint = CGPoint(x: 0.48, y: 0.5)
        
        layer.insertSublayer(alcoholGradientLayer, at: 0)

        alcoholGradientLayer.locations = topEndLocations as [NSNumber]
    }
    
    private func drawBaseGradientLayer() {
        // 위에서 부터 두 번째

        baseGradientLayer.frame = path.bounds
        baseGradientLayer.frame.size.height = path.bounds.size.height / 3
        baseGradientLayer.frame.size.width = path.bounds.size.width - 4
        baseGradientLayer.locations = startLocations as [NSNumber]
        baseGradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        baseGradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        baseGradientLayer.anchorPoint = CGPoint(x: 0.48, y: -0.56)
        
        layer.insertSublayer(baseGradientLayer, at: 0)
        
        baseGradientLayer.locations = endLocations as [NSNumber]
    }
    
    private func drawTasteGradientLayer() {
        // 위에서 부터 세 번째
        
        tasteGradientLayer.frame = path.bounds
        tasteGradientLayer.frame.size.height = path.bounds.size.height / 3
        tasteGradientLayer.frame.size.width = path.bounds.size.width - 4
        tasteGradientLayer.locations = startLocations as [NSNumber]
        tasteGradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        tasteGradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        tasteGradientLayer.anchorPoint = CGPoint(x: 0.48, y: -1.46)
        
        // CorenerRadius
        tasteGradientLayer.cornerRadius = 15
        tasteGradientLayer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        layer.insertSublayer(tasteGradientLayer, at: 0)
        
        tasteGradientLayer.locations = endLocations as [NSNumber]
    }
    
    // MARK: - GradientAction
    
    public func gradientColorInit() {
        
        alcoholGradientLayer.colors = []
        baseGradientLayer.colors = []
        tasteGradientLayer.colors = []
    }
    
    public func alcoholGradient() {
        
        alcoholGradientLayer.colors = [UIColor.appMainColor(.subSkyBlueColor).cgColor, UIColor.clear.cgColor]
        
        let alcoholAnimation = CABasicAnimation(keyPath: "locations")
        alcoholAnimation.fromValue = topStartLocations
        alcoholAnimation.toValue = topEndLocations
        alcoholAnimation.duration = self.duration

        alcoholAnimation.timingFunction = .init(name: .easeOut)
        
        alcoholGradientLayer.add(alcoholAnimation, forKey: "toplocation")
    }
    
    public func baseGradient() {
        
        baseGradientLayer.colors = [UIColor.appMainColor(.subYelloColor).cgColor, UIColor.clear.cgColor]
        
        let baseAnimtation = CABasicAnimation(keyPath: "locations")
        baseAnimtation.fromValue = startLocations
        baseAnimtation.toValue = endLocations
        baseAnimtation.duration = self.duration

        baseAnimtation.timingFunction = .init(name: .easeOut)
        
        baseGradientLayer.add(baseAnimtation, forKey: "middlelocation")
    }
    
    public func tasteGradient() {

        tasteGradientLayer.colors = [UIColor.appMainColor(.subOrangeColor).cgColor, UIColor.clear.cgColor]
        
        let tasteAnimation = CABasicAnimation(keyPath: "locations")
        tasteAnimation.fromValue = startLocations
        tasteAnimation.toValue = endLocations
        tasteAnimation.duration = self.duration
        // 미정
        tasteAnimation.timingFunction = .init(name: .easeOut)
        
        tasteGradientLayer.add(tasteAnimation, forKey: "bottomlocation")
    }
    
}
