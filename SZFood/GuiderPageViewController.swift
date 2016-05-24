//
//  GuiderPageViewController.swift
//  SZFood
//
//  Created by admin on 16/5/15.
//  Copyright © 2016年 saltchen. All rights reserved.
//

import UIKit

class GuiderPageViewController: UIPageViewController ,UIPageViewControllerDataSource {
    var headings = ["私人定制", "饕馆定位", "美食发现"]
var images = ["foodpin-intro-1", "foodpin-intro-2", "foodpin-intro-3"]
var footers = ["好店随时加，打造自己的美食向导", "马上找到饕餮大餐之馆的位置", "发现其他吃货的珍藏"]

override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    if let startVc = viewControllerAtIndex(0) {
        
        setViewControllers([startVc], direction: .Forward, animated: true, completion: nil)
    }
    
    // Do any additional setup after loading the view.
}

//通过实现数据源方法，可以实现下一个视图控制器
func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    
    var index = (viewController as? GuiderContentController)?.index
    index = index! + 1
    
    return viewControllerAtIndex(index!)
}
//通过实现数据源方法，可以实现上一个视图控制器
func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    var index = (viewController as? GuiderContentController)?.index
    
    index = index! - 1
    
    return viewControllerAtIndex(index!)
}

//显示引导页面的行数
/*
 //实现了数据源方法，引导页面究竟有多少页面
 
 func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
 return headings.count
 }
 
 //起始页面
 func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
 
 return 0
 }
 */


//复用一个ViewController控制器

func viewControllerAtIndex(index: Int) -> GuiderContentController? {
    //swift2中的新语法，表示index是否在合理区间
    if case 0 ..< headings.count = index {
        
        //创建一个新的控制器并初始化这个控制器还带有ID的，并进行数据传递
        if let contenVc = storyboard?.instantiateViewControllerWithIdentifier("GuiderContentController") as? GuiderContentController {
            
            contenVc.heading = headings[index]
            contenVc.imageName = images[index]
            contenVc.footing = footers[index]
            contenVc.index = index
            
            return contenVc
            
        }
        
    }
    return nil
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
