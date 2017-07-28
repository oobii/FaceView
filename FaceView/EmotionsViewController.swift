//
//  EmotionsViewController.swift
//  FaceView
//
//  Created by martynov on 2017-03-02.
//  Copyright © 2017 martynov. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    fileprivate var emotions: Dictionary<String,FacialExpression> = [
        "angry":FacialExpression(eyes: .squinting, eyeBrows: .furrowed, mouth: .frown),
        "happy":FacialExpression(eyes: .open, eyeBrows: .relaxed, mouth: .smile),
        "worried":FacialExpression(eyes: .squinting, eyeBrows: .normal, mouth: .smirk),
        "mischievious":FacialExpression(eyes: .squinting, eyeBrows: .relaxed, mouth: .grin)]
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationvc = segue.destination
        
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
