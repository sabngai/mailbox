//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Ngai, Sabrina on 9/5/16.
//  Copyright © 2016 Ngai, Sabrina. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    var messageOriginalCenter: CGPoint!
    var messageLeft: CGPoint!
    var messageRight: CGPoint!
    
    var laterIconLocation: CGPoint!
    var archiveIconLocation: CGPoint!
    var laterIconOriginalCenter: CGPoint!
    var archiveIconOriginalCenter: CGPoint!
    var deleteIconLocation: CGPoint!
    var deleteIconOriginalCenter: CGPoint!
    var listIconLocation: CGPoint!
    var listIconOriginalCenter: CGPoint!
    
    var messageScrollViewOriginalCenter: CGPoint!
    var messageScrollViewOffset: CGFloat!
    var messageScrollViewLeft: CGPoint!
    var messageScrollViewRight: CGPoint!
    
    //CGPoint defines coordinates in 2D space. It's composed of two CGFloats: X and Y.
    
    @IBOutlet var viewBackground: UIView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageScrollView: UIScrollView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var menuView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageScrollView.contentSize = CGSize(width: 320, height: 1500)
        messageScrollViewOffset = 260
        
        messageScrollViewLeft = messageScrollView.center
        messageScrollViewRight = CGPoint(x: messageScrollView.center.x + messageScrollViewOffset ,y: messageScrollView.center.y)
        
        messageLeft = CGPoint(x: messageView.center.x ,y: messageView.center.y)
        messageRight = CGPoint(x: messageView.center.x ,y: messageView.center.y)
        
        laterIconLocation = CGPoint(x: laterIcon.center.x ,y: laterIcon.center.y)
        archiveIconLocation = CGPoint(x: archiveIcon.center.x ,y: archiveIcon.center.y)
        deleteIconLocation = CGPoint(x: deleteIcon.center.x ,y: deleteIcon.center.y)
        listIconLocation = CGPoint(x: listIcon.center.x ,y: listIcon.center.y)
        
        viewBackground.backgroundColor = UIColor(red: 194/255, green: 192/255, blue: 197/255, alpha: 1.0)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionableMessage(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            messageOriginalCenter = messageView.center
            laterIconOriginalCenter = laterIcon.center
            archiveIconOriginalCenter = archiveIcon.center
            deleteIconOriginalCenter = deleteIcon.center
            archiveIcon.alpha = 1
            deleteIcon.alpha = 0
            laterIcon.alpha = 1
            listIcon.alpha = 0

        } else if sender.state == UIGestureRecognizerState.Changed {
            //print("changing")
            messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
            if translation.x > 0 && translation.x <= 60 {
               print("t x right")
                viewBackground.backgroundColor = UIColor(red: 194/255, green: 192/255, blue: 197/255, alpha: 1.0)
                
            } else if translation.x > 60 && translation.x <= 200 { //green
                viewBackground.backgroundColor = UIColor(red: 107/255, green: 233/255, blue: 103/255, alpha: 1.0)
                
            } else if translation.x > 200 { //red
                viewBackground.backgroundColor = UIColor(red: 235/255, green: 47/255, blue: 43/255, alpha: 1.0)
                archiveIcon.alpha = 0
                deleteIcon.alpha = 1
                
            } else if translation.x < 0 && translation.x >= -60 {
              print("t x left")
              
                
            } else if translation.x < -60 && translation.x >= -260 {
               viewBackground.backgroundColor = UIColor(red: 254/255, green: 202/255, blue: 18/255, alpha: 1.0)
               //laterIcon.center = CGPoint(x: laterIconOriginalCenter.x + translation.x, y: laterIconOriginalCenter.y)

                
            } else if translation.x < -260 {
                viewBackground.backgroundColor = UIColor(red: 117/255, green: 47/255, blue: 43/255, alpha: 1.0)
                laterIcon.alpha = 0
                listIcon.alpha = 1
                
            }
            

        } else if sender.state == UIGestureRecognizerState.Ended {
            var velocity = sender.velocityInView(view)
            
            if velocity.x > 0 {
                print("slide right velocty x > 0")
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                    self.messageView.center = self.messageRight
                    }, completion: { (Bool) -> Void in
                })

            } else if velocity.x <  0 {
                print("slide left velocty x < 0")
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                    self.messageView.center = self.messageLeft
                    }, completion: { (Bool) -> Void in
                })
                rescheduleView.alpha = 1
            }


        }

    }

    @IBAction func onTapReschedule(sender: AnyObject) {
        rescheduleView.alpha = 0
    }
    
    @IBAction func menuButton(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        print("menu button")
        if sender.state == UIGestureRecognizerState.Began {
            messageScrollViewOriginalCenter = messageScrollView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageScrollView.center = CGPoint(x: messageScrollViewOriginalCenter.x + translation.x, y: messageScrollViewOriginalCenter.y)

        } else if sender.state == UIGestureRecognizerState.Ended {
            var velocity = sender.velocityInView(view)
            
            if velocity.x > 0 {

                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                    self.messageScrollView.center = self.messageScrollViewRight
                    }, completion: { (Bool) -> Void in
                })
            } else if velocity.x <  0 {

                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                    self.messageScrollView.center = self.messageScrollViewLeft
                    }, completion: { (Bool) -> Void in
                })
            }
            
            
        }

    }
    

}
