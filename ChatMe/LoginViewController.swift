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


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
