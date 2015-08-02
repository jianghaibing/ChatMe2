//
//  ConversationListViewController.swift
//  ChatMe
//
//  Created by baby on 15/7/11.
//  Copyright © 2015年 Beijing Gold Finger Education Technology LLC. All rights reserved.
//

import UIKit


class ConversationListViewController: RCConversationListViewController {

    @IBAction func showMenu(sender: UIBarButtonItem) {
        /*
        //KXMenu实现的菜单
        
        var frame = sender.valueForKey("view")?.frame
        frame?.origin.y += 28
        
        KxMenu.showMenuInView(self.view, fromRect: frame!, menuItems: [
            
            KxMenuItem("客服",image:UIImage(named: "serve"),target:self,action:"goServe"),
            KxMenuItem("好友",image:UIImage(named: "contact"),target:self,action:"goFrend")
            
            ])
        */
        //popmenu实现菜单
        
        let items = [
            MenuItem(title: "会话", iconName: "coversation", glowColor: UIColor(red: 0.3, green:0.5 , blue: 0.6, alpha: 0.8), index: 0),
            MenuItem(title: "通讯录", iconName: "contact", glowColor: UIColor(red: 0.8, green:0.1 , blue: 0.3, alpha: 0.8), index: 1),
            MenuItem(title: "客服", iconName: "serve", glowColor: UIColor(red: 0.9, green:0.3 , blue: 0.4, alpha: 0.8), index: 2),
            MenuItem(title: "关于", iconName: "about", glowColor: UIColor(red: 0.2, green:0.6 , blue: 0.4, alpha: 0.8), index: 3)
        ]
        
        let popMenu = PopMenu(frame: self.view.bounds, items: items)
        popMenu.menuAnimationType = PopMenuAnimationType.NetEase
        if popMenu.isShowed {
            return
        }
        popMenu.didSelectedItemCompletion = { (selectedItem:MenuItem!) -> Void in
            print(selectedItem.index)
            if selectedItem.index == 0 {
                self.performSegueWithIdentifier("test", sender: self)

            }
        }
        popMenu.showMenuAtView(self.view)
    }
    
//    func goServe(){
//        print("dianjile")
//    }
//    
//    func goFrend(){
//        print("frend")
//    }
    
    var conversationModel:RCConversationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
        appDelegate.connetServer { () -> Void in
            print("连接成功！")
            self.setDisplayConversationTypes([
                RCConversationType.ConversationType_APPSERVICE.rawValue,
                RCConversationType.ConversationType_CHATROOM.rawValue,
                RCConversationType.ConversationType_CUSTOMERSERVICE.rawValue,
                RCConversationType.ConversationType_DISCUSSION.rawValue,
                RCConversationType.ConversationType_GROUP.rawValue,
                RCConversationType.ConversationType_PRIVATE.rawValue,
                RCConversationType.ConversationType_PUBLICSERVICE.rawValue,
                RCConversationType.ConversationType_SYSTEM.rawValue
                ])
            self.refreshConversationTableViewIfNeeded()
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
   
        self.refreshConversationTableViewIfNeeded()


        setConversationAvatarStyle(RCUserAvatarStyle.USER_AVATAR_CYCLE)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "onSelectCell" {
            let destVC = segue.destinationViewController as? ConversationViewController
            destVC!.targetId = conversationModel?.targetId
            destVC!.userName = conversationModel?.conversationTitle
            destVC!.conversationType = RCConversationType.ConversationType_PRIVATE
            destVC!.title = conversationModel?.conversationTitle
            destVC!.setMessageAvatarStyle(.USER_AVATAR_CYCLE)
        }
       
        
    }
    
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        conversationModel = model
        performSegueWithIdentifier("onSelectCell", sender: self)
    }

}
