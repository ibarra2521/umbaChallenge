//
//  CircularView.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

@IBDesignable
class CircularView: UIView {
    
    var imageView: UIImageView?
    var shapeLayer: CAShapeLayer?
    var image: UIImage? { didSet { setupView() }}

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        imageView = UIImageView()
        addSubview(imageView ?? UIView())
        let padding: CGFloat = 10
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        imageView?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        imageView?.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        imageView?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        imageView?.image = image
        shapeLayer = CAShapeLayer()
    }
    
    override func draw(_ rect: CGRect) {
        drawRingSquareView()
    }
    
    internal func drawRingSquareView() {
        let midPoint: CGFloat = bounds.size.width/2
        let lineWidth: CGFloat = 2
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: midPoint, y: midPoint),
            radius: CGFloat(midPoint - (lineWidth/2)),
            startAngle: CGFloat(0),
            endAngle: CGFloat(Double.pi * 2),
            clockwise: true)
        if let sl = shapeLayer {
            sl.path = circlePath.cgPath
            sl.fillColor = UIColor.clear.cgColor
            sl.strokeColor = UIColor.lightGray.cgColor
            sl.lineWidth = lineWidth
            layer.addSublayer(sl)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height / 2
        clipsToBounds = true
        shapeLayer?.removeFromSuperlayer()
        drawRingSquareView()
        guard let imgView = imageView else { return }
        imgView.layer.cornerRadius = imgView.frame.size.height / 2
        imgView.clipsToBounds = true
    }
}
