//
//  ProgressRing.swift
//  StudyTimer
//
//  Created by ChatGPT on 04/21/25.
//

import UIKit

/// A simple progress‑ring helper for UIKit.
/// Configure it into any UIView, then call `updateProgress(_:)` to animate.
class ProgressRing {
  private let backgroundLayer = CAShapeLayer()
  private let progressLayer = CAShapeLayer()
  
  /// Call this once (e.g. in viewDidLoad) to wire up your ring into the given container.
  func configure(in container: UIView) {
    // Clear any old layers
    container.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    
    let center = CGPoint(x: container.bounds.midX, y: container.bounds.midY)
    let radius = min(container.bounds.width, container.bounds.height)/2 - 10
    
    // 1) background circle
    let bgPath = UIBezierPath(arcCenter: center,
                              radius: radius,
                              startAngle: -.pi/2,
                              endAngle: 1.5 * .pi,
                              clockwise: true)
    backgroundLayer.path = bgPath.cgPath
    backgroundLayer.strokeColor = UIColor.gray.withAlphaComponent(0.2).cgColor
    backgroundLayer.fillColor = UIColor.clear.cgColor
    backgroundLayer.lineWidth = 10
    container.layer.addSublayer(backgroundLayer)
    
    // 2) progress circle
    progressLayer.path = bgPath.cgPath
    progressLayer.strokeColor = UIColor.systemBlue.cgColor
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.lineWidth = 10
    progressLayer.strokeEnd = 0
    progressLayer.lineCap = .round
    container.layer.addSublayer(progressLayer)
  }
  
  /// Animate/update your ring fill from 0.0…1.0
  func updateProgress(_ progress: CGFloat) {
    CATransaction.begin()
    CATransaction.setAnimationDuration(0.2)
    progressLayer.strokeEnd = max(0, min(1, progress))
    CATransaction.commit()
  }
}
