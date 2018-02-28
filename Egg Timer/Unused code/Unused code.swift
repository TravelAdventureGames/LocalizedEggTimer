//
//  Unused code.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 22-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation
//private func addShapeLayerWith(shapeLayer: CAShapeLayer, center: CGPoint, radius: CGFloat, to label: UILabel) {
//    let center = center
//    let trackLayer = CAShapeLayer()
//    let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
//    trackLayer.path = circularPath.cgPath
//
//    trackLayer.strokeColor = UIColor.lightGray.cgColor
//    trackLayer.lineWidth = 2
//    trackLayer.fillColor = UIColor.clear.cgColor
//    trackLayer.lineCap = kCALineCapRound
//    label.layer.addSublayer(trackLayer)
//
//    shapeLayer.path = circularPath.cgPath
//    shapeLayer.strokeColor = UIColor.red.cgColor
//    shapeLayer.lineWidth = 2
//    shapeLayer.fillColor = UIColor.clear.cgColor
//    shapeLayer.lineCap = kCALineCapRound
//    shapeLayer.strokeEnd = 0
//    label.layer.addSublayer(shapeLayer)
//}
//private func addAnimationWith(duration: TimeInterval, toLayer: CAShapeLayer) {
//    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//    basicAnimation.toValue = 1
//    basicAnimation.duration = duration
//    basicAnimation.fillMode = kCAFillModeForwards
//    basicAnimation.isRemovedOnCompletion = false
//    toLayer.add(basicAnimation, forKey: "urSoBasic")
//}
//
//private func setAndStartTimers() {
//    for egg in eggs {
//        print(egg.amount)
//        if egg.amount != 0 {
//            switch egg.desiredEggType {
//            case .Soft:
//                addAnimationWith(duration: 4, toLayer: zachtShapeLayer)
//            case .SoftMedium:
//                addAnimationWith(duration: 9, toLayer: zmShapeLayer)
//            case .Medium:
//                addAnimationWith(duration: 17, toLayer: mediumShapeLayer)
//            case .MediumHard:
//                addAnimationWith(duration: 5, toLayer: mhShapeLayer)
//            case .Hard:
//                addAnimationWith(duration: 8, toLayer: hardShapeLayer)
//            }
//        }
//    }
// Doesnt work - fix
//private func addShapeLayers() {
//    let subViews = timerStackview.arrangedSubviews
//    for egg in eggs {
//        let subview = subViews[egg.desiredEggType.place] as! UILabel
//        if egg.amount != 0 {
//            switch egg.desiredEggType {
//            case .Soft:
//                addShapeLayerWith(shapeLayer: zachtShapeLayer, center: subview.center, radius: subview.bounds.width / 2, to: subview)
//            case .SoftMedium:
//                addShapeLayerWith(shapeLayer: zmShapeLayer, center: subview.center, radius: subview.bounds.width / 2, to: subview)
//            case .Medium:
//                addShapeLayerWith(shapeLayer: mediumShapeLayer, center: subview.center, radius: subview.bounds.width / 2, to: subview)
//            case .MediumHard:
//                addShapeLayerWith(shapeLayer: mhShapeLayer, center: subview.center, radius: subview.bounds.width / 2, to: subview)
//            case .Hard:
//                addShapeLayerWith(shapeLayer: hardShapeLayer, center: subview.center, radius: subview.bounds.width / 2, to: subview)
//            }
//        }
//    }
//}

// Settings
//                self.eggImageview.eggBreak {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//                        if UserdefaultManager.secondLaunch {
//                            self.moveToSettingsVC()
//                        }
//                    })
//                }


