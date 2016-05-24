//
//  GuiderContentController.swift
//  SZFood
//
//  Created by admin on 16/5/15.
//  Copyright © 2016年 saltchen. All rights reserved.
//

import UIKit

class GuiderContentController: UIViewController {
    
    @IBOutlet weak var labelHeading: UILabel!
    
        @IBOutlet weak var labelFooting: UILabel!
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var pageControl: UIPageControl!
        @IBOutlet weak var doneBtn: UIButton!
        
        //当用户点击之后，退出当前这个控制器
        @IBAction func doneBtn(sender: UIButton) {
            
            dismissViewControllerAnimated(true,completion: nil)
            
            //存在这个点击事件，
            let defaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setBool(true, forKey: "guiderShow")
            
            
        }
        
        
        var index = 0
        var heading = ""
        var footing = ""
        var imageName = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            labelFooting.text = footing
            labelHeading.textColor = UIColor.init(red: 60.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1)
            labelHeading.text = heading
            imageView.image = UIImage(named: imageName)
            pageControl.currentPage = index
            
            //对于进入应用先进行判断
            
            if index == 2 {
                
                doneBtn.hidden = false
                doneBtn.setTitle("马上体验", forState: .Normal)
                
            }else {
                
                doneBtn.hidden = true
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


