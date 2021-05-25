//
//  Save&ShareVC.swift
//  Square Frame
//
//  Created by Hutch on 02/08/19.
//

import UIKit

class Save_ShareVC: UIViewController {
  
  // MARK:- IBOutlet
  @IBOutlet weak var footerContainerView: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var savePhotoBtn: UIButton!
  @IBOutlet weak var shareBtn: UIButton!
  @IBOutlet weak var whatsappBtn: UIButton!
  
  var getImage: UIImage?
  var documentInteractionController:UIDocumentInteractionController!
  
  //MARK:- LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.image = getImage
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationItem.title = "Save&Share"
  }
  
  @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
      // we got back an error!
      let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
    } else {
      let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
    }
  }
  
  //MARK:- IBAction
  @IBAction func savePhotoTapped(_ sender: Any) {
    UIImageWriteToSavedPhotosAlbum(getImage!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    
  }
  
  
  @IBAction func shareTapped(_ sender: Any) {
    
    let items = [""]
    let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
    present(ac, animated: true)
    
  }
  
  
  @IBAction func whatsappTapped(_ sender: UIButton) {
    
    let urlWhats = "whatsapp://app"
    if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed) {
      if let whatsappURL = URL(string: urlString) {
        if UIApplication.shared.canOpenURL(whatsappURL as URL) {
          if UIImage(named: "whatsappIcon") != nil {
            if let imageData = getImage!.jpegData(compressionQuality: 0.75) {
              let tempFile = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/whatsAppTmp.wai")
              do {
                try imageData.write(to: tempFile, options: .atomic)
                self.documentInteractionController = UIDocumentInteractionController(url: tempFile)
                self.documentInteractionController.uti = "net.whatsapp.image"
                self.documentInteractionController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)
                
              } catch {
                print(error)
              }
            }
          }
        } else {
          
          let alert = UIAlertController(title: "", message: "can't open whatsapp", preferredStyle: .alert)
          
          let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
          })
          alert.addAction(ok)
          self.present(alert, animated: true)
          
        }
      }
    }
  }
  
  
}


