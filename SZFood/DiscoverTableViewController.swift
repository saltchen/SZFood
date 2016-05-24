//
//  DiscoverTableViewController.swift
//  SZFood
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 saltchen. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UITableViewController {
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    var restaurants: [AVObject]  = []
    
    
    //更新操作，
    func  getNewData() {
    
        getRecordFromCloud(true)
    }
    //从云端取回数据的方法
    func getRecordFromCloud(needNew:Bool = false) {
    
        let query = AVQuery(className: "Restaurant")
        
        //刷新日期排序
        query.orderByDescending("createdAt")
        
        //判断是否需要更新
        if needNew {
        query.cachePolicy = .IgnoreCache
        }else  {
        
        //离线缓冲机制，查询缓冲
        query.cachePolicy = .CacheElseNetwork
        //三分钟查询一次
        query.maxCacheAge = 60*3
        }
        
        
       
        
        if query.hasCachedResult(){
        
            print("从缓冲中查询数据")
        }
        
        query.findObjectsInBackgroundWithBlock { (objects, e) in
            
            guard e == nil else {
            
                print(e.localizedDescription)
                return
            }
            
            if let objects = objects as? [AVObject] {
            
                self.restaurants = objects
                
                //将tableView刷新操作放入到主线程中
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    
                    self.tableView.reloadData()
                    
                    self.spinner.stopAnimating()
                    
                    //下拉刷新操作停止小菊花
                    
                    self.refreshControl?.endRefreshing()
                    
                    
                })
                
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRecordFromCloud()
        //下拉刷新
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.whiteColor()
        refreshControl?.tintColor = UIColor.grayColor()
        refreshControl?.addTarget(self, action: #selector(DiscoverTableViewController.getNewData), forControlEvents: .ValueChanged)
        
        
        
        //用户体验提升
        spinner.hidesWhenStopped = true
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        
       
    }

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
        return restaurants.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("discoverCell", forIndexPath: indexPath) as! DiscoverTableViewCell

        
        let restaurant = restaurants[indexPath.row]
        cell.nameD.text = restaurant["name"] as? String
        cell.typeD.text = restaurant["type"] as? String
        //延迟加载图片，优选显示文字，以防用户网络情况不好的情况下，后面显示图片
        //图像的占位
        cell.imageViewd.image = UIImage(named: "photoalbum")
        
        if let img = restaurant["image"] as? AVFile {
            
            //图片延时加载具体操作
            img.getDataInBackgroundWithBlock({ (data, e) in
                
                guard e == nil  else{
                
                    print(e)
                    return
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                     cell.imageViewd.image = UIImage(data: data)
                })
                
                
            })
        
           
        }

        return cell
    }
 

   

   
   
}
