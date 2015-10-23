//
//  RegistTableViewController.swift
//  ChatMe
//
//  Created by baby on 15/7/31.
//  Copyright © 2015年 Beijing Gold Finger Education Technology LLC. All rights reserved.
//

import UIKit

class RegistTableViewController: UITableViewController {

    @IBOutlet var textFields: [UITextBox]!
    @IBOutlet weak var userNameTextField: UITextBox!
    @IBOutlet weak var passwordTextField: UITextBox!
    @IBOutlet weak var emailTextField: UITextBox!
    @IBOutlet weak var regionTextField: UITextBox!
    @IBOutlet weak var tipsTextField: UITextBox!
    @IBOutlet weak var answerTextField: UITextBox!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    var possibleInputs:Inputs = []
    
    /*
    func checkRequiredTextFields() {
        for textfield in textFields{
            if textfield.text!.isEmpty {
                self.noticeError("必填项为空", autoClear: true, autoClearTime: 1)
            }
        }
        
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let checkEmail = NSPredicate(format: "SELF MATCHES %@", regex)
        guard checkEmail.evaluateWithObject(emailTextField.text) else {
            noticeError("邮箱格式不对", autoClear: true, autoClearTime: 1)
            return
        }
        
        
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneBarButton.enabled = false
        
        /// 验证用户名
        let userValidator = AJWValidator(type: AJWValidatorType.String)
        userValidator.addValidationToEnsureMinimumLength(3, invalidMessage: "最小3位")
        userValidator.addValidationToEnsureMaximumLength(16, invalidMessage: "最大16位")
        userNameTextField.ajw_attachValidator(userValidator)
        
        userValidator.validatorStateChangedHandler = ({ (state:AJWValidatorState) -> Void in
            switch state {
            case AJWValidatorState.ValidationStateValid:
                self.userNameTextField.highlightState = UITextBoxHighlightState.Default
                self.possibleInputs.unionInPlace(Inputs.userName)
            default:
                let errorMsg = userValidator.errorMessages.first as! String
                self.userNameTextField.highlightState = UITextBoxHighlightState.Wrong(errorMsg)
                self.possibleInputs.subtractInPlace(Inputs.userName)
            }
            self.doneBarButton.enabled = self.possibleInputs.isAllValidate()
        })
        /**
        验证密码
        */
        let pwdValidator = AJWValidator(type: AJWValidatorType.String)
        pwdValidator.addValidationToEnsureMinimumLength(6, invalidMessage: "最小6位")
        pwdValidator.addValidationToEnsureMaximumLength(16, invalidMessage: "最大16位")
        passwordTextField.ajw_attachValidator(pwdValidator)
        
        pwdValidator.validatorStateChangedHandler = ({ (state:AJWValidatorState) -> Void in
            switch state {
            case AJWValidatorState.ValidationStateValid:
                self.passwordTextField.highlightState = UITextBoxHighlightState.Default
                self.possibleInputs.unionInPlace(Inputs.password)
            default:
                let errorMsg = pwdValidator.errorMessages.first as! String
                self.passwordTextField.highlightState = UITextBoxHighlightState.Wrong(errorMsg)
                self.possibleInputs.subtractInPlace(Inputs.password)
            }
            self.doneBarButton.enabled = self.possibleInputs.isAllValidate()
        })
        
        /**
        验证邮箱
        */
        let emailValidator = AJWValidator(type: AJWValidatorType.String)
        emailValidator.addValidationToEnsureValidEmailWithInvalidMessage("邮箱格式不对")
        emailTextField.ajw_attachValidator(emailValidator)
        
        emailValidator.validatorStateChangedHandler = ({ (state:AJWValidatorState) -> Void in
            switch state {
            case AJWValidatorState.ValidationStateValid:
                self.emailTextField.highlightState = UITextBoxHighlightState.Default
                self.possibleInputs.unionInPlace(Inputs.email)
            default:
                let errorMsg = emailValidator.errorMessages.first as! String
                self.emailTextField.highlightState = UITextBoxHighlightState.Wrong(errorMsg)
                self.possibleInputs.subtractInPlace(Inputs.email)
            }
            self.doneBarButton.enabled = self.possibleInputs.isAllValidate()
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func registDone(sender: UIBarButtonItem) {
        //显示一个载入提示
        self.pleaseWait()
        
        //建立用户AVObject
        let user = AVObject(className: "HBUser")
        user["user"] = self.userNameTextField.text
        user["password"] = self.passwordTextField.text
        user["email"] = self.emailTextField.text
        user["region"] = self.regionTextField.text
        user["tips"] = self.tipsTextField.text
        user["answer"] = self.answerTextField.text
        
        //执行查询
        let query = AVQuery(className: "HBUser")
        query.whereKey("user", equalTo: self.userNameTextField.text)
        
        //如果查询到相关用户
        query.getFirstObjectInBackgroundWithBlock { (obj, error) -> Void in
            self.clearAllNotice()
            if obj != nil {
                self.errorNotice("用户已注册")
                self.userNameTextField.becomeFirstResponder()
                self.doneBarButton.enabled = false
            }else{
                user.saveInBackgroundWithBlock({ (succed, error) -> Void in
                    if succed {
                        self.successNotice("用户成功注册")
                        self.navigationController?.popViewControllerAnimated(true)
                    }else{
                        print(error)
                    }
                })
            }
        }
    }

    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
