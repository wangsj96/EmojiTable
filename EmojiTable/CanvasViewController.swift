//
//  CanvasViewController.swift
//  EmojiTable
//
//  Created by Sijin Wang on 3/19/18.
//  Copyright © 2018 Sijin Wang. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 210
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
        }
        if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }
        
        if sender.state == .ended {
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [], animations: {
                    self.trayView.center = self.trayDown
                })
            }
            else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.trayView.center = self.trayUp
                })
            }
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceCenter = newlyCreatedFace.center
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            //view.insertSubview(newlyCreatedFace, at: 0)
        }
        if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceCenter.x + translation.x, y: newlyCreatedFaceCenter.y + translation.y)
        }
        if sender.state == .ended {
            let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.didPanNewFace(sender:)))
            
            gestureRecognizer.delegate = self
            newlyCreatedFace.addGestureRecognizer(gestureRecognizer)
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1.5, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    @objc func didPanNewFace(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceCenter = newlyCreatedFace.center
            newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
        if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceCenter.x + translation.x, y: newlyCreatedFaceCenter.y + translation.y)
        }
        if sender.state == .ended {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1.5, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
