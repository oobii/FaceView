//
//  ViewController.swift
//  FaceView
//
//  Created by martynov on 2017-01-11.
//  Copyright © 2017 martynov. All rights reserved.
//

import UIKit

// MARK: Model

class FaceViewController: UIViewController {
    var expression = FacialExpression(eyes: .Squinting, eyeBrows: .Relaxed, mouth: .Grin) {
        didSet {
            updateUI()
        }
        
    }
    
    // MARK: View
    
    // The UI gets updated when it was first hooked up/initialized
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            
            // Here we added these gesture recognisers in code and can also add them in Story Board
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView,
                action: #selector(FaceView.changeScale(_:))
                ))
            let happieSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self,
                                                                        action: #selector(FaceViewController.increaseHappiness))
            happieSwipeGestureRecognizer.direction = .Up
            faceView.addGestureRecognizer(happieSwipeGestureRecognizer)
            
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self,
                                                                        action: #selector(FaceViewController.decreaseHappiness))
            sadderSwipeGestureRecognizer.direction = .Down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            // We aupdate our UI when this thing is first set
            updateUI()
            
        }
    }
    
    // rename this method vin StoryBoard editor, it was done as a test with namr t
    @IBAction func t(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .Ended {
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            case .Squinting: expression.eyes = .Closed
            }
        }
    }
    
    // Controller is modifyong the model
    func increaseHappiness() {
        expression.mouth = expression.mouth.happieMouth()
    }
    
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    private var mouthCurvatures = [FacialExpression.Mouth.Frown:-1.0, .Grin:0.5,.Smile:1.0,.Smirk:-0.5,.Neutral:0.0]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed:0.5,.Furrowed:-0.5,.Normal:0.0]
    
    
    // Our updateUI take things from our model
    private func updateUI(){
        if faceView != nil {
            switch expression.eyes {
            case .Open: faceView.eyesOpen = true
            case .Closed:faceView.eyesOpen = false
            // we dont have Squinting
            case .Squinting: faceView.eyesOpen = false
            }
            
            // turn the things in the view
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
    }
    
    
}
