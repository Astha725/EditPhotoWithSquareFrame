

import UIKit
import AssetsLibrary
import BSImagePicker
import Photos
import CoreImage
import RCStickerView

class PhotoFrameViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate {
  
  // MARK:- Outlet
  @IBOutlet weak var containtView: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var viewHeight: NSLayoutConstraint!
  @IBOutlet weak var filterBtn: UIButton!
  @IBOutlet weak var rotateBtn: UIButton!
  @IBOutlet weak var stickerBtn: UIButton!
  @IBOutlet weak var doneBtn: UIButton!
  @IBOutlet weak var categoryBtn: UIButton!
  @IBOutlet weak var footerView: UIView!
  @IBOutlet weak var filterContaintView: UIView!
  @IBOutlet weak var filterScrollView: UIScrollView!
  @IBOutlet weak var rotateContaintView: UIView!
  @IBOutlet weak var stickerContaintView: UIView!
  @IBOutlet weak var categoryContaintView: UIView!
  @IBOutlet weak var stickerScrollView: UIScrollView!
  @IBOutlet weak var categoryScrollView: UIScrollView!
  @IBOutlet weak var footerHeightCnst: NSLayoutConstraint!
  @IBOutlet weak var footerBottomCnst: NSLayoutConstraint!
  @IBOutlet weak var filterViewBottomCnst: NSLayoutConstraint!
  @IBOutlet weak var rotateViewBottomCnst: NSLayoutConstraint!
  @IBOutlet weak var stickerViewBottomCnst: NSLayoutConstraint!
  @IBOutlet weak var categoryViewBottomCnst: NSLayoutConstraint!
  @IBOutlet weak var colorContainerView: UIView!
  @IBOutlet weak var colorScrollView: UIScrollView!
  @IBOutlet weak var colorBottomViewCnst: NSLayoutConstraint!
  
  //MARK:- Create Object
  var myStickerView = UIView()
  var mystickerImage = UIImageView()
  var mystickerRotateBtn = UIButton()
  var mystickerCanclBtn = UIButton()
  var lockButton = UIButton()
  var scroll = UIScrollView()
  var view1 = UIView()
  var view2 = UIView()
  var firstView = UIView()
  var firstImage = UIImageView()
  var secondView = UIView()
  var secondImage = UIImageView()
  var isFirstimage = Bool()
  var isFirstFilterimage = Bool()
  var receiveImage: UIImage?
  var imageUrls = [URL]()
  var frameData = [[String:String]]()
  var image1 = UIImage()
  var image2 = UIImage()
  
  fileprivate var assets = [PHAsset]()
  
  let imagePicker = UIImagePickerController()
  var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
  var viewController: UIViewController?
  var pickImageCallback : ((UIImage) -> ())?
  
  var lockFilterArray = [UIButton]()
  var myStickerViewArray = [UIView]()
  var mycategoryArray = [UIImageView]()
  var stikerCncleBtnArray = [UIButton]()
  var stikerImageBrdrArray = [UIImageView]()
  var flipped = Bool()
  var context: CIContext!
  var currentFilter: CIFilter!
  let ciContext = CIContext(options: nil)
  
  // MARK:- Count
  var stickerViewCount = 100
  var filterScrollViewCount = 200
  var rotateScrollViewCount = 300
  var stickerScrollViewCount = 400
  var categoryScrollViewCount = 500
  var colorScrollViewCount = 600
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imagePicker.delegate = self
    imageView.image = receiveImage
    let imageHeight = ((receiveImage?.size.height)!/receiveImage!.size.width) * (UIScreen.main.bounds.width)
    self.viewHeight.constant = imageHeight
    
    DispatchQueue.main.async {
      if isFrame == true
      {
        self.viewFrame1()
        self.viewFrame2()
        self.containtView.bringSubviewToFront(self.imageView)
      } else
      {
        self.viewFrame1()
        self.containtView.bringSubviewToFront(self.imageView)
      }
    }
    
    isAllPurchase = false
    viewShadow()
    RecogniseGesture()
    filterLoadScrollView()
    stickerLoadScrollView()
    categoryLoadScrollView()
    colorLoadScrollView()
    
    context = CIContext()
    currentFilter = CIFilter(name: "CISepiaTone")
    
    if isFrame == true
    {
      categoryBtn.setBackgroundImage(UIImage(named: "frameBtn"), for: .normal)
      self.colorBottomViewCnst.constant = -200
    } else if isGlitter == true
    {
      categoryBtn.setBackgroundImage(UIImage(named: "glitterBtn"), for: .normal)
      self.colorBottomViewCnst.constant = -200
      
    } else if isShape == true
    {
      categoryBtn.setBackgroundImage(UIImage(named: "shape"), for: .normal)
      
    }
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationItem.title = "Edit Photo"
    self.navigationItem.backBarButtonItem?.title = "Back"
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    
  }
  
  func viewShadow() {
    containtView.clipsToBounds = true
    footerView.layer.shadowColor = UIColor.lightGray.cgColor
    footerView.layer.shadowOpacity = 1
    footerView.layer.shadowOffset = CGSize.zero
    footerView.layer.shadowRadius = 2
    
  }
  
  // MARK:- Gesture function
  // rotate
  @objc func rotate() {
    if imageView.transform == .identity {
      UIView.animate(withDuration: 0.5) {
        self.imageView.transform = CGAffineTransform(rotationAngle: (CGFloat.pi)/2)
      }
      
      UIView.animate(withDuration: 0.5, delay: 0.25, options:[], animations: {
        self.imageView.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
      }, completion: nil)
      
    } else {
      UIView.animate(withDuration: 0.5, animations: {
        self.imageView.transform = .identity
      })
    }
  }
  
  // pinch
  @objc func pinchHandler1(recognizer : UIPinchGestureRecognizer) {
    if let view = recognizer.view {
      
      view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
      recognizer.scale = 1
    }
    
  }
  
  // RotateGesture
  @objc func rotateGesture1(sender: UIRotationGestureRecognizer) {
    sender.view?.transform = (sender.view?.transform)!.rotated(by: sender.rotation)
    sender.rotation = 0
  }
  
  //  tapGesture
  @objc func doublehandleTap1(_ sender: UITapGestureRecognizer)
  {
    isFirstimage = true
    self.openCamera(UIImagePickerController.SourceType.photoLibrary)
  }
  
  @objc func doublehandleTap2(_ sender: UITapGestureRecognizer)
  {
    isFirstimage = false
    self.openCamera(UIImagePickerController.SourceType.photoLibrary)
  }
  
  @objc func singlehandleTap1(_ sender: UITapGestureRecognizer)
  {
    isFirstFilterimage = false
  }
  
  @objc func singlehandleTap2(_ sender: UITapGestureRecognizer)
  {
    isFirstFilterimage = true
    
  }
  
  // panGesture
  @objc private func handlePanGesture1(sender:UIPanGestureRecognizer)
  {
    if sender.state == .began || sender.state == .changed
    {
      let point = sender.location(in: self.view1)
      if let superview = self.view1 as? UIView
      {
        let restrictByPoint : CGFloat = 40.0
        let superBounds = CGRect(x: superview.bounds.origin.x + restrictByPoint, y: superview.bounds.origin.y + restrictByPoint, width: superview.bounds.size.width - 2*restrictByPoint, height: superview.bounds.size.height - 2*restrictByPoint)
        if (superBounds.contains(point))
        {
          let translation = sender.translation(in: self.view1)
          sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
          sender.setTranslation(CGPoint.zero, in: self.view1)
        }
      }
    }
  }
  
  @objc private func handlePanGesture2(sender:UIPanGestureRecognizer)
  {
    if sender.state == .began || sender.state == .changed
    {
      let point = sender.location(in: self.view2)
      if let superview = self.view2 as? UIView
      {
        let restrictByPoint : CGFloat = 40.0
        let superBounds = CGRect(x: superview.bounds.origin.x + restrictByPoint, y: superview.bounds.origin.y + restrictByPoint, width: superview.bounds.size.width - 2*restrictByPoint, height: superview.bounds.size.height - 2*restrictByPoint)
        if (superBounds.contains(point))
        {
          let translation = sender.translation(in: self.view2)
          sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
          sender.setTranslation(CGPoint.zero, in: self.view2)
        }
      }
    }
  }
  
  // MARK:- scrollView zooming
  func setZoomScale() {
    scroll.minimumZoomScale = 1.0
    scroll.maximumZoomScale = 6.0
    
  }
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.firstImage
  }
  
  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    
    let imageViewSize = imageView.frame.size
    let scrollViewSize = scrollView.bounds.size
    let verticalInset = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
    let horizontalInset = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
    scrollView.contentInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
  }
  
  //MARK:- imagePicker
  func openCamera(_ sourceType: UIImagePickerController.SourceType) {
    imagePicker.sourceType = sourceType
    self.present(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let imge = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    
    if isFirstimage == true
    {
      firstImage.image = imge
      self.image1 = imge!
    } else
    {
      secondImage.image = imge
      self.image2 = imge!
    }
    
    imagePicker.dismiss(animated: true, completion: nil)
  }
  
  // MARK:- gesture target
  func RecogniseGesture() {
    
    // tapGesture
    let firstTap = UITapGestureRecognizer(target: self, action: #selector(self.doublehandleTap1(_:)))
    firstTap.numberOfTapsRequired = 2
    firstTap.delegate = self
    firstImage.addGestureRecognizer(firstTap)
    
    let secondTap = UITapGestureRecognizer(target: self, action: #selector(self.doublehandleTap2(_:)))
    secondTap.numberOfTapsRequired = 2
    secondTap.delegate = self
    secondImage.addGestureRecognizer(secondTap)
    
    let firstFilterTap = UITapGestureRecognizer(target: self, action: #selector(self.singlehandleTap1(_:)))
    firstFilterTap.delegate = self
    firstImage.addGestureRecognizer(firstFilterTap)
    
    let secondFilterTap = UITapGestureRecognizer(target: self, action: #selector(self.singlehandleTap2(_:)))
    secondFilterTap.delegate = self
    secondImage.addGestureRecognizer(secondFilterTap)
    
    //panGesture, pinchgesture, rotateRecognizer
    if isFrame == true {
      let panGesture1 = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture1))
      panGesture1.delegate = self
      self.firstImage.addGestureRecognizer(panGesture1)
      
      let panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture2))
      panGesture2.delegate = self
      self.secondImage.addGestureRecognizer(panGesture2)
      
      //pinchgesture
      self.firstImage.isMultipleTouchEnabled = true
      let pinchGestureRecognizer1 = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandler1))
      pinchGestureRecognizer1.delegate = self
      self.firstImage.addGestureRecognizer(pinchGestureRecognizer1)
      
      self.secondImage.isMultipleTouchEnabled = true
      let pinchGestureRecognizer2 = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandler1))
      pinchGestureRecognizer2.delegate = self
      self.secondImage.addGestureRecognizer(pinchGestureRecognizer2)
      
      //rotateRecognizer
      let rotateRecognizer1 = UIRotationGestureRecognizer(target: self, action: #selector(self.rotateGesture1))
      rotateRecognizer1.delegate = self
      firstImage.addGestureRecognizer(rotateRecognizer1)
      
      let rotateRecognizer2 = UIRotationGestureRecognizer(target: self, action: #selector(self.rotateGesture1))
      secondImage.addGestureRecognizer(rotateRecognizer2)
      rotateRecognizer2.delegate = self
      
    }
  }
  
  func  viewFrame1() {
    firstImage.isUserInteractionEnabled = true
    image1 =  UIImage(contentsOfFile: imageUrls[0].path)!
    firstImage.contentMode = .scaleAspectFit
    if isFrame == true
    {
      firstImage.image = image1
      let image1FrameData = frameData[0]
      let x1 = image1FrameData["x"]
      let y1 = image1FrameData["y"]
      let w1 = image1FrameData["width"]
      let h1 = image1FrameData["height"]
      let mywidth = UIScreen.main.bounds.width
      let myheight = self.viewHeight.constant
      let frame1 = CGRect(x: Int(x1!)!, y: Int(y1!)!, width: Int(w1!)!, height: Int(h1!)!)
      let newFrame1 = CGRect(x : (frame1.origin.x*mywidth)/700, y:(frame1.origin.y*myheight)/900, width : (frame1.size.width*mywidth)/700, height : (frame1.size.height*myheight)/900)
      view1.frame = newFrame1
      firstImage.frame = CGRect(x: 0, y: 0, width: self.view1.bounds.size.width, height: self.view1.bounds.size.height)
      view1.clipsToBounds = true
      
      self.view1.addSubview(firstImage)
      self.containtView.addSubview(view1)
    } else
    {
      firstImage.image = image1
      scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: viewHeight.constant))
      
      let imageHeight = ((image1.size.height)/image1.size.width) * (UIScreen.main.bounds.width)
      
      if (imageHeight < UIScreen.main.bounds.size.width)
      {
        
        firstImage.frame = CGRect(x: 0, y: 0, width: ((self.image1.size.width)/(self.image1.size.height))*viewHeight.constant, height: viewHeight.constant)
      }
      else
      {
        
        firstImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: ((self.image1.size.height)/(self.image1.size.width)*UIScreen.main.bounds.size.width))
      }
      
      let scrollContentSize = CGSize(width: UIScreen.main.bounds.size.width, height: ((self.image1.size.height)/(self.image1.size.width))*UIScreen.main.bounds.size.width)
      
      firstImage.center = CGPoint(x: scroll.bounds.size.width/2, y: scroll.bounds.size.height/2)
      self.scroll.contentMode = .scaleAspectFill
      scroll.contentSize = scrollContentSize
      scroll.delegate = self
      scroll.showsVerticalScrollIndicator = false
      scroll.showsHorizontalScrollIndicator = false
      scroll.alwaysBounceHorizontal = true
      scroll.alwaysBounceVertical = true
      self.scroll.addSubview(firstImage)
      self.containtView.addSubview(scroll)
      self.containtView.bringSubviewToFront(self.imageView)
      setZoomScale()
    
    }
  }
  
  func viewFrame2() {
    secondImage.isUserInteractionEnabled = true
    image2 =  UIImage(contentsOfFile: imageUrls[1].path)!
    secondImage.contentMode = .scaleAspectFit
    secondImage.image = image2
    let image2FrameData = frameData[1]
    let x2 = image2FrameData["x"]
    let y2 = image2FrameData["y"]
    let w2 = image2FrameData["width"]
    let h2 = image2FrameData["height"]
    let mywidth = UIScreen.main.bounds.width
    let myheight = self.viewHeight.constant
    let frame2 = CGRect(x: Int(x2!)!, y: Int(y2!)!, width: Int(w2!)!, height: Int(h2!)!)
    let newFrame2 = CGRect(x : (frame2.origin.x*mywidth)/700, y:(frame2.origin.y*myheight)/900, width : (frame2.size.width*mywidth)/700, height : (frame2.size.height*myheight)/900)
    view2.frame = newFrame2
    print("frme2==",image2FrameData)
    secondImage.frame = CGRect(x: 0, y: 0, width: self.view2.bounds.size.width, height: self.view2.bounds.size.height)
    self.view2.addSubview(secondImage)
    self.containtView.addSubview(view2)
    view2.clipsToBounds = true
  }
  
  
  // MARK:- Filter
  func filterLoadScrollView()
  {
    var xCoord: CGFloat = 5
    let yCoord: CGFloat = 5
    let buttonWidth:CGFloat = 45.0
    let buttonHeight: CGFloat = 60.0
    let gapBetweenButtons: CGFloat = 5
    
    for i in 0..<filterThumbArray.count{
      filterScrollViewCount = i
      // Button properties
      let btn = UIButton(type: .custom)
      btn.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
      btn.tag = filterScrollViewCount
      btn.showsTouchWhenHighlighted = true
      btn.setBackgroundImage(UIImage(named: filterThumbArray[filterScrollViewCount]), for: .normal)
      btn.addTarget(self, action: #selector(filterbuttonAction), for: .touchUpInside)
      btn.layer.cornerRadius = 2
      btn.clipsToBounds = true
      
      lockButton = UIButton(frame: CGRect(x: btn.bounds.width-25, y: 0, width: 25, height: 12))
      lockButton.setImage(UIImage(named: "pro"), for: .normal)
      self.lockButton.addTarget(self, action:#selector(self.lockfilterbuttonAction), for: .touchUpInside)
      lockButton.tag = filterScrollViewCount
      lockButton.showsTouchWhenHighlighted = true
      lockButton.isUserInteractionEnabled = true
      filterScrollView.addSubview(btn)
      
      if isAllPurchase == true
      {
        print("ffd")
      }
      else
      {
        if (i>3)
        {
          btn.addSubview(lockButton)
        }
      }
        xCoord +=  buttonWidth + gapBetweenButtons
    }
    filterScrollView.contentSize = CGSize(width: (buttonWidth + gapBetweenButtons) * CGFloat(filterScrollViewCount+1), height: yCoord)
    
  }
  
  @objc func lockfilterbuttonAction(sender: UIButton!)
  {
    
  }
  
  @objc func filterbuttonAction(sender: UIButton!)
  {
    let indexNo = sender.tag
    if isAllPurchase == true {
      applyFilter(index: sender.tag)
    }
    else
    {
      if (indexNo<4) {
        applyFilter(index: sender.tag)
      }
    }
  }
  
  
  // MARK:- Sticker
  func stickerLoadScrollView()
  {
    var xCoord: CGFloat = 5
    let yCoord: CGFloat = 12
    let buttonWidth:CGFloat = 45.0
    let buttonHeight: CGFloat = 45.0
    let gapBetweenButtons: CGFloat = 8
    
    for i in 0..<stickerArray.count{
      stickerScrollViewCount = i
      // Button properties
      let btn = UIButton(type: .custom)
      btn.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
      btn.tag = stickerScrollViewCount
      btn.showsTouchWhenHighlighted = true
      btn.setBackgroundImage(UIImage(named: stickerArray[stickerScrollViewCount]), for: .normal)
      btn.addTarget(self, action: #selector(stickerbuttonAction), for: .touchUpInside)
      btn.layer.cornerRadius = 5
      btn.clipsToBounds = true
      xCoord +=  buttonWidth + gapBetweenButtons
      stickerScrollView.addSubview(btn)
    }
    stickerScrollView.contentSize = CGSize(width: (buttonWidth + gapBetweenButtons) * CGFloat(stickerScrollViewCount+1), height: yCoord)
    
  }
  
  @objc func stickerbuttonAction(sender: UIButton!) {
    
    let indexNo = sender.tag
    
    let screenSize: CGRect = UIScreen.main.bounds
    myStickerView = UIView(frame: CGRect(x: screenSize.size.width/3, y: screenSize.size.height/3, width: 130, height: 130))
    myStickerView.isUserInteractionEnabled = true
    myStickerView.tag = stickerViewCount
    
    mystickerImage = UIImageView(frame: CGRect(x: 10, y: 10, width: myStickerView.bounds.width - 20, height: myStickerView.bounds.height - 20))
    mystickerImage.image = UIImage(named: stickerArray[indexNo])
    mystickerImage.contentMode = .scaleAspectFit
    mystickerImage.layer.borderWidth = 1.5
    mystickerImage.layer.borderColor = UIColor.black.cgColor
    mystickerImage.clipsToBounds = true
    mystickerImage.tag = stickerViewCount
    
    mystickerCanclBtn = UIButton(frame: CGRect(x: self.myStickerView.bounds.width-20, y: -10, width: 30, height: 30))
    mystickerCanclBtn.setImage(UIImage(named: "cancel"), for: .normal)
    mystickerRotateBtn.isUserInteractionEnabled = true
    self.mystickerCanclBtn.addTarget(self, action:#selector(self.stickerCancleBtn), for: .touchUpInside)
    mystickerCanclBtn.tag = stickerViewCount
    mystickerCanclBtn.showsTouchWhenHighlighted = true
    mystickerCanclBtn.isUserInteractionEnabled = true
    self.containtView.addSubview(myStickerView)
    myStickerView.addSubview(mystickerImage)
    myStickerView.addSubview(mystickerCanclBtn)
    myStickerViewArray.append(myStickerView)
    stikerCncleBtnArray.append(mystickerCanclBtn)
    stikerImageBrdrArray.append(mystickerImage)
    stickerGesture()
    stickerViewCount += 1
    
  }
  
  @objc func stickerCancleBtn(sender: UIButton){
    let removeView = sender.tag
    for stView in myStickerViewArray {
      if stView.tag == removeView
      {
        stView.removeFromSuperview()
      }
    }
  }
  
  // MARK:- Category Action Frame, Shapes,Glitter
  func categoryLoadScrollView()
  {
    var xCoord: CGFloat = 5
    let buttonWidth:CGFloat = 45.0
    let gapBetweenButtons: CGFloat = 5
    
    if isFrame == true {
      let yCoord: CGFloat = 5
      let buttonHeight: CGFloat = 58.0
      for i in 0..<thumbnilsArray.count{
        categoryScrollViewCount = i
        // Button properties
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
        btn.tag = categoryScrollViewCount
        btn.showsTouchWhenHighlighted = true
        btn.setBackgroundImage(UIImage(named: thumbnilsArray[categoryScrollViewCount]), for: .normal)
        btn.addTarget(self, action: #selector(categoryActionBtn), for: .touchUpInside)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        
        lockButton = UIButton(frame: CGRect(x: btn.bounds.width-25, y: 0, width: 25, height: 12))
        lockButton.setImage(UIImage(named: "pro"), for: .normal)
        self.lockButton.addTarget(self, action:#selector(self.lockCategoryActionBtn), for: .touchUpInside)
        lockButton.tag = categoryScrollViewCount
        lockButton.showsTouchWhenHighlighted = true
        lockButton.isUserInteractionEnabled = true
        if isAllPurchase == true
        {
          print("ffd")
        }
        else
        {
          if (i>3)
          {
            btn.addSubview(lockButton)
          }
        }
      
        xCoord +=  buttonWidth + gapBetweenButtons
        categoryScrollView.addSubview(btn)
      }
      categoryScrollView.contentSize = CGSize(width: (buttonWidth + gapBetweenButtons) * CGFloat(categoryScrollViewCount+1), height: yCoord)
    }
    else if isGlitter == true
    {
      let yCoord: CGFloat = 5
      let buttonHeight: CGFloat = 58.0
      for i in 0..<glittersThumbArray.count{
        categoryScrollViewCount = i
        // Button properties
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
        btn.tag = categoryScrollViewCount
        btn.showsTouchWhenHighlighted = true
        btn.setBackgroundImage(UIImage(named: glittersThumbArray[categoryScrollViewCount]), for: .normal)
        btn.addTarget(self, action: #selector(categoryActionBtn), for: .touchUpInside)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        
        lockButton = UIButton(frame: CGRect(x: btn.bounds.width-25, y: 0, width: 25, height: 12))
        lockButton.setImage(UIImage(named: "pro"), for: .normal)
        self.lockButton.addTarget(self, action:#selector(self.lockCategoryActionBtn), for: .touchUpInside)
        lockButton.tag = categoryScrollViewCount
        lockButton.showsTouchWhenHighlighted = true
        lockButton.isUserInteractionEnabled = true
        if isAllPurchase == true
        {
          print("ffd")
        }
        else
        {
          if (i>3)
          {
            btn.addSubview(lockButton)
          }
        }
      
        xCoord +=  buttonWidth + gapBetweenButtons
        categoryScrollView.addSubview(btn)
      }
      categoryScrollView.contentSize = CGSize(width: (buttonWidth + gapBetweenButtons) * CGFloat(categoryScrollViewCount+1), height: yCoord)
      
    }
    else if isShape == true
    {
      let yCoord: CGFloat = 5
      let buttonHeight: CGFloat = 58.0
      for i in 0..<shapeThumbArray.count{
        categoryScrollViewCount = i
        // Button properties
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
        btn.tag = categoryScrollViewCount
        btn.showsTouchWhenHighlighted = true
        btn.setBackgroundImage(UIImage(named: shapeThumbArray[categoryScrollViewCount]), for: .normal)
        btn.addTarget(self, action: #selector(categoryActionBtn), for: .touchUpInside)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        
        lockButton = UIButton(frame: CGRect(x: btn.bounds.width-25, y: 0, width: 25, height: 12))
        lockButton.setImage(UIImage(named: "pro"), for: .normal)
        self.lockButton.addTarget(self, action:#selector(self.lockCategoryActionBtn), for: .touchUpInside)
        lockButton.tag = categoryScrollViewCount
        lockButton.showsTouchWhenHighlighted = true
        lockButton.isUserInteractionEnabled = true
        
        xCoord +=  buttonWidth + gapBetweenButtons
        categoryScrollView.addSubview(btn)
        if isAllPurchase == true
        {
          print("ffd")
        }
        else
        {
          if (i>3)
          {
            btn.addSubview(lockButton)
          }
        }
      }
      categoryScrollView.contentSize = CGSize(width: (buttonWidth + gapBetweenButtons) * CGFloat(categoryScrollViewCount+1), height: yCoord)
    }
    
  }
  
  @objc func lockCategoryActionBtn(sender: UIButton) {
    
  }
  
  @objc func categoryActionBtn(sender: UIButton) {
    let index = sender.tag
    if isAllPurchase == true {
      
      if isFrame == true
      {
        self.imageView.image = UIImage(named:frameImageArray[index])
        self.frameData = frameDataArray[index]
        frameCordination()
        
      } else if isGlitter == true
      {
        self.imageView.image = UIImage(named: glittersArray[index])
        
      } else if isShape == true
      {
        self.imageView.image = UIImage(named: shapeImageArray[index])
        
      }
      mycategoryArray.append(imageView)
      categoryScrollViewCount += 1
    }  else
    {
      if (index<4) {
        if isFrame == true
        {
          self.imageView.image = UIImage(named:frameImageArray[index])
          self.frameData = frameDataArray[index]
          frameCordination()
          
        } else if isGlitter == true
        {
          self.imageView.image = UIImage(named: glittersArray[index])
          
        } else if isShape == true
        {
          self.imageView.image = UIImage(named: shapeImageArray[index])
          
        }
        mycategoryArray.append(imageView)
        categoryScrollViewCount += 1
      }
    }
  }
  
  //MARK:- color
  func colorLoadScrollView()
  {
    var xCoord: CGFloat = 5
    let yCoord: CGFloat = 0
    let buttonWidth:CGFloat = 30.0
    let buttonHeight: CGFloat = 45.0
    let gapBetweenButtons: CGFloat = 0
    
    for i in 0..<colorArray.count{
      colorScrollViewCount = i
      // Button properties
      let btn = UIButton(type: .custom)
      btn.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
      btn.tag = colorScrollViewCount
      btn.showsTouchWhenHighlighted = true
      btn.backgroundColor = colorArray[colorScrollViewCount]
      btn.addTarget(self, action: #selector(colorbuttonAction), for: .touchUpInside)
      btn.clipsToBounds = true
      xCoord +=  buttonWidth + gapBetweenButtons
      colorScrollView.addSubview(btn)
    }
    colorScrollView.contentSize = CGSize(width: (buttonWidth + gapBetweenButtons) * CGFloat(colorScrollViewCount+1), height: yCoord)
    
  }
  
  @objc func colorbuttonAction(sender: UIButton!) {
    let indexno = sender.tag
    let tintableImage = imageView.image?.withRenderingMode(.alwaysTemplate)
    self.imageView.image = tintableImage
    self.imageView.tintColor = colorArray[indexno]
    
  }
  
  //MARK:- Save photo
  func saveimage(with view: UIView) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
    defer { UIGraphicsEndImageContext() }
    if let context = UIGraphicsGetCurrentContext() {
      view.layer.render(in: context)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      return image
    }
    return nil
  }
}

// MARK:- Footer IBButton Action
extension PhotoFrameViewController {
  
  @IBAction func filterTappedBtn(_ sender: Any)
  {
    isFilter = true
    isCategory = false
    isStickers = false
    isRotation = false
    
    self.rotateViewBottomCnst.constant = -209
    self.stickerViewBottomCnst.constant = -277
    self.categoryViewBottomCnst.constant = -185
    
    if filterBtn.isSelected == false
    {
      UIView.animate(withDuration: 0.5) {
        self.footerBottomCnst.constant = -70
        self.filterViewBottomCnst.constant = 1
        self.filterBtn.isSelected = true
        self.view.layoutIfNeeded()
      }
    }
    else
    {
      UIView.animate(withDuration: 0.5) {
        self.footerBottomCnst.constant = 1
        self.filterViewBottomCnst.constant = 141
        self.filterBtn.isSelected = false
        self.view.layoutIfNeeded()
      }
    }
  }
  
  @IBAction func rotateTappedBtn(_ sender: Any) {
    isRotation = true
    isCategory = false
    isFilter = false
    isStickers = false
    
    self.filterViewBottomCnst.constant = 144
    self.stickerViewBottomCnst.constant = -277
    self.categoryViewBottomCnst.constant = -185
    
    if rotateBtn.isSelected == false
    {
      UIView.animate(withDuration: 0.5) {
        self.footerBottomCnst.constant = -70
        self.rotateViewBottomCnst.constant = 1
        self.rotateBtn.isSelected = true
        self.view.layoutIfNeeded()
      }
    }
    else
    {
      UIView.animate(withDuration: 0.5) {
        self.footerBottomCnst.constant = 1
        self.rotateViewBottomCnst.constant = -209
        self.rotateBtn.isSelected = false
        self.view.layoutIfNeeded()
      }
    }
  }
  
  @IBAction func stickerTappedBtn(_ sender: Any) {
    isStickers = true
    isCategory = false
    isFilter = false
    isRotation = false
    //    filterBtn.isSelected = false
    //    rotateBtn.isSelected = false
    self.rotateViewBottomCnst.constant = -209
    self.filterViewBottomCnst.constant = 144
    self.categoryViewBottomCnst.constant = -185
    
    if stickerBtn.isSelected == false
    {
      UIView.animate(withDuration: 0.5) {
        self.footerBottomCnst.constant = -70
        self.stickerViewBottomCnst.constant = 1
        self.stickerBtn.isSelected = true
        self.view.layoutIfNeeded()
      }
    }
    else
    {
      UIView.animate(withDuration: 0.5) {
        self.footerBottomCnst.constant = 1
        self.stickerViewBottomCnst.constant = -277
        self.stickerBtn.isSelected = false
        self.view.layoutIfNeeded()
      }
    }
    
  }
  
  @IBAction func categoryTappedBtn(_ sender: Any) {
    
    isCategory = true
    isFilter = false
    isStickers = false
    isRotation = false
    //    filterBtn.isSelected = false
    //    stickerBtn.isSelected = false
    self.filterViewBottomCnst.constant = 144
    self.stickerViewBottomCnst.constant = -277
    self.rotateViewBottomCnst.constant = -209
    
    if categoryBtn.isSelected == false
    {
      UIView.animate(withDuration: 0.5) {
        self.footerBottomCnst.constant = -70
        self.categoryViewBottomCnst.constant = 1
        self.categoryBtn.isSelected = true
        self.view.layoutIfNeeded()
      }
    }
    else
    {
      UIView.animate(withDuration: 0.5) {
        self.footerBottomCnst.constant = 1
        self.categoryViewBottomCnst.constant = -185
        self.categoryBtn.isSelected = false
        self.view.layoutIfNeeded()
      }
    }
    
  }
  
  @IBAction func doneTappedBtn(_ sender: Any) {
    
    for cnclbtn in stikerCncleBtnArray
    {
      cnclbtn.isHidden = true
    }
    
    for stView in stikerImageBrdrArray
    {
      stView.layer.borderColor = UIColor.clear.cgColor
    }
    
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Save_ShareVC") as! Save_ShareVC
    let finalImage = saveimage(with: self.containtView)
    viewController.getImage = finalImage
    self.navigationController?.pushViewController(viewController, animated: true)
    
  }
  
  //MARK:- Rotation Action
  @IBAction func leftRotateBtnAction(_ sender: Any) {
    
    if isFirstFilterimage == false
    {
      UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {() -> Void in
        self.firstImage.transform = self.firstImage.transform.rotated(by: -.pi / 2)
      }, completion: {(_ finished: Bool) -> Void in
        if finished {
        }
      })
    } else
    {
      UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {() -> Void in
        self.secondImage.transform = self.secondImage.transform.rotated(by: -.pi / 2)
      }, completion: {(_ finished: Bool) -> Void in
        if finished {
        }
      })
    }
    
  }
  
  
  @IBAction func rightRotateBtnAction(_ sender: Any) {
    
    if isFirstFilterimage == false
    {
      UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {() -> Void in
        self.firstImage.transform = self.firstImage.transform.rotated(by: .pi / 2)
      }, completion: {(_ finished: Bool) -> Void in
        if finished {
        }
      })
    } else
    {
      UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {() -> Void in
        self.secondImage.transform = self.secondImage.transform.rotated(by: .pi / 2)
      }, completion: {(_ finished: Bool) -> Void in
        if finished {
        }
      })
    }
    
  }
  
  
  @IBAction func rightFlipBtnAction(_ sender: Any) {
    
    _ = UIImage()
    if isFirstFilterimage == false
    {
      DispatchQueue.main.async
        {
          if (self.flipped)
          {
            self.flipped = false
            let image = UIImage(cgImage: (self.firstImage.image?.cgImage!)!, scale: self.firstImage.image!.scale, orientation: UIImage.Orientation(rawValue: 0)!)
            self.receiveImage = image
            self.firstImage.image = image
          }
          else
          {
            self.flipped = true
            let image = UIImage(cgImage: (self.firstImage.image?.cgImage!)!, scale: self.firstImage.image!.scale, orientation:UIImage.Orientation(rawValue: 4)!)
            self.receiveImage = image
            self.firstImage.image = image
          }
      }
    }
    else
    {
      DispatchQueue.main.async
        {
          if (self.flipped)
          {
            self.flipped = false
            let image = UIImage(cgImage: (self.secondImage.image?.cgImage!)!, scale: self.secondImage.image!.scale, orientation: UIImage.Orientation(rawValue: 0)!)
            self.receiveImage = image
            self.secondImage.image = image
          }
          else
          {
            self.flipped = true
            let image = UIImage(cgImage: (self.secondImage.image?.cgImage!)!, scale: self.secondImage.image!.scale, orientation:UIImage.Orientation(rawValue: 4)!)
            self.receiveImage = image
            self.secondImage.image = image
          }
      }
    }
  }
  
  
  @IBAction func leftFlipBtnAction(_ sender: Any) {
    
    if isFirstFilterimage == false
    {
      DispatchQueue.main.async
        {
          if (self.flipped)
          {
            self.flipped = false
            let image = UIImage(cgImage: (self.firstImage.image?.cgImage!)!, scale: self.firstImage.image!.scale, orientation: UIImage.Orientation(rawValue: 1)!)
            self.receiveImage = image
            self.firstImage.image = image
          }
          else
          {
            self.flipped = true
            let image = UIImage(cgImage: (self.firstImage.image?.cgImage!)!, scale: self.firstImage.image!.scale, orientation:UIImage.Orientation(rawValue: 4)!)
            self.receiveImage = image
            self.firstImage.image = image
          }
      }
      
    } else {
      
      DispatchQueue.main.async
        {
          if (self.flipped)
          {
            self.flipped = false
            let image = UIImage(cgImage: (self.secondImage.image?.cgImage!)!, scale: self.secondImage.image!.scale, orientation: UIImage.Orientation(rawValue: 1)!)
            self.receiveImage = image
            self.secondImage.image = image
          }
          else
          {
            self.flipped = true
            let image = UIImage(cgImage: (self.secondImage.image?.cgImage!)!, scale: self.secondImage.image!.scale, orientation:UIImage.Orientation(rawValue: 4)!)
            self.receiveImage = image
            self.secondImage.image = image
          }
      }
    }
  }
  
  //MARK:- Sticker Gesture
  func stickerGesture() {
    
    let stickerTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.stickerTap1(_:)))
    stickerTapGesture.delegate = self
    myStickerView.addGestureRecognizer(stickerTapGesture)
    
    let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
    gestureRecognizer.delegate = self
    gestureRecognizer.minimumNumberOfTouches = 1
    gestureRecognizer.maximumNumberOfTouches = 1
    myStickerView.addGestureRecognizer(gestureRecognizer)
    
    //Enable multiple touch and user interaction for textfield
    myStickerView.isUserInteractionEnabled = true
    myStickerView.isMultipleTouchEnabled = true
    
    //add pinch gesture
    let pinchGesture = UIPinchGestureRecognizer(target: self, action:#selector(pinchRecognized(pinch:)))
    pinchGesture.delegate = self
    myStickerView.addGestureRecognizer(pinchGesture)
    
    //add rotate gesture.
    let rotate = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(recognizer:)))
    rotate.delegate = self
    myStickerView.addGestureRecognizer(rotate)
    
  }
  
  @objc func stickerTap1(_ sender: UITapGestureRecognizer)
  {
    
    let tapView = sender.view?.tag
    for cnclbtn in stikerCncleBtnArray
    {
      if cnclbtn.tag == tapView {
        cnclbtn.isHidden = false
      }
    }
    for stView in stikerImageBrdrArray
    {
      if stView.tag == tapView {
        stView.layer.borderColor = UIColor.black.cgColor
      }
    }
  }
  
  @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
    if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
      
      let translation = gestureRecognizer.translation(in: self.view)
      // note: 'view' is optional and need to be unwrapped
      gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
      gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
    }
  }
  
  @objc func pinchRecognized(pinch: UIPinchGestureRecognizer) {
    
    if let view = pinch.view {
      view.transform = view.transform.scaledBy(x: pinch.scale, y: pinch.scale)
      pinch.scale = 1
    }
  }
  
  @objc func handleRotate(recognizer : UIRotationGestureRecognizer) {
    if let view = recognizer.view {
      view.transform = view.transform.rotated(by: recognizer.rotation)
      recognizer.rotation = 0
    }
  }
  
  //MARK:- UIGestureRecognizerDelegate Methods
  func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
    return true
  }
  
  //MARK:- Category Frame
  func frameCordination() {
    firstImage.image = image1
    let image1FrameData = frameData[0]
    let x1 = image1FrameData["x"]
    let y1 = image1FrameData["y"]
    let w1 = image1FrameData["width"]
    let h1 = image1FrameData["height"]
    let mywidth = UIScreen.main.bounds.width
    let myheight = self.viewHeight.constant
    let frame1 = CGRect(x: Int(x1!)!, y: Int(y1!)!, width: Int(w1!)!, height: Int(h1!)!)
    let newFrame1 = CGRect(x : (frame1.origin.x*mywidth)/700, y:(frame1.origin.y*myheight)/900, width : (frame1.size.width*mywidth)/700, height : (frame1.size.height*myheight)/900)
    view1.frame = newFrame1
    firstImage.frame = CGRect(x: 0, y: 0, width: self.view1.bounds.size.width, height: self.view1.bounds.size.height)
    self.view1.addSubview(firstImage)
    view1.clipsToBounds = true
    self.containtView.addSubview(view1)
    viewFrame2()
    self.containtView.bringSubviewToFront(self.imageView)
  }
  
  //MARK:- Apply Filter
  func applyFilter(index:Int) {
    
    if isFrame == true {
      DispatchQueue.main.async {
        if self.isFirstFilterimage == false {
          if let currentFilter1 = CIFilter(name: "\(filterArray[index])") {
            let beginImage1 = CIImage(image: self.image1)
            currentFilter1.setValue(beginImage1, forKey: kCIInputImageKey)
            if let output = currentFilter1.outputImage {
              if let cgimg = self.ciContext.createCGImage(output, from: output.extent) {
                let newImage1 = UIImage(cgImage:cgimg, scale: self.firstImage.image!.scale, orientation:self.firstImage.image!.imageOrientation)
                print(newImage1)
                let processedImage1 = newImage1
                self.firstImage.image = processedImage1
              }
            }
          }
        }
        else {
          if let currentFilter1 = CIFilter(name: "\(filterArray[index])") {
            let beginImage1 = CIImage(image: self.image2)
            currentFilter1.setValue(beginImage1, forKey: kCIInputImageKey)
            if let output = currentFilter1.outputImage {
              if let cgimg = self.ciContext.createCGImage(output, from: output.extent) {
                let newImage1 = UIImage(cgImage:cgimg, scale: self.firstImage.image!.scale, orientation:self.secondImage.image!.imageOrientation)
                print(newImage1)
                let processedImage1 = newImage1
                self.secondImage.image = processedImage1
              }
            }
          }
        }
      }
    }
    else
    {
      DispatchQueue.main.async {
        if let currentFilter1 = CIFilter(name: "\(filterArray[index])") {
          let beginImage1 = CIImage(image: self.image1)
          currentFilter1.setValue(beginImage1, forKey: kCIInputImageKey)
          if let output = currentFilter1.outputImage {
            if let cgimg = self.ciContext.createCGImage(output, from: output.extent) {
              let newImage1 = UIImage(cgImage:cgimg, scale: self.firstImage.image!.scale, orientation:self.firstImage.image!.imageOrientation)
              print(newImage1)
              let processedImage1 = newImage1
              self.firstImage.image = processedImage1
            }
          }
        }
      }
    }
  }
  
}










