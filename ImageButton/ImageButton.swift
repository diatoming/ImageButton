//
//  ImageButton.swift
//  Numi
//
//  Created by Dmitry Nikolaev on 02.12.14.
//  Copyright (c) 2014 Dmitry Nikolaev. All rights reserved.
//

import Foundation
import AppKit

@objc
public class ImageButton: NSView {
    
    public var images: ImageButtonImages? {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.needsDisplay = true
        }
    }
    
    public var delegate: ImageButtonDelegate?
    public var action: Optional<() -> ()>
    public var enabled: Bool = true {
        didSet {
            self.needsDisplay = true
        }
    }

    public var mouseOver = false
    public var pressed = false
    public var debug = false {
        didSet {
            needsDisplay = true
        }
    }

    private var trackedArea: NSTrackingArea?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.postInit()
    }
    
    public init(images: ImageButtonImages) {
        self.images = images
        super.init(frame: NSRect(origin: CGPoint(), size: self.images!.defaultImage!.size))
        self.postInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.postInit()
    }
    
    private func postInit() {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.setContentCompressionResistancePriority(1000, forOrientation: .Horizontal)
        self.setContentCompressionResistancePriority(1000, forOrientation: .Vertical)
        self.setContentHuggingPriority(1000, forOrientation: .Horizontal)
        self.setContentHuggingPriority(1000, forOrientation: .Vertical)
    }
    
    public override func updateTrackingAreas() {
        if let trackingArea = self.trackedArea {
            self.removeTrackingArea(trackingArea)
        }
        
        self.trackedArea = NSTrackingArea(rect: self.bounds, options: [.MouseEnteredAndExited, .ActiveAlways, .EnabledDuringMouseDrag], owner: self, userInfo: nil)
        self.addTrackingArea(self.trackedArea!)
    }
    
    override public func resetCursorRects() {
        self.addCursorRect(self.bounds, cursor: NSCursor.pointingHandCursor())
    }
    
    public override var intrinsicContentSize: NSSize {
        return (self.images != nil) ? self.images!.defaultImage!.size : NSSize(width: NSViewNoInstrinsicMetric, height: NSViewNoInstrinsicMetric)
    }
    
    // MARK: Mouse
    
    override public func mouseEntered(theEvent: NSEvent) {
        self.mouseOver = true
        self.needsDisplay = true
        if self.enabled {
            self.delegate?.imageButtonMouseEnter(self)
        }
    }
    
    override public func mouseExited(theEvent: NSEvent) {
        self.mouseOver = false
        self.needsDisplay = true
        if self.enabled {
            self.delegate?.imageButtonMouseExit(self)
        }
    }
    
    override public func mouseDown(theEvent: NSEvent) {
        self.pressed = true
        self.needsDisplay = true
    }
    
    override public func mouseUp(theEvent: NSEvent) {
        
        if !self.enabled {
            return
        }
        
        if self.pressed {
            if let action = self.action {
                self.mouseOver = false
                action()
            }
        }
        self.pressed = false
        self.needsDisplay = true
    }
    
    override public func drawRect(dirtyRect: NSRect) {
        
        if debug {
            
            var color = NSColor.yellowColor()
            
            switch state() {
            case .Over:
                color = NSColor.greenColor()
            case .Pressed:
                color = NSColor.redColor()
            default:
                color = NSColor.yellowColor()
            }
            
            color.setFill()
            NSRectFill(bounds)
        }
        
        let image = self.imageByState(self.state())
        image?.drawAtPoint(NSPoint(), fromRect: NSZeroRect, operation: NSCompositingOperation.CompositeSourceOver, fraction: 1)
    }

    private func state() -> ImageButtonState {
        var state = ImageButtonState.Default
        
        if (!self.enabled) {
            state = ImageButtonState.Disabled
        } else {
            
            if (self.mouseOver) {
                state = ImageButtonState.Over
                if (self.pressed) {
                    state = ImageButtonState.Pressed
                }
            }
        }
        return state
    }
    
    private func imageByState(state: ImageButtonState) -> NSImage? {
        let image: NSImage?
        switch state {
        case .Default:
            image = self.images?.defaultImage
        case .Over:
            image = self.images?.overImage
        case .Pressed:
            image = self.images?.pressedImage
        case .Disabled:
            image = self.images?.disabledImage
        }
        return image
    }
    
}

@objc
public protocol ImageButtonDelegate {
    func imageButtonMouseEnter(button: ImageButton)
    func imageButtonMouseExit(button: ImageButton)
}


public class ImageButtonImages {
    public var defaultImage, overImage, pressedImage, disabledImage: NSImage?
}

@objc
public protocol ImageButtonPresentation {
    func drawForButtonState(buttonState: ImageButtonState, dirtyRect: NSRect)
    func intrinsicContentSize()->NSSize
}

@objc
public enum ImageButtonState: Int {
    case Default, Over, Pressed, Disabled
}




