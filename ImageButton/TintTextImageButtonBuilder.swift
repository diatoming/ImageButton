//
//  TintStateImages.swift
//  ImageButton
//
//  Created by Dmitry Nikolaev on 04.05.15.
//  Copyright (c) 2015 Dmitry Nikolaev. All rights reserved.
//

import AppKit


public class TintTextImageButtonBuilder {
    
    public var height: CGFloat
    
    public var defaultColor: NSColor = NSColor.blackColor()
    public var overColor: NSColor = NSColor.yellowColor()
    public var pressedColor: NSColor = NSColor.redColor()
    public var disabledColor: NSColor = NSColor.grayColor()
    
    public var font = NSFont(name: "Helvetica Neue", size: 13)
    public var textXOffset = CGFloat(0.0)
    public var textYOffset = CGFloat(0.0)

    public init(height: CGFloat) {
        self.height = height
    }
    
    public func buildImagesWithImage(image: NSImage, text: String) -> ImageButtonImages {
        let textSize = self.textSize(text)
        let width = image.size.width + self.textXOffset + textSize.width;
        let midY = self.height / 2
        let imagePoint = NSPoint(x: 0, y: midY - image.size.height / 2)
        let textPoint = NSPoint(x: image.size.width + self.textXOffset, y: textYOffset)
        
        let templateImage = NSImage(size: NSMakeSize(width , height))
        templateImage.lockFocus()
        
        image.drawAtPoint(imagePoint, fromRect: NSZeroRect, operation: NSCompositingOperation.CompositeSourceOver, fraction: 1)
        (text as NSString).drawAtPoint(textPoint, withAttributes: self.textAttributes())
        templateImage.unlockFocus()
        
        let result = ImageButtonImages()
        result.defaultImage = templateImage.imageWithTint(self.defaultColor)
        result.overImage = templateImage.imageWithTint(self.overColor)
        result.pressedImage = templateImage.imageWithTint(self.pressedColor)
        result.disabledImage = templateImage.imageWithTint(self.disabledColor)
        return result
    }
    
    private func textAttributes(color: NSColor? = nil) -> [String : AnyObject] {
        var result = [String : AnyObject]()
        result[NSFontAttributeName] = self.font!
        if color != nil {
            result[NSForegroundColorAttributeName] = color!
        }
        
        return result
    }
    
    private func textSize(text: String) -> NSSize {
        let string = text as NSString
        let size = string.sizeWithAttributes(self.textAttributes())
        return size
    }

}

public extension ImageButton {
    public convenience init(image: NSImage, text: String, height: CGFloat, defaultColor: NSColor, overColor: NSColor, pressedColor: NSColor, disabledColor: NSColor, font: NSFont, textXOffset: CGFloat, textYOffset: CGFloat) {
        let imageBuilder = TintTextImageButtonBuilder(height: height)
        imageBuilder.defaultColor = defaultColor
        imageBuilder.overColor = overColor
        imageBuilder.pressedColor = pressedColor
        imageBuilder.disabledColor = disabledColor
        imageBuilder.font = font
        imageBuilder.textXOffset = textXOffset
        imageBuilder.textYOffset = textYOffset
        self.init(images: imageBuilder.buildImagesWithImage(image, text: text))
    }
}


