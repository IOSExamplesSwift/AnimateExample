//
//  ViewController.swift
//  AnimateExample
//
//  Created by Douglas Alexander on 5/9/18.
//  Copyright © 2018 Douglas Alexander. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var scaleFactor: CGFloat = 2
    var angle: Double = 180
    
    var boxView: UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }

    func initView() {
        let frameRect = CGRect(x: 20, y: 20, width: 45, height: 45)
        boxView = UIView(frame: frameRect)
        
        if let view = boxView {
            view.backgroundColor = UIColor.blue
            self.view.addSubview(view)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // when touch occurs get the location
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            
            // 1. timing
            // the following creates cube timing instance with ease in / out
             let timing = UICubicTimingParameters(animationCurve: .easeInOut)
            
            // the following creates spring tamping
            // to use this timing comment out the above timing variable definition and un-comment the following timing variable definition
            // 2. timing
//            let timing = UISpringTimingParameters(mass: 0.5, stiffness: 0.5, damping: 0.3, initialVelocity: CGVector(dx: 1.0, dy: 0.0))
            
            // create the animation object with timing object
            let animator = UIViewPropertyAnimator(duration: 2.0, timingParameters: timing)
            
            // add closure to animation object
            animator.addAnimations {
                
                // set up the scale for the transformation view
                let scaleTrans = CGAffineTransform(scaleX: self.scaleFactor, y: self.scaleFactor)
                
                // set up the rotation
                let rotateTrans = CGAffineTransform(rotationAngle: CGFloat(self.angle * .pi / 180))
                
                // add the scale and rotation
                self.boxView!.transform = scaleTrans.concatenating(rotateTrans)
             
                // switch the scale and rotation with each touch
                self.angle = (self.angle == 180 ? 360 : 180)
                self.scaleFactor = (self.scaleFactor == 2 ? 1 :2)
                
                // cahnge the color and move to new location
                self.boxView?.backgroundColor = UIColor.purple
                self.boxView?.center = location
            }
            // when finished rotating change color to green
            animator.addCompletion {_ in
                self.boxView?.backgroundColor = UIColor.green
            }
            
            // start the animation
            animator.startAnimation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

