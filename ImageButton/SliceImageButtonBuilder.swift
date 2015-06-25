//
//  SliceStateImages.swift
//  ImageButton
//
//  Created by Dmitry Nikolaev on 04.05.15.
//  Copyright (c) 2015 Dmitry Nikolaev. All rights reserved.
//

import AppKit

@objc
public class SliceImageButtonBuilder {
    
    var buttonSize: NSSize?
    var sliceWidth: CGFloat?

    public init(buttonSize: NSSize? = nil, sliceWidth: CGFloat? = nil) {
        self.buttonSize = buttonSize
        self.sliceWidth = sliceWidth
    }
    
    public func buildImagesForImage(image: NSImage) -> ImageButtonImages {
        let finalButtonSize = buttonSize ?? NSSize(width: image.size.width, height: image.size.height)
        let finalSiceWidth = sliceWidth ?? image.size.height
        
        let result = ImageButtonImages()
        result.defaultImage = image.imageSlice(0, size: finalButtonSize, sliceWidth: finalSiceWidth)
        result.overImage = image.imageSlice(1, size: finalButtonSize, sliceWidth: finalSiceWidth)
        result.pressedImage = image.imageSlice(2, size: finalButtonSize, sliceWidth: finalSiceWidth)
        result.disabledImage = image.imageSlice(3, size: finalButtonSize, sliceWidth: finalSiceWidth)
        return result
    }
    
}

public extension ImageButton {
    convenience init (image: NSImage, buttonSize: NSSize? = nil, sliceWidth: CGFloat? = nil) {
        let imageBuilder = SliceImageButtonBuilder(buttonSize: buttonSize, sliceWidth: sliceWidth)
        self.init(images: imageBuilder.buildImagesForImage(image))
    }
}

extension NSImage {
    func imageSlice(slice: Int, size:NSSize, sliceWidth:CGFloat) -> NSImage {
        let imageHeight = self.size.height
        var srcRect = NSMakeRect(sliceWidth * CGFloat(slice), 0, sliceWidth, imageHeight)
        
        srcRect.origin.x += (sliceWidth-size.width)/2
        srcRect.origin.y += (imageHeight-size.height)/2
        srcRect.size = size
        
        let destRect = NSRect(origin: NSPoint(x:0, y:0), size: srcRect.size)

        let result = NSImage(size: srcRect.size)
        result.lockFocus()
        self.drawInRect(destRect, fromRect: srcRect, operation: .CompositeSourceOver, fraction: 1, respectFlipped: true, hints: nil)
        result.unlockFocus()
        return result
    }
}
