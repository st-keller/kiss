//
//  ShapeRenderer.swift
//  kiss_2_2
//
//  Created by Stefan Keller on 10.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Cocoa

extension NSBezierPath {
    
    public var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        
        for i in 0 ..< self.elementCount {
            let type = self.element(at: i, associatedPoints: &points)
            switch type {
            case .moveToBezierPathElement:
                path.move(to: points[0])
            case .lineToBezierPathElement:
                path.addLine(to: points[0])
            case .curveToBezierPathElement:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePathBezierPathElement:
                path.closeSubpath()
            }
        }
        
        return path
    }
}

class ShapeRenderer : NSView, Renderer {
    
    //possible states:
    
    Path
    
    
    
    // see https://www.youtube.com/watch?v=sdEK8-0yLds
    
    // to use a flipped coordinate system do it like this:
    override var isFlipped: Bool { return true; }
    
    let cfChar = "Y" as CFString
    var ctFont = CTFontCreateWithNameAndOptions("HelveticaNeue" as CFString, 50, nil, CTFontOptions.preferSystemFont)
    
    //draw a shape
    let shapelayer = CAShapeLayer()
    
    var editModeState: Bool?
    //var font: NSFont?
    
    func setUp() -> [String : Data] {
        defineLayer()
        self.wantsLayer = true
        self.layer?.addSublayer(shapelayer)
        
        return ["font" : NSKeyedArchiver.archivedData(withRootObject: NSFont(name: "DS-Digital", size: 48) ?? NSFont.systemFont(ofSize: NSFont.systemFontSize)),
                "inEditMode" : false.toData()]
    }
    
    func render(data: [String : Data]) {
        updateFont(data: data["font"])
        updateEditMode(data: data["inEditMode"])
    }
    
    func tearDown() {
    }
    
    private func defineLayer() {
        let ctGlyph = CTFontGetGlyphWithName(ctFont, cfChar)
        let path = CTFontCreatePathForGlyph(ctFont, ctGlyph, nil)!
        
        //The angle, in radians, by which this matrix rotates the coordinate system axes. In iOS, a positive value specifies counterclockwise rotation
        //and a negative value specifies clockwise rotation.
        let box = path.boundingBox
        var transform = CGAffineTransform(translationX: box.midX, y: box.midY).rotated(by: -45.0 * .pi / 180).translatedBy(x: -box.midX, y: -box.midY)
        let shapePath = path.copy(using: &transform)
        shapelayer.path = shapePath
        
        shapelayer.lineWidth = 2
        shapelayer.strokeColor = NSColor.blue.cgColor
        //layer.fillColor = NSColor.clear.cgColor
        shapelayer.frame = (shapePath?.boundingBox)!
        shapelayer.isGeometryFlipped = true
    }
    
    private func drawGlyph() {
        
    }
    
    // Override the NSView mouseDown func to read information about a mouse-click
    override func mouseDown(with theEvent : NSEvent) {
        Swift.print("left mouse")
        let mousePoint = self.convert(theEvent.locationInWindow, from: nil)
        if (shapelayer.path?.contains(mousePoint))! {
            Swift.print("HIT!!!")
        }
    }
    
    override func rightMouseDown(with theEvent : NSEvent) {
        Swift.print("right mouse")
    }
    
    // Override the NSView keydown func to read keycode of pressed key
    override func keyDown(with theEvent: NSEvent)
    {
        //Filter Modifier-Flags (the lower 16 bits of the modifier flags are reserved for device-dependent bits):
        let effectiveModifiers = NSEvent.ModifierFlags(rawValue: theEvent.modifierFlags.rawValue & ~0xffff)
        //print ALT, if alt -key (and only alt-key) was pressed:
        if (effectiveModifiers.contains(.option) && effectiveModifiers.subtracting(.option).isEmpty)  {
            Swift.print("keyDown: ALT!")
            if (theEvent.keyCode == 0x24) {
                let newMode = !editModeState!
                Dispatcher.newEvent(event: "inEditMode", data: newMode.toData())
            }
        }
    }
    
    private func updateFont(data: Data?) {
        if ( data == nil) { return }
        
        let newFont = (NSKeyedUnarchiver.unarchiveObject(with: data!)) as? NSFont
        if (newFont != nil) {//} && newFont != font) {
            ctFont =  CTFontCreateWithNameAndOptions(newFont!.fontName as CFString, newFont!.pointSize, nil, CTFontOptions.preferSystemFont)
            
            //Symbol mit dem neuen Font zeichnen:
            defineLayer()
            
        }
    }
    
    private func updateEditMode(data: Data?) {
        if ( data == nil) { return }
        
        let newEditModeState = data?.isEmpty
        if (newEditModeState != nil && newEditModeState != editModeState) {
            editModeState = newEditModeState!
            if (editModeState)! {
                showFontPanel()
            } else {
                removeFontPanel()
            }
        }
    }
    
    private func showFontPanel() {
        //show a FontManager
        
//        NSFontManager * fontManager = [NSFontManager sharedFontManager];
//        [fontManager setTarget:self];
//        [fontManager setSelectedFont:[NSFont fontWithName:@"Helvetica" size:150.0]; isMultiple:NO];
//        [fontManager orderFrontFontPanel:self];
//
        let fontManager = NSFontManager.shared
        fontManager.target = self
        fontManager.setSelectedFont(ctFont, isMultiple: false)
        fontManager.action = #selector(self.createFontEvent)
        fontManager.orderFrontFontPanel(self)
        
        //fontManager.action = Selector("changeFont:")
        
        ////        (create if not already there)
        //        if (colorWell == nil) {
        //            colorWell = NSColorWell(frame: NSRect(x: 0, y: 80, width: 100, height: 20))
        //            colorWell?.target = self
        //            colorWell?.action = #selector(self.createColorEvent)
        //            colorWell?.color = bgColor!
        //        }
        //        self.addSubview(colorWell!)
    }
    
    //var myProp : X { get { return ... } set { ... } }
    
    private func removeFontPanel()
    {
        //        NSFontPanel.shared.orderOut(nil)
        //        NSFontPanel.shared.close()
        //        //Remove Colorwell if created and attached to view:
        //        if (colorWell != nil) {
        //            colorWell?.deactivate()
        //            if  (colorWell?.superview != nil) {
        //                colorWell?.removeFromSuperview()
        //            }
        //        }
    }
    
    @objc func createFontEvent(sender: NSFontManager) {
        let selectedFont = sender.selectedFont;
        if (selectedFont != nil)
        {
            Dispatcher.newEvent(event: "font", data: NSKeyedArchiver.archivedData(withRootObject: selectedFont!))
        }
        
    }
    //
    
    
    //    //nice Rectbox code
    //    // from https://stackoverflow.com/questions/21443625/core-text-calculate-letter-frame-in-ios/21497660#21497660
    //
    //    -(void)recalculate{
    //
    //    // get characters from NSString
    //    NSUInteger len = [_attributedString.string length];
    //    UniChar *characters = (UniChar *)malloc(sizeof(UniChar)*len);
    //    CFStringGetCharacters((__bridge CFStringRef)_attributedString.string, CFRangeMake(0, [_attributedString.string length]), characters);
    //
    //    // allocate glyphs and bounding box arrays for holding the result
    //    // assuming that each character is only one glyph, which is wrong
    //    CGGlyph *glyphs = (CGGlyph *)malloc(sizeof(CGGlyph)*len);
    //    CTFontGetGlyphsForCharacters(_font, characters, glyphs, len);
    //
    //    // get bounding boxes for glyphs
    //    CTFontGetBoundingRectsForGlyphs(_font, kCTFontDefaultOrientation, glyphs, _characterFrames, len);
    //    free(characters); free(glyphs);
    //
    //    // Measure how mush specec will be needed for this attributed string
    //    // So we can find minimun frame needed
    //    CFRange fitRange;
    //    CGSize s = CTFramesetterSuggestFrameSizeWithConstraints(_framesetter, rangeAll, NULL, CGSizeMake(W, MAXFLOAT), &fitRange);
    //
    //    _frameRect = CGRectMake(0, 0, s.width, s.height);
    //    CGPathRef framePath = CGPathCreateWithRect(_frameRect, NULL);
    //    _ctFrame = CTFramesetterCreateFrame(_framesetter, rangeAll, framePath, NULL);
    //    CGPathRelease(framePath);
    //
    //    // Get the lines in our frame
    //    NSArray* lines = (NSArray*)CTFrameGetLines(_ctFrame);
    //    _lineCount = [lines count];
    //
    //    // Allocate memory to hold line frames information:
    //    if (_lineOrigins != NULL)free(_lineOrigins);
    //    _lineOrigins = malloc(sizeof(CGPoint) * _lineCount);
    //
    //    if (_lineFrames != NULL)free(_lineFrames);
    //    _lineFrames = malloc(sizeof(CGRect) * _lineCount);
    //
    //    // Get the origin point of each of the lines
    //    CTFrameGetLineOrigins(_ctFrame, CFRangeMake(0, 0), _lineOrigins);
    //
    //    // Solution borrowew from (but simplified):
    //    // https://github.com/twitter/twui/blob/master/lib/Support/CoreText%2BAdditions.m
    //
    //
    //    // Loop throught the lines
    //    for(CFIndex i = 0; i < _lineCount; ++i) {
    //
    //    CTLineRef line = (__bridge CTLineRef)[lines objectAtIndex:i];
    //
    //    CFRange lineRange = CTLineGetStringRange(line);
    //    CFIndex lineStartIndex = lineRange.location;
    //    CFIndex lineEndIndex = lineStartIndex + lineRange.length;
    //
    //    CGPoint lineOrigin = _lineOrigins[i];
    //    CGFloat ascent, descent, leading;
    //    CGFloat lineWidth = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    //
    //
    //    // If we have more than 1 line, we want to find the real height of the line by measuring the distance between the current line and previous line. If it's only 1 line, then we'll guess the line's height.
    //    BOOL useRealHeight = i < _lineCount - 1;
    //    CGFloat neighborLineY = i > 0 ? _lineOrigins[i - 1].y : (_lineCount - 1 > i ? _lineOrigins[i + 1].y : 0.0f);
    //    CGFloat lineHeight = ceil(useRealHeight ? abs(neighborLineY - lineOrigin.y) : ascent + descent + leading);
    //
    //    _lineFrames[i].origin = lineOrigin;
    //    _lineFrames[i].size = CGSizeMake(lineWidth, lineHeight);
    //
    //    for (int ic = lineStartIndex; ic < lineEndIndex; ic++) {
    //
    //
    //    CGFloat startOffset = CTLineGetOffsetForStringIndex(line, ic, NULL);
    //
    //    // wrong:
    //    //_characterFrames[ic].origin = CGPointMake(startOffset, lineOrigin.y);
    //
    //    //better:
    //    //    characterFrames[ic].origin.x += startOffset;
    //    //    _characterFrames[ic].origin.y += lineOrigin.y;
    //
    //    //best:
    //    _characterFrames[ic] = CGRectOffset(_characterFrames[ic], startOffset, lineOrigin.y);
    //    }
    //    }
    //    }
    //
    //
    //    #pragma mark - Rendering Text:
    //
    //    -(void)renderInContext:(CGContextRef)context contextSize:(CGSize)size{
    //
    //    CGContextSaveGState(context);
    //
    //    // Draw Core Text attributes string:
    //    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //    CGContextTranslateCTM(context, 0, CGRectGetHeight(_frameRect));
    //    CGContextScaleCTM(context, 1.0, -1.0);
    //
    //    CTFrameDraw(_ctFrame, context);
    //
    //    // Draw line and letter frames:
    //    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.5].CGColor);
    //    CGContextSetLineWidth(context, 1.0);
    //
    //    CGContextBeginPath(context);
    //    CGContextAddRects(context, _lineFrames, _lineCount);
    //    CGContextClosePath(context);
    //    CGContextStrokePath(context);
    //
    //    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5].CGColor);
    //    CGContextBeginPath(context);
    //    CGContextAddRects(context, _characterFrames, _attributedString.string.length);
    //    CGContextClosePath(context);
    //    CGContextStrokePath(context);
    //
    //    CGContextRestoreGState(context);
    //
    //    }
    //
    //
    
    
    
    
    
    //draw Attributed String
    //        let text: NSString = "Y"
    //        let font = NSFont(name: "Helvetica Bold", size: 14.0)
    //
    //        let textRect: NSRect = NSMakeRect(5, 3, 125, 18)
    //        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
    //        textStyle.alignment = NSTextAlignment.center
    //        let textColor = NSColor(calibratedRed: 0.147, green: 0.222, blue: 0.162, alpha: 1.0)
    //
    //        let textFontAttributes = [
    //            NSAttributedStringKey.font: font! ,
    //            NSAttributedStringKey.foregroundColor: textColor,
    //            NSAttributedStringKey.paragraphStyle: textStyle
    //        ]
    //        text.draw(in: NSOffsetRect(textRect, 0, 1), withAttributes: textFontAttributes)
    
}
