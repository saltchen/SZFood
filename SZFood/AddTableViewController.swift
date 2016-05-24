//
//  AddTableViewController.swift
//  SZFood
//
//  Created by admin on 16/5/15.
//  Copyright © 2016年 saltchen. All rights reserved.
//

import UIKit
import CoreData

class AddTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var restaurant:Restaurant!
    var isVisited:Bool = false
    
    @IBOutlet weak var resImageView: UIImageView!
    @IBOutlet weak var labelName: UITextField!
    @IBOutlet weak var labelType: UITextField!
    @IBOutlet weak var locationLabel: UITextField!
    @IBOutlet weak var labelVisited: UILabel!
    
    

    @IBAction func btnTap(sender: UIButton) {
        
       if sender.tag == 101 {
        
        labelVisited.text = "我有去过啦"
        
       }else {
        
        labelVisited.text = "没有去过啦"
        }
    }
    
    
    @IBAction func saveAction(sender: UIBarButtonItem) {
        
        //1.获取缓冲区
        
        
       
        let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)? .managedObjectContext
        
        //2.给实体赋值
        
        restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: buffer!) as! Restaurant
        
        
            restaurant.name = labelName.text!
       
       
            restaurant.type = labelType.text!
       
            restaurant.location = locationLabel.text!
      
        if let image = resImageView.image {
            //将图片转化为二进制数据
            restaurant.image = UIImagePNGRepresentation(image)
            
        }
        
        restaurant.isVisited = isVisited
        
        do{
            try buffer?.save()
            
        }catch{
            
            print(error)
            return
        }
       
        
        //保存数据到云端
        saveRecordCloud(restaurant)
        //返回到主控制器
        performSegueWithIdentifier("unwindToHomeList", sender: sender)
        
        
    }
    
    func saveRecordCloud(restaurant:Restaurant!) {
    
    //准备一条需要保存的数据库
        let record = AVObject(className: "Restaurant")
        record["name"] = restaurant.name
        record["type"] = restaurant.type
        record["location"] = restaurant.location
        
        //上传云端的图片进行重新调整
        let originImg = UIImage(data:restaurant.image!)!
        let scalingFac = (originImg.size.width) > 1024 ? 1024/originImg.size.width:1.0
        
        let scaledImg = UIImage(data: restaurant.image!, scale: scalingFac)
        
        //把图片转换为jpg格式，并用leanCloud的filer 保存
        let imgFile = AVFile(name: "\(restaurant.name).jpg",data: UIImageJPEGRepresentation(scaledImg!, 0.8))
        imgFile.saveInBackground()
        
        record["image"] = imgFile
        
        record.saveInBackgroundWithBlock { (isSucced, eror) in
            if isSucced {
            print("保存成功")
            } else if let eror = eror {
            
                print(eror.localizedDescription)
            }
        }
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            
            //判断是否允许用户获取相册权限
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = true
                imagePicker.delegate = self
                imagePicker.sourceType = .PhotoLibrary
                
                //以模态的方式弹出相册
                self.presentViewController (imagePicker,animated: true,completion: nil)
            }
            
            
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //将选择中的照片显示到imageView,并设计其样式
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //从媒体数据字典中查询原始图像的字典
        resImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        resImageView.contentMode = .ScaleAspectFill
        resImageView.clipsToBounds = true
        
        let leftCons = NSLayoutConstraint(item: resImageView, attribute: .Leading, relatedBy: .Equal, toItem: resImageView.superview, attribute: .Leading, multiplier: 1, constant: 0)
        
        let rightCons = NSLayoutConstraint(item: resImageView, attribute: .Trailing, relatedBy: .Equal, toItem: resImageView.superview, attribute: .Trailing, multiplier: 1, constant: 0)
        
        let topCons = NSLayoutConstraint(item: resImageView, attribute: .Top, relatedBy: .Equal, toItem: resImageView.superview, attribute: .Top, multiplier: 1, constant: 0)
        
        let bottomCons = NSLayoutConstraint(item: resImageView, attribute: .Bottom, relatedBy: .Equal, toItem: resImageView.superview, attribute: .Bottom, multiplier: 1, constant: 0)
        
        leftCons.active = true
        rightCons.active = true
        topCons.active = true
        bottomCons.active = true
        //退出相册自己的退场
        dismissViewControllerAnimated(true, completion: nil)
        
        
        
        
    }
    
    
   
    
}
