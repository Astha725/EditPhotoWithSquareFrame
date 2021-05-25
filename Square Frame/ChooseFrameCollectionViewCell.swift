//
//  ChooseFrameCollectionViewCell.swift
//  Square Frame
//
//  Created by Hutch on 22/07/19.
//  Copyright © 2019 Hutch. All rights reserved.
//

import UIKit

class ChooseFrameCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var frameImage: UIImageView!
  @IBOutlet weak var crownImage: UIImageView!

  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.crownImage.isHidden = true
  }
  
}
