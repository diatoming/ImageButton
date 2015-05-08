//
//  TintImageButtonBuilder.swift
//  ImageButton
//
//  Created by Дмитрий Николаев on 06.05.15.
//  Copyright (c) 2015 Dmitry Nikolaev. All rights reserved.
//

import AppKit

@objc
public class TintImageButtonBuilder {
    
    public var defaultColor: NSColor = NSColor.blackColor()
    public var overColor: NSColor = NSColor.yellowColor()
    public var pressedColor: NSColor = NSColor.redColor()
    public var disabledColor: NSColor = NSColor.grayColor()
    
    public init() {
        
    }

    public func buildImagesForImage(image: NSImage) -> ImageButtonImages {
        let result = ImageButtonImages()
        result.defaultImage = image.imageWithTint(self.defaultColor)
        result.overImage = image.imageWithTint(self.overColor)
        result.pressedImage = image.imageWithTint(self.pressedColor)
        result.disabledImage = image.imageWithTint(self.disabledColor)
        return result
    }
}

extension ImageButton {
    public convenience init(image: NSImage, defaultColor: NSColor, overColor: NSColor, pressedColor: NSColor, disabledColor: NSColor) {
        let imageBuilder = TintImageButtonBuilder()
        imageBuilder.defaultColor = defaultColor
        imageBuilder.overColor = overColor
        imageBuilder.pressedColor = pressedColor
        imageBuilder.disabledColor = disabledColor
        self.init(images: imageBuilder.buildImagesForImage(image))
    }
}

extension NSImage {
    
    func imageWithTint(color: NSColor) -> NSImage {
        let result: NSImage = self.copy() as! NSImage
        let imageRect = NSRect(origin: CGPoint(), size: result.size)
        
        result.lockFocus()
        color.set()
        NSRectFillUsingOperation(imageRect, NSCompositingOperation.CompositeSourceAtop)
        result.unlockFocus()
        
        return result
        
    }
}