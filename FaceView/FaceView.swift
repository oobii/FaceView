//
//  FaceView.swift
//  FaceView
//
//  Created by martynov on 2017-01-11.
//  Copyright © 2017 martynov. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    
    @IBInspectable
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var mouthCurvature: Double = 1.0 { didSet { setNeedsDisplay() } } // 1 full smile, -1 full frown
    @IBInspectable
    var eyesOpen: Bool = false { didSet { setNeedsDisplay() } }
    @IBInspectable
    var eyeBrowTilt: Double = 0.5 { didSet { setNeedsDisplay() } } // -1 full furrow, 1 fully relaxed
    @IBInspectable
    var color: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() } }
    @IBInspectable
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    
    func changeScale(recogniser: UIPinchGestureRecognizer) {
        switch recogniser.state {
        case .Changed, .Ended:
            scale *= recogniser.scale
            recogniser.scale = 1.0
        default:
                break
        }
        
    }
    
    // we are using computed vars becaue we need to use bound which is FaceView own property, inhereted from UIView
    private var faceRadius: CGFloat {
        get {
            return min(bounds.size.width, bounds.size.height) / 2 * scale
        }
    }
    
    // we can actually skip the "get"
    private var faceCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    
    // In Swift we do constants with struct
    private struct Ratios {
        static let FaceRadiusToEyeOffset: CGFloat = 3
        static let FaceRadiusToEyeRadius: CGFloat = 10
        static let FaceRadiusToMouthWidth: CGFloat = 1
        static let FaceRadiusToMouthHeight: CGFloat = 3
        static let FaceRadiusToMouthOffset: CGFloat = 3
        static let FaceRadiusToBrowOffset: CGFloat = 5

    }
    
    // We create a new Type
    enum Eye {
        case Left
        case Right
    }
    
    // notice external and internal name for the second var
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath {
        
        let path = UIBezierPath(arcCenter: midPoint, radius: radius, startAngle: 0.0, endAngle: 2*CGFloat(M_PI), clockwise: true)
        path.lineWidth = lineWidth
        return path
    }
    
    
    private func getEyeCenter(eye: Eye) -> CGPoint {
        let eyeOffset = faceRadius/Ratios.FaceRadiusToEyeOffset
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeOffset
        
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        
        return eyeCenter
        
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath {
        
        let eyeRadius = faceRadius / Ratios.FaceRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        let path: UIBezierPath
        
        if eyesOpen {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0.0, endAngle: 2*CGFloat(M_PI), clockwise: true)
            path.lineWidth = lineWidth
            return path
        }
        else {
            
            path = UIBezierPath()
            path.moveToPoint(CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLineToPoint(CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = lineWidth
            return path
            
            
        }
    }
    
    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = faceRadius/Ratios.FaceRadiusToMouthWidth
        let mouthHeight = faceRadius/Ratios.FaceRadiusToMouthHeight
        let mouthOffset = faceRadius/Ratios.FaceRadiusToMouthOffset
        
        let mouthRect = CGRect(x: faceCenter.x - mouthWidth/2, y: faceCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        let smileOffset = CGFloat(max(-1,min(mouthCurvature,1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y :mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y :mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width/3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width/3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
    }
    
    private func pathForBrow(eye: Eye) -> UIBezierPath
    {
        var tilt = eyeBrowTilt
        switch eye {
        case .Left: tilt *= -1.0
        case .Right: break
        }
        var browCenter = getEyeCenter(eye)
        browCenter.y -= faceRadius / Ratios.FaceRadiusToBrowOffset
        let eyeRadius = faceRadius / Ratios.FaceRadiusToEyeRadius
        let tiltOffset = CGFloat(max(-1, min(tilt, 1))) * eyeRadius / 2
        let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
        let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)

        let path = UIBezierPath()
        path.moveToPoint(browStart)
        path.addLineToPoint(browEnd)
        path.lineWidth = lineWidth
        return path
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        UIColor.blueColor().set()
        pathForCircleCenteredAtPoint(faceCenter, withRadius: faceRadius).stroke()
        pathForEye(.Left).stroke()
        pathForEye(.Right).stroke()
        pathForMouth().stroke()
        pathForBrow(.Left).stroke()
        pathForBrow(.Right).stroke()
        
        
        // Then we go to the Main.storyboard
        // resize the our view to the borders
        //and click on the rightmost pictogram in the
        // bottom right conner and select "Reset to Suggesting Constrains"
        // in the Identity Inspector change Class to FaceView!
        
    }
    
    
}
