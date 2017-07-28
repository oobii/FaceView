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
    
    var expression = FacialExpression(eyes: .squinting, eyeBrows: .relaxed, mouth: .grin) {
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
            happieSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happieSwipeGestureRecognizer)
            
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self,
                                                                        action: #selector(FaceViewController.decreaseHappiness))
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            // We aupdate our UI when this thing is first set
            updateUI()
            
        }
    }
    
    // rename this method vin StoryBoard editor, it was done as a test with namr t
    @IBAction func t(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            switch expression.eyes {
            case .open: expression.eyes = .closed
            case .closed: expression.eyes = .open
            case .squinting: expression.eyes = .closed
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
    
    fileprivate var mouthCurvatures = [FacialExpression.Mouth.frown:-1.0, .grin:0.5,.smile:1.0,.smirk:-0.5,.neutral:0.0]
    fileprivate var eyeBrowTilts = [FacialExpression.EyeBrows.relaxed:0.5,.furrowed:-0.5,.normal:0.0]
    
    
    // Our updateUI take things from our model
    fileprivate func updateUI(){
        if faceView != nil {
            switch expression.eyes {
            case .open: faceView.eyesOpen = true
            case .closed:faceView.eyesOpen = false
            // we dont have Squinting
            case .squinting: faceView.eyesOpen = false
            }
            
            // turn the things in the view
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
    }
    
    
}
