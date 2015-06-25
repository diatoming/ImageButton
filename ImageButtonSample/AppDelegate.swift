//
//  AppDelegate.swift
//  ImageButtonSample
//
//  Created by Dmitry Nikolaev on 04.05.15.
//  Copyright (c) 2015 Dmitry Nikolaev. All rights reserved.
//

import Cocoa
import ImageButton

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var slicedImageButton: ImageButton!
    @IBOutlet weak var tintImageButton: ImageButton!
    
    @IBOutlet weak var tintTextImageButton: ImageButton!
    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let sliceImageBuilder = SliceImageButtonBuilder(buttonSize: NSMakeSize(40, 40), sliceWidth: 40)
        self.slicedImageButton.images = sliceImageBuilder.buildImagesForImage(NSImage(named: "slices")!)
        
        let tintTextImageBuilder = TintTextImageButtonBuilder(height: 40)
        tintTextImageBuilder.textXOffset = CGFloat(0.5)
        tintTextImageBuilder.textYOffset = CGFloat(12.5)
        tintTextImageButton.images = tintTextImageBuilder.buildImagesWithImage(NSImage(named: "tint")!, text: "Label")
        
        let tintImageBuilder = TintImageButtonBuilder()
        tintImageButton.images = tintImageBuilder.buildImagesForImage(NSImage(named: "tint")!)
    }

}

