//
//  ViewController.swift
//  map2018_12_06
//
//  Created by 岩男高史 on 2018/12/06.
//  Copyright © 2018 岩男高史. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,UITextFieldDelegate {

  @IBOutlet weak var textfield: UITextField!
  @IBOutlet weak var map: MKMapView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // textfieldのdelegate通知先を設定
    textfield.delegate = self
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //キーボードを閉じる
    textfield.resignFirstResponder()
    //検索窓で入力された内容を変数へ格納
    let searchKeyword = textfield.text
    print(searchKeyword!)
    //clgeocoderインスタンスを取得
    let geocoder = CLGeocoder()
    //入力された文字から位置情報を取得
    geocoder.geocodeAddressString(searchKeyword!) { (placemarks:[CLPlacemark]?, error:Error?) in
      //位置情報が存在する場合、１件目の位置情報をplacemarkに取り出す
      if let placemark = placemarks?[0] {
        //位置情報から緯度経度が存在する場合、緯度経度をtargetcoordinateに取り出す
        if let targetCoordinate = placemark.location?.coordinate {
          //緯度経度をデバックエリアに表示
          print(targetCoordinate)
          //MKPointannotationインスタンスを取得し、ピンを作成
          let pin = MKPointAnnotation()
          //ピンの置く場所に緯度経度を設定
          pin.coordinate = targetCoordinate
          //ピンのタイトルを設定
          pin.title = searchKeyword!
          //ピンを地図に置く
          self.map.addAnnotation(pin)
          //緯度経度を中心にして半径500mの範囲を表示
          self.map.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
        }
      }
    }
    return true
  }
  
  
  @IBAction func tapchangeButton(_ sender: UIButton) {
    //maptypeプロパティ値をトグル
    // 標準(.standard) 航空写真(.satellite) 航空写真＋標準(.hybrid)
    //3DFlyover(.satelliteFlyover) 3D Flyover + 標準(.hybridFlyover)
    if map.mapType == .standard {
      map.mapType = .satellite
    } else if map.mapType == .satellite {
      map.mapType = .hybrid
    } else if map.mapType == .hybrid {
      map.mapType = .satelliteFlyover
    } else if map.mapType == .satelliteFlyover {
      map.mapType = .hybridFlyover
    } else {
      map.mapType = .standard
    }
  }
  

}

