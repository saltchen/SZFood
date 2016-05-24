//
//  WebViewController.swift
//  SZFood
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 saltchen. All rights reserved.
//
import UIKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //打开一个新的控制器浏览网页
        if let url = NSURL(string: "https://www.baidu.com/") {
            
            //加载这个网址
            webView.loadRequest(NSURLRequest(URL:url))
        }
        
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
