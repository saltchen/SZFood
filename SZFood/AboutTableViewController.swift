//
//  AboutTableViewController.swift
//  SZFood
//
//  Created by admin on 16/5/15.
//  Copyright © 2016年 saltchen. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
    
    var sectionTitle = ["评分和反馈","关注我们"]
    var sectionContent = [["在app store 上评分","反馈意见"],["微信","github","我的博客"]]
    
    var links = ["http://www.baidu.com","https://github.com/saltchen","http://www.taobao.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏空余行
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitle.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? 2 : 3
    }
    
    //实现区块列表的标题
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionTitle[section]
    }
    
    
    //单元格内容的实现
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AboutCell", forIndexPath: indexPath)
        //将textLabel赋值，具体哪一区块与哪一行
        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]
        
        
        
        return cell
    }
    
    //当用户点击时候，处理单元格点击事件的一些方法
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //判断用户点击了哪一个区块
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0{
                
                if  let url = NSURL(string: "http://apple.com/itunes/charts/paid-apps/") {
                    
                    UIApplication.sharedApplication().openURL(url)
                    
                }
            }else if indexPath.row == 1 {
                
                // print("为什么无法手工转场")
                //手工转场，加载到WebViewController
                
                performSegueWithIdentifier("toWebView", sender: self)
                
            }
        case 1:
            
            //判断links中是否可以转换成url
            if let url = NSURL(string:links[indexPath.row]){
                
                //初始化一个SFSafariViewController控制器，
                let sfVC = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
                
                //以present的方式展现这个控制器
                presentViewController(sfVC, animated: true, completion: nil)
                
                
            }
        default:
            break
        }
        //设置动画
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
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
