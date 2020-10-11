//
//  ViewController.swift
//  MapKitApp3
//
//  Created by miyazawaryohei on 2020/10/11.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {

    //地点の座標
    let loc1 = CLLocationCoordinate2D(latitude: 35.690553, longitude: 139.699579)
    let loc2 = CLLocationCoordinate2D(latitude: 35.531365, longitude: 139.696889)
    let loc3 = CLLocationCoordinate2D(latitude: 35.454954, longitude: 139.6313859)
    
    
    @IBOutlet var myMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = CLLocationCoordinate2D(latitude: 35.531365, longitude: 139.696889)
        let span = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
        let region = MKCoordinateRegion(center: center, span: span)
        myMap.setRegion(region, animated: true)
        myMap.delegate = self
        
        //座標の配列
        let locs = [loc1,loc2,loc3]
        //円を描く
        for loc in locs{
        let circle = MKCircle(center: loc, radius: 3000)
            myMap.addOverlay(circle)
        }
        //座標を線で結ぶ
        let line = MKPolyline(coordinates: locs, count: locs.count)
        myMap.addOverlay(line)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer:MKOverlayPathRenderer
        
        switch overlay {
        case is MKPolyline:
        //線を描くレンダラー
        renderer = MKPolygonRenderer(overlay: overlay)
            renderer.lineWidth = 2
            renderer.strokeColor = UIColor.blue
        case is MKCircle :
            renderer = MKCircleRenderer(circle: overlay as! MKCircle)
            renderer.lineWidth = 2
            renderer.strokeColor = UIColor.red
            renderer.fillColor = UIColor.red
            renderer.alpha = 0.3
        default :
           renderer = MKPolylineRenderer(overlay: overlay)
        }
        return renderer
    }

}

