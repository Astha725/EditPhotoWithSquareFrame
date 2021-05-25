//
//  Global.swift
//  Square Frame
//
//  Created by Hutch on 22/07/19.
//  Copyright © 2019 Hutch. All rights reserved.
//

import UIKit
import Foundation

var isFilter = false
var isRotation = false
var isStickers = false
var isCategory = false

var isFrame = false
var isGlitter = false
var isShape = false

var isAllPurchase = false


var frameImageArray = ["frame1", "frame2", "frame3", "frame4", "frame5",
                       "frame6", "frame7", "frame8", "frame9", "frame10",
                       "frame11", "frame12", "frame13", "frame14", "frame15",
                       "frame16", "frame17", "frame18", "frame19", "frame20",
                       "frame21", "frame22", "frame23", "frame24", "frame25",
                       "frame26", "frame27", "frame28", "frame29", "frame30",
                       "frame31", "frame32", "frame33", "frame34", "frame35"
                  ]

var thumbnilsArray = ["thumb1", "thumb2", "thumb3", "thumb4", "thumb5",
                      "thumb6", "thumb7", "thumb8", "thumb9", "thumb10",
                      "thumb11", "thumb12", "thumb13", "thumb14", "thumb15",
                      "thumb16", "thumb17", "thumb18", "thumb19", "thumb20",
                      "thumb21", "thumb22", "thumb23", "thumb24", "thumb25",
                      "thumb26", "thumb27", "thumb28", "thumb29", "thumb30",
                      "thumb31", "thumb32", "thumb33", "thumb34", "thumb35"]

var shapeThumbArray = ["F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8",
                       "gT1", "gT2", "gT3", "gT4", "gT5", "gT6", "gT7", "gT8", "gT9", "gT10",
                       "LT1", "LT2", "LT3", "LT4", "LT5", "LT6", "LT7", "LT8", "LT9", "LT10",
                       "NT1", "NT2", "NT3", "NT4", "NT5", "NT6", "NT7", "NT8",
                       "tT1", "tT2", "tT3", "tT4", "tT5", "tT6", "tT7",
                       "At1", "At2", "At3", "At4", "At5", "At6", "At7", "At8", "At9", "At10",
                       "Thumb1", "Thumb2", "Thumb3", "Thumb4"]


var shapeImageArray = ["f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8",
                       "g1", "g2", "g3", "g4", "g5", "g6", "g7", "g8", "g9", "g10",
                       "L1", "L2", "L3", "L4", "L5", "L6", "L7", "L8", "L9", "L10",
                       "N1", "N2", "N3", "N4", "N5", "N6", "N7", "N8",
                       "st1", "st2", "st3", "st4", "st5", "st6", "st7",
                       "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10",
                       "t1", "t2", "t3", "t4"]

var glittersArray = ["gl6", "gl7", "gl8", "gl9", "gl10",
                     "gl11", "gl12", "gl13", "gl14", "gl15",
                     "gl16", "gl17", "gl18", "gl19", "gl20",
                     "gl1", "gl2", "gl3", "gl4", "gl5"]

var glittersThumbArray = ["gt6", "gt7", "gt8", "gt9", "gt10",
                          "gt11", "gt12", "gt13", "gt14", "gt15",
                          "gt16", "gt17", "gt18", "gt19", "gt20",
                          "gt1", "gt2", "gt3", "gt4", "gt5"]

 let filterArray = ["CIColorControls", "CIPhotoEffectChrome",
                    "CIPhotoEffectFade", "CIPhotoEffectInstant",
                    "CIPhotoEffectMono", "CIPhotoEffectTransfer",
                    "CILinearToSRGBToneCurve", "CISRGBToneCurveToLinear",
                    "CITemperatureAndTint", "CIPhotoEffectTonal",
                    "CIColorMonochrome", "CISepiaTone",
                    "CIFalseColor", "CIMaximumComponent",
                    "CIMinimumComponent", "CIPhotoEffectNoir",
                    "CIPhotoEffectProcess", "CIVignette",
                   ]

let filterThumbArray = ["fl0", "fl1", "fl2", "fl3", "fl4", "fl5", "fl6", "fl7", "fl8",
                        "fl9", "fl17", "fl11", "fl12", "fl13", "fl14",
                        "fl16", "fl18", "fl10"]


let stickerArray = ["s1", "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "s10",
                    "s11", "s12", "s13", "s14", "s15", "s16", "s17", "s18", "s19", "s20",
                    "s21", "s22", "s23", "s24", "s25", "s26", "s27", "s28", "s29", "s30",
                    "s31", "s32", "s33", "s34", "s35", "s36", "s37", "s38"]


let colorArray =  [UIColor.init(red: 340.0/255.0, green: 82.0/255.0, blue: 78.0/255.0, alpha: 1),
                   UIColor.init(red: 77.0/255.0, green: 70.0/255.0, blue: 78.0/255.0, alpha: 1),
                   UIColor.init(red: 180.0/255.0, green: 38.0/255.0, blue: 92.0/255.0, alpha: 1),
                   UIColor.init(red: 123.0/255.0, green: 26.0/255.0, blue: 70.0/255.0, alpha: 1),
                   UIColor.init(red: 200.0/255.0, green: 26.0/255.0, blue: 90.0/255.0, alpha: 1),
                   UIColor.init(red: 143.0/255.0, green: 36.0/255.0, blue: 19.0/255.0, alpha: 1),
                   UIColor.init(red: 349.0/255.0, green: 41.0/255.0, blue: 99.0/255.0, alpha: 1),
                   UIColor.init(red: 264.0/255.0, green: 39.0/255.0, blue: 59.0/255.0, alpha: 1),
                   UIColor.init(red: 201.0/255.0, green: 63.0/255.0, blue: 42.0/255.0, alpha: 1),
                   UIColor.init(red: 100.0/255.0, green: 21.0/255.0, blue: 95.0/255.0, alpha: 1),
                   UIColor.init(red: 130.0/255.0, green: 46.0/255.0, blue: 129.0/255.0, alpha: 1),
                   UIColor.init(red: 206.0/255.0, green: 87.0/255.0, blue: 12.0/255.0, alpha: 1),
                   UIColor.init(red: 210.0/255.0, green: 1.0/255.0, blue: 92.0/255.0, alpha: 1),
                   UIColor.init(red: 11.0/255.0, green: 29.0/255.0, blue: 76.0/255.0, alpha: 1),
                   UIColor.init(red: 201.0/255.0, green: 74.0/255.0, blue: 75.0/255.0, alpha: 1),
                   UIColor.init(red: 177.0/255.0, green: 91.0/255.0, blue: 48.0/255.0, alpha: 1),
                   UIColor.init(red: 204.0/255.0, green: 2.0/255.0, blue: 96.0/255.0, alpha: 1),
                   UIColor.init(red: 49.0/255.0, green: 48.0/255.0, blue: 87.0/255.0, alpha: 1),
                   UIColor.init(red: 102.0/255.0, green: 2.0/255.0, blue: 92.0/255.0, alpha: 1),
                   UIColor.init(red: 32.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1),
                   UIColor.init(red: 338.0/255.0, green: 31.0/255.0, blue: 46.0/255.0, alpha: 1),
                   UIColor.init(red: 180.0/255.0, green: 50.0/255.0, blue: 64.0/255.0, alpha: 1),
                   UIColor.init(red: 100.0/255.0, green: 21.0/255.0, blue: 95.0/255.0, alpha: 1),
                   UIColor.init(red: 99.0/255.0, green: 6.0/255.0, blue: 98.0/255.0, alpha: 1),
                   UIColor.init(red: 204.0/255.0, green: 18.0/255.0, blue: 33.0/255.0, alpha: 1),
                   UIColor.init(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1),
                   UIColor.init(red: 67.0/255.0, green: 6.0/255.0, blue: 51.0/255.0, alpha: 1),
                   UIColor.init(red: 39.0/255.0, green: 11.0/255.0, blue: 85.0/255.0, alpha: 1),
                   UIColor.init(red: 309.0/255.0, green: 6.0/255.0, blue: 88.0/255.0, alpha: 1),
                   UIColor.init(red: 46.0/255.0, green: 12.0/255.0, blue: 98.0/255.0, alpha: 1),
                   UIColor.init(red: 164.0/255.0, green: 41.0/255.0, blue: 15.0/255.0, alpha: 1),
                   UIColor.init(red: 196.0/255.0, green: 20.0/255.0, blue: 29.0/255.0, alpha: 1),
                   UIColor.init(red: 180.0/255.0, green: 50.0/255.0, blue: 64.0/255.0, alpha: 1),
                   UIColor.init(red: 71.0/255.0, green: 13.0/255.0, blue: 96.0/255.0, alpha: 1),
                   UIColor.init(red: 81.0/255.0, green: 25.0/255.0, blue: 94.0/255.0, alpha: 1),
                   UIColor.init(red: 154.0/255.0, green: 13.0/255.0, blue: 100.0/255.0, alpha: 1),
                   UIColor.init(red: 16.0/255.0, green: 30.0/255.0, blue: 93.0/255.0, alpha: 1),
                   UIColor.init(red: 342.0/255.0, green: 32.0/255.0, blue: 89.0/255.0, alpha: 1),
                   UIColor.init(red: 254.0/255.0, green: 46.0/253.0, blue: 251.0/255.0, alpha: 1),
                   UIColor.init(red: 254.0/255.0, green: 45.0/255.0, blue: 45.0/255.0, alpha: 1),
                   UIColor.init(red: 146.0/255.0, green: 47.0/255.0, blue: 48.0/255.0, alpha: 1),
                   UIColor.init(red: 238.0/255.0, green: 52.0/255.0, blue: 38.0/255.0, alpha: 1),
                   UIColor.init(red: 99.0/255.0, green: 34.0/255.0, blue: 63.0/255.0, alpha: 1),
                   UIColor.init(red: 22.0/255.0, green: 100.0/255.0, blue: 77.0/255.0,
                       alpha: 1),
                   UIColor.init(red: 34.0/255.0, green: 34.0/255.0, blue: 34.0/255.0, alpha: 1),
                   UIColor.init(red: 175.0/255.0, green: 59.0/255.0, blue: 23.0/255.0, alpha: 1),
                   UIColor.init(red: 336.0/255.0, green: 65.0/255.0, blue: 50.0/255.0, alpha: 1),
                   UIColor.init(red: 60.0/255.0, green: 62.0/255.0, blue: 93.0/255.0, alpha: 1),
                   UIColor.init(red: 28.0/255.0, green: 57.0/255.0, blue: 75.0/255.0, alpha: 1),
                   UIColor.init(red: 23.0/255.0, green: 60.0/255.0, blue: 94.0/255.0, alpha: 1),
                   UIColor.init(red: 351.0/255.0, green: 36.0/255.0, blue: 96.0/255.0, alpha: 1),
                   UIColor.init(red: 235.0/255.0, green: 74.0/255.0, blue: 61.0/255.0, alpha: 1),
                   UIColor.init(red: 7.0/255.0, green: 87.0/255.0, blue: 100.0/255.0, alpha: 1)
]



