//
//  MapViewController.swift
//  SZFood
//
//  Created by admin on 16/5/15.
//  Copyright © 2016年 saltchen. All rights reserved.
//
import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        //功能是否添加
        mapView.showsTraffic = true
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsBuildings = true
        
        //将精度纬度什么的进行转换
        
        let geocoder = CLGeocoder()
    
         geocoder.geocodeAddressString(restaurant.location) { (placemarks, error) -> Void in
           if error != nil {
                
                print(error)
                return
            }
 
            
            if let placemarks = placemarks {
                
                let placemark = placemarks[0]
                
                //创建标记点,并给与赋值
                let annotion = MKPointAnnotation()
                annotion.title = self.restaurant.name
                annotion.subtitle = self.restaurant.type
                
                //标记点显示的位置

                
                if let location = placemark.location {
                    
                    annotion.coordinate = location.coordinate
                    
                    self.mapView.showAnnotations([annotion], animated: true)
                    self.mapView.selectAnnotation(annotion, animated: true)
 
 
                }
                
 
                
            }
            
        }
 
        // Do any additional setup after loading the view.
    }
    
    //定制标注视图
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let id = "我的图钉"
        
        if annotation is MKUserLocation {
            
            return nil
        }
        
        //考虑可重用标注视图
        
        var annotationView = self.mapView.dequeueReusableAnnotationViewWithIdentifier(id) as? MKPinAnnotationView
        
        if annotationView == nil {
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        leftIconView.image = UIImage(data: restaurant.image!)
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        annotationView?.pinTintColor = UIColor.greenColor()
        
        return annotationView
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    
}
