//
//  ResDetailTableViewController.swift
//  SZFood
//
//  Created by admin on 16/5/15.
//  Copyright © 2016年 saltchen. All rights reserved.
//

import UIKit

class ResDetailTableViewController: UITableViewController {

    @IBOutlet weak var resImage: UIImageView!
    @IBOutlet weak var btnimage: UIButton!
    
    var restaurant: Restaurant!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resImage.image = UIImage(data: restaurant.image!)
        
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)
        title = restaurant.name
        
        //自适应行高
        tableView.estimatedRowHeight = 36
        tableView.rowHeight = UITableViewAutomaticDimension
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    /*
     override func viewDidAppear(animated: Bool) {
     if restaurant.rating != nil{
     _rating = self.restaurant.rating!
     
     }
     }
     */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! ResDetailTableViewCell
        
        
        switch indexPath.row {
        case 0:
            cell.labelName.text = "餐馆名"
            cell.labelDetail.text = restaurant.name
        case 1:
            cell.labelName.text = "类型"
            cell.labelDetail.text = restaurant.type
        case 2:
            cell.labelName.text = "地点"
            cell.labelDetail.text = restaurant.location
        case 3:
            cell.labelName.text = "是否来过"
            cell.labelDetail.text = restaurant.isVisited.boolValue ? "来过" : "没来过"
            
        default:
            cell.labelName.text = ""
            cell.labelDetail.text = ""
        }
        
        cell.backgroundColor = UIColor.clearColor()
        // Configure the cell...
        
        return cell
    }
    
    
    
        
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    //地图转场前的一些代码
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap"{
            
            let detvc = segue.destinationViewController as! MapViewController
            detvc.restaurant = self.restaurant
            
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        if let sourceVC = segue.sourceViewController as? reviewViewController {
            if let rating = sourceVC.rating {
                
                
                self.restaurant.rating = rating
                self.btnimage.setImage(UIImage(named: rating), forState: .Normal)
            }
            
            let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
            do {
                
                try buffer?.save()
            }catch{
                
                print(error)
            }
            
        }
    }
    
}

