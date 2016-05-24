//
//  ReataurantTableViewController.swift
//  SZFood
//
//  Created by admin on 16/5/15.
//  Copyright © 2016年 saltchen. All rights reserved.
//

import UIKit
import CoreData


//NSFetcchedResultsController为监控tableView中数据的变化，并实时进行更新，但必须遵守其协议
class restaurantTableViewController: UITableViewController,NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var restaurants:[Restaurant] = []
    
    //搜索控制器
    var searchB: UISearchController!
    //添加一个餐馆数组，以保存搜索出来的数据
    var searchR:[Restaurant] = []
    
    var frc : NSFetchedResultsController!

    //更新搜索结果
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        //对于搜索条的可选绑定
        if var textToSearch = searchB.searchBar.text {
            //对于搜索内容进行简单的整理，去除空格和换行标识符
            textToSearch = textToSearch.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            searchFilter(textToSearch)
            tableView.reloadData()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化搜索条
        searchB = UISearchController(searchResultsController: nil)
        //将搜索条添加到头部
        tableView.tableHeaderView = searchB.searchBar
        
        //搜索框状态的设计
        //1.占位符
        searchB.searchBar.placeholder = "请输入搜索内容..."
        
        //4.搜索框类型，有3种状态.defaul .prominent
        searchB.searchBar.searchBarStyle = .Minimal
        //2.前景色
        // searchB.searchBar.tintColor = UIColor.whiteColor()
        //3.背景色
        // searchB.searchBar.barTintColor = UIColor.orangeColor()
        
        //这个原因你需要去你解决！！！
        //tableView.rowHeight = UITableViewAutomaticDimension
        //行高为80
        tableView.estimatedRowHeight = 80
        
        //搜索代理实现,搜索状态的设置
        searchB.searchResultsUpdater = self
        searchB.dimsBackgroundDuringPresentation = false
        
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        //请求哪一个实体
        let request = NSFetchRequest(entityName: "Restaurant")
        //tableView中的排序
        let sd = NSSortDescriptor(key: "name", ascending: true)
        //添加到排序数组中
        request.sortDescriptors = [sd]
        
        //获取缓冲区
        let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        //给frc进行初始化
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: buffer!, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        do {
            
            //执行查询语句
            try frc.performFetch()
            //把取回结果强制转换为Restaurant
            
            restaurants = frc.fetchedObjects as! [Restaurant]
        } catch {
            print(error)
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    //在加载数据之前，添加引导页面
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //创建defaults对象
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //判断点击数据是否存在
        if defaults.boolForKey("guiderShow"){
            
            return
        }
       
        
        if let pageVc = storyboard?.instantiateViewControllerWithIdentifier("GuiderController") as? GuiderPageViewController {
            
            //模态展现分页控制器
            presentViewController(pageVc, animated: true, completion: nil)
        }

        
    }
    
    //搜索方法的实现方法
    func searchFilter(textToSearch:String){
        searchR = restaurants.filter({ (r) -> Bool in
            return r.name.containsString(textToSearch)
        })
        
    }
    //由于实现NSFetchedResultsControllerDelegate协议，实现了以下3个方法，tableView开始刷新操作
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    //tableVies结束刷新操作
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    //tableVies刷新中的一些操作
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let _newindexPath = newIndexPath {
                
                tableView.insertRowsAtIndexPaths([_newindexPath], withRowAnimation: .Automatic)
                
            }
        case .Delete:
            if let _indexPath = indexPath {
                
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Automatic)
            }
            
        case .Update:
            if let _indexPath = indexPath {
                
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Automatic)
            }
        default:
            tableView.reloadData()
        }
        //将取出的数据转换成Restaurant数组中的对象，然后赋值
        restaurants = controller.fetchedObjects as! [Restaurant]    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchB.active ? searchR.count : restaurants.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RestaurantdetailTableViewCell
        
        
        //定义一个常量r，用于区分tableView的两种状态
        
        let r = searchB.active ? searchR[indexPath.row]:restaurants[indexPath.row]
        // Configure the cell...
        cell.imageViewx.image = UIImage(data:  r.image!)
        cell.nameLabel.text = r.name
        cell.typeLabel.text = r.type
        cell.locationLabel.text = r.location
        
        cell.imageViewx.layer.cornerRadius = cell.imageViewx.frame.size.width / 2
        
        cell.imageViewx.clipsToBounds = true
        
        cell.accessoryType = r.isVisited.boolValue ? .Checkmark : .None
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return !searchB.active
    }
    
    
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
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let 分享行为 = UITableViewRowAction(style: .Default, title: "分享") { (action, indexPath) -> Void in
            
            let alert = UIAlertController(title: "分享到",message: "请选择您要分享的社交类型", preferredStyle: .ActionSheet)
            
            //let weixinAction = UIAlertAction(title: "微信",style: .Default, handler:nil)
            
            
            let weixinAction = UIAlertAction(title: "微信", style: .Default ,handler: { (_) -> Void in
                let url = NSURL(string: "https://wx.qq.com/")
                    
                    UIApplication.sharedApplication().openURL(url!)
            })
            
            let weiboAction = UIAlertAction(title: "微博",style: .Default, handler: { (_) -> Void in
                let url = NSURL(string: "http://weibo.com/")
                
                UIApplication.sharedApplication().openURL(url!)
                })
            
            let 取消 = UIAlertAction(title: "取消分享",style: .Cancel, handler: nil)
            
            alert.addAction(weixinAction)
            alert.addAction(weiboAction)
            alert.addAction(取消)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        分享行为.backgroundColor = UIColor.greenColor()
        
        let 删除行为  = UITableViewRowAction(style: .Default, title: "删除") { (action, indexPath) -> Void in
            
            //由于数据方式是采用coreData方式，所以删除行为必须是删除coreData中的数据然后进行更新操作,先获取缓冲区
            let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
            
            //将选中的对象进行转换成实体对象
            let restaurantDel = self.frc.objectAtIndexPath(indexPath) as? Restaurant
            
            buffer?.deleteObject(restaurantDel!)
            
            do {
                
                try buffer?.save()
            }catch{
                
                print(error)
            }
            
            
            
            /*******
             类对象产生的删除行为
             self.restaurants.removeAtIndex(indexPath.row)
             tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
             
             */
            /*
             数组产生的删除行为
             
             self.餐馆.removeAtIndex(indexPath.row)
             self.餐馆图片.removeAtIndex(indexPath.row)
             self.餐馆地点.removeAtIndex(indexPath.row)
             self.餐馆类型.removeAtIndex(indexPath.row)
             self.去过的餐馆.removeAtIndex(indexPath.row)
             */
            
        }
        
        
        return [分享行为, 删除行为]
    }
    
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
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "SZFood" {
            let destVC = segue.destinationViewController as! ResDetailTableViewController
            
            destVC.restaurant = searchB.active ? searchR[(tableView.indexPathForSelectedRow!.row)]: restaurants[(tableView.indexPathForSelectedRow!.row)]
            
        }
        
        
    }
 
    @IBAction func unWindowHome(segue:UIStoryboardSegue){
    
    }
}
