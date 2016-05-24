//
//  reviewViewController.swift
//  SZFood
//
//  Created by admin on 16/5/15.
//  Copyright © 2016年 saltchen. All rights reserved.
//

import UIKit

class reviewViewController: UIViewController {
    var rating: String?
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBAction func ratingBtnTapped(sender: UIButton) {
        
        
        switch sender.tag {
        case 110:
            rating = "dislike"
        case 200:
            rating = "good"
        case 300:
            rating = "great"
        default:break
        }
        
        //执行反向转场的代码
        performSegueWithIdentifier("unwindToDetailView", sender: sender)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景虚拟化效果实现代码
        let blurEffect = UIBlurEffect(style: .Light)
        
        let effectView = UIVisualEffectView(effect: blurEffect)
        
        effectView.frame = view.frame
        
        bgImage.addSubview(effectView)
        
        //stackView的动画实现效果
        let scale = CGAffineTransformMakeScale(0, 0)
        let tranlate = CGAffineTransformMakeTranslation(0, 500)
        
        stackView.transform = CGAffineTransformConcat(scale, tranlate)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        //stackView缩放效果实现方法
        /*
         UIView.animateWithDuration(1) {
         self.stackView.transform = CGAffineTransformIdentity
         }
         */
        //stackView蹦蹦效果实现方法
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
            self.stackView.transform = CGAffineTransformIdentity
            }, completion: nil)
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
