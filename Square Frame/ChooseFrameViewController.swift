//
//  ChooseFrameViewController.swift
//  Square Frame
//
//  Created by Hutch on 22/07/19.
//  Copyright © 2019 Hutch. All rights reserved.
//

import UIKit
import Photos
import BSImagePicker

class ChooseFrameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  var imageArray = [URL]()
  fileprivate var imageAssets = [PHAsset]()
  
  //MARK:- IBOutlet
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = false
    self.navigationItem.backBarButtonItem?.title = "Back"
    isAllPurchase = false
    collectionView.reloadData()
    
    if isFrame == true
    {
      self.navigationItem.title = "Choose Frame"
    }
    else if isGlitter == true
    {
      self.navigationItem.title = "Choose Glitter"
    }
    else if isShape == true
    {
      self.navigationItem.title = "Choose Shape"
    }
  }
  
  
  //MARK:- CollectionView Delegate, Datasource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if isFrame == true
    {
      return thumbnilsArray.count
    }
    else if isGlitter == true
    {
      return glittersThumbArray.count
    }
    else if isShape == true
    {
      return shapeThumbArray.count
    }
    else
    {
      return thumbnilsArray.count
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let frameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChooseFrameCollectionViewCell", for: indexPath) as? ChooseFrameCollectionViewCell
    if isAllPurchase == true
    {
      frameCell?.crownImage.isHidden = true
      if isFrame == true
      {
        frameCell?.frameImage.image = UIImage(named: thumbnilsArray[indexPath.item])
      }
      else if isGlitter == true
      {
        frameCell?.frameImage.image = UIImage(named: glittersThumbArray[indexPath.item])
      }
      else if isShape == true
      {
        frameCell?.frameImage.image = UIImage(named: shapeThumbArray[indexPath.item])
      }
      
    } else {
      
      if (indexPath.item>5)
      {
        frameCell?.crownImage.isHidden = false
        if isFrame == true
        {
          frameCell?.frameImage.image = UIImage(named: thumbnilsArray[indexPath.item])
        }
        else if isGlitter == true
        {
          frameCell?.frameImage.image = UIImage(named: glittersThumbArray[indexPath.item])
        }
        else if isShape == true
        {
          frameCell?.frameImage.image = UIImage(named: shapeThumbArray[indexPath.item])
        }
      }
      else
      {
        frameCell?.crownImage.isHidden = true
        if isFrame == true
        {
          frameCell?.frameImage.image = UIImage(named: thumbnilsArray[indexPath.item])
        }
        else if isGlitter == true
        {
          frameCell?.frameImage.image = UIImage(named: glittersThumbArray[indexPath.item])
        }
        else if isShape == true
        {
          frameCell?.frameImage.image = UIImage(named: shapeThumbArray[indexPath.item])
        }
      }
    }
    return frameCell!
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if isAllPurchase == true
    {
      targetItem(index: indexPath.item)
    }
    else
    {
      if (indexPath.item<6) {
        targetItem(index: indexPath.item)
      }
    }
  }
   
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if isFrame == true
    {
        let width = (self.view.frame.width - 20) / 3
        let height = (self.view.frame.width - 20) / 2
      return CGSize(width: width, height: height)
      
    }
    else
    {
      let width = (self.view.frame.width - (5 * 5)) / 3
      let height = (self.view.frame.width - (5 * 5)) / 3
      return CGSize(width: width, height: height)
      
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
  {
    return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
  {
    return  5
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return  0
  }
  
  //MARK:- PHAssets
  func convertImageFromAsset(asset: PHAsset) -> UIImage {
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    var image = UIImage()
    option.isSynchronous = true
    manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
      image = result!
    })
    return image
  }
  
  
  func getUrlFromPHAsset(asset: PHAsset, callBack: @escaping (_ url: URL?) -> Void)
  {
    asset.requestContentEditingInput(with: PHContentEditingInputRequestOptions(), completionHandler: { (contentEditingInput, dictInfo) in
      
      if let strURL = (contentEditingInput!.fullSizeImageURL)?.absoluteString
      {
        print("Image URL: \(strURL)")
        callBack(URL.init(string: strURL))
      }
    })
  }
  
  //Mark:- target
  func targetItem(index: Int) {
    
    let vc = BSImagePickerViewController()
    if isFrame == true
    {
      vc.maxNumberOfSelections = 2
      
    } else {
      vc.maxNumberOfSelections = 1
    }
    bs_presentImagePickerController(vc, animated: true,
                                    select: { (asset: PHAsset) -> Void in
                                      print("Selected: \(asset)")
    }, deselect: { (asset: PHAsset) -> Void in
      print("Deselected: \(asset)")
    }, cancel: { (assets: [PHAsset]) -> Void in
      print("Cancel: \(assets)")
    }, finish: { (assets: [PHAsset]) -> Void in
      print("Finish: \(assets)")
      
      self.imageArray.removeAll()
      
      if isFrame == true
      {
        if assets.count == 2
        {
          for imageAsset in assets
          {
            self.getUrlFromPHAsset(asset: imageAsset)
            { (url) in
              
              if let url = url
              {
                print(url)
                self.imageArray.append(url)
              }
            }
          }
          
        } else
        {
          let alert = UIAlertController(title: "", message: "please select two image", preferredStyle: .alert)
          
          let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
          })
          alert.addAction(ok)
          self.present(alert, animated: true)
          
        }
      } else
      {
        if assets.count == 1
        {
          for imageAsset in assets
          {
            self.getUrlFromPHAsset(asset: imageAsset)
            { (url) in
              
              if let url = url
              {
                print(url)
                self.imageArray.append(url)
              }
            }
          }
        }
      }
      DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + Double(1.0))
      {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "PhotoFrameViewController") as! PhotoFrameViewController
        if isFrame == true
        {
          let image = UIImage(named: frameImageArray[index])
          viewController.receiveImage = image
          viewController.frameData = frameDataArray[index]
        }
        else if isGlitter == true
        {
          let image = UIImage(named: glittersArray[index])
          viewController.receiveImage = image
        }
        else if isShape == true
        {
          let image = UIImage(named: shapeImageArray[index])
          viewController.receiveImage = image
        }
        viewController.imageUrls.removeAll()
        viewController.imageUrls = self.imageArray
        self.navigationController?.pushViewController(viewController, animated: true)
      }
      
    }, completion: nil)
  }
  
}










