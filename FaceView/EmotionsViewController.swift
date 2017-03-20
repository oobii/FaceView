//
//  EmotionsViewController.swift
//  FaceView
//
//  Created by martynov on 2017-03-02.
//  Copyright © 2017 martynov. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    private var emotions: Dictionary<String,FacialExpression> = [
        "angry":FacialExpression(eyes: .Squinting, eyeBrows: .Furrowed, mouth: .Frown),
        "happy":FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smile),
        "worried":FacialExpression(eyes: .Squinting, eyeBrows: .Normal, mouth: .Smirk),
        "mischievious":FacialExpression(eyes: .Squinting, eyeBrows: .Relaxed, mouth: .Grin)]
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationvc = segue.destinationViewController
        
        // if we are in Navigation Controller , we want to look inside to prepare the
        // MVC which is inside
        // View Controller Programming Guide for iOS
        if let navcon = destinationvc as? UINavigationController {
            destinationvc = navcon.visibleViewController ?? destinationvc
        }
        if let facevc = destinationvc as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotions[identifier] {
                    if let sendingButton = sender as? UIButton {
                        facevc.navigationItem.title = sendingButton.currentTitle
                    }
                    
                    facevc.expression = expression
                }
            }
        }
    }
}
