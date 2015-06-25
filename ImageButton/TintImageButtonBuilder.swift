//
//  TintImageButtonBuilder.swift
//  ImageButton
//
//  Created by Dmitry Nikolaev on 06.05.15.
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

    public func buildImagesForImage(image: NSImage, size: NSSize? = nil) -> ImageButtonImages {
        let imageRect = NSRect(origin: NSPoint(), size: image.size)
        let imageCrop = imageRect.rectForSizeInTheMiddle(size ?? image.size)
        let result = ImageButtonImages()
        result.defaultImage = image.imageWithTint(self.defaultColor).crop(imageCrop)
        result.overImage = image.imageWithTint(self.overColor).crop(imageCrop)
        result.pressedImage = image.imageWithTint(self.pressedColor).crop(imageCrop)
        result.disabledImage = image.imageWithTint(self.disabledColor).crop(imageCrop)
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

    public convenience init(image: NSImage, colorScheme: ImageButtonColorScheme, size: NSSize? = nil) {
        let imageBuilder = TintImageButtonBuilder()
        imageBuilder.defaultColor = colorScheme.defaultColor
        imageBuilder.overColor = colorScheme.overColor
        imageBuilder.pressedColor = colorScheme.pressedColor
        imageBuilder.disabledColor = colorScheme.disabledColor
        self.init(images: imageBuilder.buildImagesForImage(image, size:size))
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
    
    func crop (rect: NSRect) -> NSImage {
        let result = NSImage(size: rect.size)
        result.lockFocus()
        self.drawInRect(NSRect(origin: NSPoint(), size: rect.size), fromRect: rect, operation: .CompositeSourceOver, fraction: 1, respectFlipped: true, hints: nil)
        result.unlockFocus()
        return result

    }
}

extension NSRect {
    
    func rectForSizeInTheMiddle (size: NSSize) -> NSRect {
        let x = self.origin.x + self.size.width / 2 - size.width / 2
        let y = self.origin.y + self.size.height / 2 - size.height / 2
        return NSRect(origin: NSPoint(x: x, y: y), size: size)
    }
    
}

public struct ImageButtonColorScheme {
    public var defaultColor: NSColor
    public var overColor: NSColor
    public var pressedColor: NSColor
    public var disabledColor: NSColor
    
    public init(defaultColor: NSColor, overColor: NSColor, pressedColor: NSColor, disabledColor: NSColor) {
        self.defaultColor = defaultColor
        self.overColor = overColor
        self.pressedColor = pressedColor
        self.disabledColor = disabledColor
    }
}

