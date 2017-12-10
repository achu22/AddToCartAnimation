//
//  ViewController.swift
//  AddToCartAnimation
//
//  Created by Alugaddala, Ashish Kumar [GCB-OT] on 12/1/17.
//  Copyright © 2017 Alugaddala, Ashish Kumar [GCB-OT]. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CAAnimationDelegate {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var cartImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cartImage.image = UIImage(named: "cart_empty.png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func addToCartClicked(_ sender: Any) {
        
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: itemImage.center)
        bezierPath.addQuadCurve(to: cartImage.center, controlPoint: CGPoint(x:cartImage.center.y , y:itemImage.center.x ))
        
        let moveAnim = CAKeyframeAnimation(keyPath: "position")
        moveAnim.path = bezierPath.cgPath
        moveAnim.isRemovedOnCompletion = true
        
        let scaleAnim = CABasicAnimation(keyPath: "transform")
        scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(0.1, 0.1, 1.0))
        scaleAnim.isRemovedOnCompletion = true
        
        let opacityAnim = CABasicAnimation(keyPath: "alpha")
        opacityAnim.fromValue = NSNumber(value: 1.0)
        opacityAnim.toValue = NSNumber(value: 0.1)
        opacityAnim.isRemovedOnCompletion = true
        
        let animGroup = CAAnimationGroup()
        animGroup.delegate = self
        animGroup.setValue("curvedAnim", forKey: "animationName")
        animGroup.animations = [moveAnim,scaleAnim,opacityAnim]
        animGroup.duration = 0.5
        itemImage.layer.add(animGroup, forKey: "curvedAnim")
        
        
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    
        if flag && ((anim.value(forKey: "animationName") as? String) == "curvedAnim") {
            cartImage.image = UIImage(named: "cart_full.png")
        }
    }
    
    @IBAction func emptyCartClicked(_ sender: Any) {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.delegate = self
        animation.duration = 0.06
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: cartImage.center.x - 5, y: cartImage.center.y)
        animation.toValue = CGPoint(x: cartImage.center.x + 5, y: cartImage.center.y)
        cartImage.layer.add(animation, forKey: "position")
        cartImage.image = UIImage(named: "cart_empty.png")
    }
}

