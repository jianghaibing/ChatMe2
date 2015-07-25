//
//  LoginViewController.swift
//  ChatMe
//
//  Created by baby on 15/7/22.
//  Copyright © 2015年 Beijing Gold Finger Education Technology LLC. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius:CGFloat {
        get {
            return layer.cornerRadius
        }set{
            layer.cornerRadius = newValue
            layer.masksToBounds = (newValue > 0)
        }
    }
}


class LoginViewController: UIViewController,JSAnimatedImagesViewDataSource {
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var background: JSAnimatedImagesView!

    override func viewDidLoad() {
        super.viewDidLoad()
        background.dataSource = self

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.5) { () -> Void in
            self.loginStackView.axis = UILayoutConstraintAxis.Vertical
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
        return 3
    }
    
    func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named: "background\(index)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
