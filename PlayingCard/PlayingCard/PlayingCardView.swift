//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Frank Su on 2019-09-12.
//  Copyright © 2019 frankusu. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    //setNeedsLayout() change look of card for subviews
    var rank: Int = 5 { didSet{ setNeedsDisplay(); setNeedsLayout() } }
    var suit: String = "♥" { didSet{ setNeedsDisplay(); setNeedsLayout() } }
    var isFaceUp: Bool = true { didSet{ setNeedsDisplay(); setNeedsLayout() } }
    
    private func centeredAttributedString(_ string: String, font: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(font)
        //don't forget UIFontMetrics. Accessibility font size slider
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle,.font:font])
    }
    
    private lazy var upperLeftCornerLabel = createCornerLabel()
    private lazy var lowerRightCornerLabel = createCornerLabel()
    
    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0 //use as many lines as you want EX:"5\n<3" needs 2 lines
        addSubview(label)
        return label
    }
    
    private func configureCornerLabel(_ label : UILabel) {
        label.attributedText = cornerString
        label.frame.size = CGSize.zero //need to clear x,y so sizeToFit will expand both directions
        label.sizeToFit()
        label.isHidden = !isFaceUp
    }
    
    private var cornerString: NSAttributedString {
        return centeredAttributedString(rankString + "\n" + suit, font: cornerFontSize)
    }
    //when Accessibility font changes the app needs to know to redraw
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    //setNeedsLayout will eventually call this
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureCornerLabel(upperLeftCornerLabel)
        upperLeftCornerLabel.frame.origin = bounds.origin.offSetBy(dx: cornerOffset, dy: cornerOffset)
        configureCornerLabel(lowerRightCornerLabel)
        //lowerRightCornerLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        lowerRightCornerLabel.transform = CGAffineTransform.identity
            .translatedBy(x: lowerRightCornerLabel.frame.size.width, y: lowerRightCornerLabel.frame.size.height)
            .rotated(by: CGFloat.pi)
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offSetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offSetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
    }
    //setNeedsDisplay will eventually call this
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
    }
}
extension PlayingCardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundSize: CGFloat = 0.75
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
    private var rankString : String {
        switch rank {
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
    
}
extension CGRect {
    var leftHalf : CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf : CGRect {
        return CGRect(x: midX, y: midY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth)/2, dy: (height - newHeight)/2 )
    }
    
}
extension CGPoint {
    func offSetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}

//how to draw a circle in override func draw(_ rect: CGRect) {
//        if let context = UIGraphicsGetCurrentContext() {
//            //startAngle starts on right side
//            context.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//            context.setLineWidth(5.0)
//            UIColor.red.setStroke()
//            UIColor.green.setFill()
//            context.strokePath()
//            context.fillPath() //won't fill since strokePath consumes the path
//        }

//        let path = UIBezierPath()
//        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//        path.lineWidth = 5.0
//        UIColor.red.setStroke()
//        UIColor.green.setFill()
//        path.stroke()
//        path.fill()
//}
