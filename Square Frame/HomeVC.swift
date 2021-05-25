//
//  HomeVC.swift
//  Square Frame
//
//  Created by Hutch on 29/07/19.
//

import UIKit

class HomeVC: UIViewController {
  
  //MARK:- IBOutlet
  @IBOutlet weak var frameBtn: UIButton!
  @IBOutlet weak var glittersBtn: UIButton!
  @IBOutlet weak var shapsBtn: UIButton!
  @IBOutlet weak var viewHeightCnst: NSLayoutConstraint!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var primimumBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    
    let viewHeight = ((containerView.bounds.height)/containerView!.bounds.width) * (UIScreen.main.bounds.width)
//    self.viewHeightCnst.constant = viewHeight
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = true
  }
  
  //MARK:- IBAction
  @IBAction func frameTappedBtn(_ sender: Any) {
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "ChooseFrameViewController") as! ChooseFrameViewController
    isFrame = true
    isGlitter = false
    isShape = false
    self.navigationController?.pushViewController(vc, animated: true)
    
  }
  
  
  @IBAction func glittersTappedBtn(_ sender: Any) {
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "ChooseFrameViewController") as! ChooseFrameViewController
    isFrame = false
    isShape = false
    isGlitter = true
    self.navigationController?.pushViewController(vc, animated: true)
    
    
  }
  
  @IBAction func shapesTappedBtn(_ sender: Any) {
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "ChooseFrameViewController") as! ChooseFrameViewController
    isFrame = false
    isShape = true
    isGlitter = false
    self.navigationController?.pushViewController(vc, animated: true)
    
  }
  
  
  @IBAction func primimumBtnTapped(_ sender: Any) {
    
  }
  
  
}



