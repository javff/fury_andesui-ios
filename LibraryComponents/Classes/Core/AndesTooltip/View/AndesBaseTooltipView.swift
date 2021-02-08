//
//  AndesBaseTooltipView.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//

import Foundation
import UIKit

extension AndesBaseTooltipView {

    func show(target targetView: UIView, withinSuperview superview: UIView) {

        presentingView = targetView
        arrange(withinSuperview: superview)
        superview.addSubview(self)

        transform = CGAffineTransform(translationX: 0, y: animationTransform)
        alpha = 0

        UIView.animate(withDuration: self.animationDuration, delay: 0, options: [.curveEaseInOut], animations: {
            self.alpha = 1
            self.transform = .identity
        })
    }

    func dismiss(withCompletion completion: (() -> Void)? = nil) {

        UIView.animate(withDuration: self.animationDuration, delay: 0, options: [.curveEaseInOut], animations: {
            self.frame.origin.y += self.animationTransform
            self.alpha = 0
        }) { (_) -> Void in
            completion?()
            self.removeFromSuperview()
        }
    }
}

enum AndesTooltipPosition: CaseIterable {
    case top
    case bottom
    case left
    case right
}

class AndesBaseTooltipView: UIView {

    // MARK: - properties

    private weak var presentingView: UIView?
    private var arrowTip = CGPoint.zero
    private let config: AndesTooltipViewConfig
    private let content: UIView
    private let cornerRadius: CGFloat = 6
    private var bubblePosition: AndesTooltipPosition = .top

    // arrow properties
    private let arrowHeight: CGFloat = 8
    private let arrowWidth: CGFloat = 16

    // Animations properties
    private let animationDuration: TimeInterval = 0.2
    private let animationTransform: CGFloat = -10

    // MARK: - Lazy properties -

    private lazy var contentSize: CGSize = {
        let horizontalPriority = UILayoutPriority(750)
        let verticalPriority = UILayoutPriority(749)
        let maxWidthSize = config.maxWidth
        let targetSize = CGSize(width: maxWidthSize, height: 0)

        let candidateSize = content.systemLayoutSizeFitting(.zero)

        let sizeIsEnough = candidateSize.width <= maxWidthSize

        if sizeIsEnough {
            return candidateSize
        }

        return content.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: horizontalPriority,
            verticalFittingPriority: verticalPriority
        )
    }()

    // MARK: - Initializer -

    internal init (
        content: UIView,
        position: AndesTooltipPosition = .top,
        config: AndesTooltipViewConfig) {
        self.content = content
        self.config = config
        self.bubblePosition = position
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods -
    fileprivate func computeFrame(arrowPosition position: AndesTooltipPosition, refViewFrame: CGRect, superviewFrame: CGRect) -> CGRect {
        let xOrigin: CGFloat
        let yOrigin: CGFloat
        let tipViewSize = getTipViewSize(position: self.bubblePosition)

        switch position {
        case .bottom:
            xOrigin = refViewFrame.center.x - tipViewSize.width / 2
            yOrigin = refViewFrame.maxY
        case .top:
            xOrigin = refViewFrame.center.x - tipViewSize.width / 2
            yOrigin = refViewFrame.y - tipViewSize.height
        case .left:
            xOrigin = refViewFrame.x - tipViewSize.width
            yOrigin = refViewFrame.center.y - tipViewSize.height / 2
        case .right:
            xOrigin = refViewFrame.x + refViewFrame.width
            yOrigin = refViewFrame.center.y - tipViewSize.height / 2
        }

        var frame = CGRect(x: xOrigin, y: yOrigin, width: tipViewSize.width, height: tipViewSize.height)

        frame.origin = adjustFrame(frame, forSuperviewFrame: superviewFrame, refViewFrame: refViewFrame)

        return frame
    }

    fileprivate func adjustFrame(_ frame: CGRect, forSuperviewFrame superviewFrame: CGRect, refViewFrame: CGRect) -> CGPoint {

        var adjustXFrame: CGFloat = frame.x
        var adjustYFrame: CGFloat = frame.y

        // adjust horizontally
        if frame.x < 0 {
            adjustXFrame =  refViewFrame.x
        }

        if frame.maxX > superviewFrame.width {
            adjustXFrame = superviewFrame.width - frame.width - (superviewFrame.width - refViewFrame.maxX)
        }

        //adjust vertically
        if frame.y < 0 {
            adjustYFrame = refViewFrame.y
        }

        if frame.maxY > superviewFrame.height {
            adjustYFrame = superviewFrame.height - frame.height - (superviewFrame.height - refViewFrame.maxY)
        }

        return CGPoint(x: adjustXFrame, y: adjustYFrame)
    }

    fileprivate func isFrameValid(_ frame: CGRect, forRefViewFrame: CGRect, superViewFrame: CGRect) -> Bool {
        return !frame.intersects(forRefViewFrame) &&
            frame.maxY < superViewFrame.height && frame.maxX < superViewFrame.maxX
    }

    fileprivate func arrange(withinSuperview superview: UIView) {

        guard let presentingView = presentingView else { return }
        var position = bubblePosition
        let refViewFrame = presentingView.convert(presentingView.bounds, to: superview)

        let superviewFrame: CGRect
        if let scrollview = superview as? UIScrollView {
            superviewFrame = CGRect(origin: scrollview.frame.origin, size: scrollview.contentSize)
        } else {
            superviewFrame = superview.frame
        }

        var frame = computeFrame(arrowPosition: position, refViewFrame: refViewFrame, superviewFrame: superviewFrame)

        if !isFrameValid(frame, forRefViewFrame: refViewFrame, superViewFrame: superviewFrame) {
            let (newFrame, newPosition) = createValidFrame(
                frame,
                currentPosition: position,
                refViewFrame: refViewFrame,
                superViewFrame: superviewFrame
            )
            frame = newFrame
            position = newPosition
        }

        self.arrowTip = calculateArrowTipPoint(frame: frame, position: position, refViewFrame: refViewFrame)

        self.frame = frame
    }

    fileprivate func createValidFrame(_ frame: CGRect, currentPosition: AndesTooltipPosition, refViewFrame: CGRect, superViewFrame: CGRect) -> (CGRect, AndesTooltipPosition) {

        var newFrame: CGRect = .zero
        var newPosition: AndesTooltipPosition = .top

        for value in AndesTooltipPosition.allCases where value != currentPosition {
            let frame = computeFrame(arrowPosition: value, refViewFrame: refViewFrame, superviewFrame: superViewFrame)
            if isFrameValid(frame, forRefViewFrame: refViewFrame, superViewFrame: superViewFrame) {
                newFrame = frame
                newPosition = value
                bubblePosition = value
                break
            }
        }

        return (newFrame, newPosition)
    }

    fileprivate func calculateArrowTipPoint(frame: CGRect, position: AndesTooltipPosition, refViewFrame: CGRect) -> CGPoint {

        let tipViewSize = self.getTipViewSize(position: position)

        switch position {
        case .top, .bottom:
            let arrowTipXOrigin: CGFloat
            if frame.width < refViewFrame.width {
                arrowTipXOrigin = tipViewSize.width / 2
            } else {
                arrowTipXOrigin = abs(frame.x - refViewFrame.x) + refViewFrame.width / 2
            }

            let yPosition = position == .top ? tipViewSize.height : 0

            return CGPoint(x: arrowTipXOrigin, y: yPosition)

        case .left, .right:
            let arrowTipYOrigin: CGFloat
            if frame.height < refViewFrame.height {
                arrowTipYOrigin = tipViewSize.height / 2
            } else {
                arrowTipYOrigin = abs(frame.y - refViewFrame.y) + refViewFrame.height / 2
            }

            let xPosition = bubblePosition == .right ? 0 : tipViewSize.width

            return CGPoint(x: xPosition, y: arrowTipYOrigin)

        }
    }

    // MARK: - Drawing -

    fileprivate func drawBubble(_ bubbleFrame: CGRect, arrowPosition: AndesTooltipPosition, context: CGContext) {

        let contourPath = CGMutablePath()

        contourPath.move(to: CGPoint(x: arrowTip.x, y: arrowTip.y))

        switch arrowPosition {

        case .top, .bottom:

            let firstLineX = arrowTip.x - arrowWidth / 2
            let firstLineY = arrowTip.y + (arrowPosition == .top ? -1 : 1) * arrowHeight
            let firstLinePoint = CGPoint(x: firstLineX, y: firstLineY)
            contourPath.addLine(to: firstLinePoint)

            if arrowPosition == .top {
                drawBubbleBottomShape(bubbleFrame, cornerRadius: cornerRadius, path: contourPath)
            } else {
                drawBubbleTopShape(bubbleFrame, cornerRadius: cornerRadius, path: contourPath)
            }

            let secondLineX = arrowTip.x + arrowWidth / 2
            let secondLineY = arrowTip.y + (arrowPosition == .top ? -1 : 1) * arrowHeight
            let pointRight = CGPoint(x: secondLineX, y: secondLineY)
            contourPath.addLine(to: pointRight)

        case .left, .right:

            let firstLineX = arrowTip.x + (arrowPosition == .left ? -1 : 1) * arrowHeight
            let firstLineY = arrowTip.y - arrowWidth / 2
            let firstLinePoint = CGPoint(x: firstLineX, y: firstLineY)
            contourPath.addLine(to: firstLinePoint)

            if arrowPosition == .left {
                drawBubbleRightShape(bubbleFrame, cornerRadius: cornerRadius, path: contourPath)
            } else {
                drawBubbleLeftShape(bubbleFrame, cornerRadius: cornerRadius, path: contourPath)
            }

            let secondLineX = arrowTip.x + (arrowPosition == .left ? -1 : 1) * arrowHeight
            let secondLineY = arrowTip.y + arrowWidth / 2
            let pointRight = CGPoint(x: secondLineX, y: secondLineY)
            contourPath.addLine(to: pointRight)
        }

        contourPath.closeSubpath()
        context.addPath(contourPath)
        context.clip()

        paintBubble(context)
    }

    fileprivate func drawBubbleBottomShape(_ frame: CGRect, cornerRadius: CGFloat, path: CGMutablePath) {

        path.addArc(tangent1End: CGPoint(x: frame.x, y: frame.y + frame.height), tangent2End: CGPoint(x: frame.x, y: frame.y), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x, y: frame.y), tangent2End: CGPoint(x: frame.x + frame.width, y: frame.y), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x + frame.width, y: frame.y), tangent2End: CGPoint(x: frame.x + frame.width, y: frame.y + frame.height), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x + frame.width, y: frame.y + frame.height), tangent2End: CGPoint(x: frame.x, y: frame.y + frame.height), radius: cornerRadius)
    }

    fileprivate func drawBubbleTopShape(_ frame: CGRect, cornerRadius: CGFloat, path: CGMutablePath) {

        let arc1FirstTangent = CGPoint(x: frame.x, y: frame.y)
        let arc1SecondTangent = CGPoint(x: frame.x, y: frame.y + frame.height)
        path.addArc(tangent1End: arc1FirstTangent,
                    tangent2End: arc1SecondTangent,
                    radius: cornerRadius)

        let arc2FirstTangent = CGPoint(x: frame.x, y: frame.y + frame.height)
        let arc2SecondTangent = CGPoint(x: frame.x + frame.width, y: frame.y + frame.height)
        path.addArc(tangent1End: arc2FirstTangent,
                    tangent2End: arc2SecondTangent,
                    radius: cornerRadius)

        let arc3FirstTangent = CGPoint(x: frame.x + frame.width, y: frame.y + frame.height)
        let arc3SecondTangent = CGPoint(x: frame.x + frame.width, y: frame.y)
        path.addArc(tangent1End: arc3FirstTangent,
                    tangent2End: arc3SecondTangent,
                    radius: cornerRadius)

        let arc4FirstTangent = CGPoint(x: frame.x + frame.width, y: frame.y)
        let arc4SecondTangent = CGPoint(x: frame.x, y: frame.y)
        path.addArc(tangent1End: arc4FirstTangent,
                    tangent2End: arc4SecondTangent,
                    radius: cornerRadius)
    }

    fileprivate func drawBubbleRightShape(_ frame: CGRect, cornerRadius: CGFloat, path: CGMutablePath) {

        let arc1FirstTangent = CGPoint(x: frame.x + frame.width, y: frame.y)
        let arc1SecondTangent = CGPoint(x: frame.x, y: frame.y)
        path.addArc(tangent1End: arc1FirstTangent,
                    tangent2End: arc1SecondTangent,
                    radius: cornerRadius)

        let arc2FirstTangent = CGPoint(x: frame.x, y: frame.y)
        let arc2SecondTangent = CGPoint(x: frame.x, y: frame.y + frame.height)
        path.addArc(tangent1End: arc2FirstTangent,
                    tangent2End: arc2SecondTangent,
                    radius: cornerRadius)

        let arc3FirstTangent = CGPoint(x: frame.x, y: frame.y + frame.height)
        let arc3SecondTangent = CGPoint(x: frame.x + frame.width, y: frame.y + frame.height)
        path.addArc(tangent1End: arc3FirstTangent,
                    tangent2End: arc3SecondTangent,
                    radius: cornerRadius)

        let arc4FirstTangent = CGPoint(x: frame.x + frame.width, y: frame.y + frame.height)
        let arc4SecondTangent = CGPoint(x: frame.x + frame.width, y: frame.y)
        path.addArc(tangent1End: arc4FirstTangent,
                    tangent2End: arc4SecondTangent,
                    radius: cornerRadius)
    }

    fileprivate func drawBubbleLeftShape(_ frame: CGRect, cornerRadius: CGFloat, path: CGMutablePath) {

        path.addArc(tangent1End: CGPoint(x: frame.x, y: frame.y), tangent2End: CGPoint(x: frame.x + frame.width, y: frame.y), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x + frame.width, y: frame.y), tangent2End: CGPoint(x: frame.x + frame.width, y: frame.y + frame.height), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x + frame.width, y: frame.y + frame.height), tangent2End: CGPoint(x: frame.x, y: frame.y + frame.height), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x, y: frame.y + frame.height), tangent2End: CGPoint(x: frame.x, y: frame.y), radius: cornerRadius)
    }

    fileprivate func paintBubble(_ context: CGContext) {
        context.setFillColor(config.backgroundColor.cgColor)
        context.fill(bounds)
    }

    fileprivate func drawShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        self.layer.shadowColor = internalConfig.drawing.shadowColor.cgColor
        self.layer.shadowOffset = config.shadowOffset
        self.layer.shadowRadius = config.shadowRadius
        self.layer.shadowOpacity = Float(config.shadowOpacity)
    }

    override open func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let bubbleFrame = getBubbleFrame()
        context.saveGState()
        drawBubble(bubbleFrame,
                   arrowPosition: bubblePosition,
                   context: context)
        setupContentView()
        drawShadow()
        context.restoreGState()
    }

    private func setupContentView() {

        let tipSize = self.arrowHeight

        let extraSpacingLeft = self.bubblePosition == .right ? tipSize : 0
        let extraSpacingRight = self.bubblePosition == .left ? tipSize : 0
        let extraSpacingTop = self.bubblePosition == .bottom ? tipSize : 0
        let extraSpacingBottom = self.bubblePosition == .top ? tipSize : 0

        addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(
                equalTo: topAnchor,
                constant: extraSpacingTop
            ),
            content.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -extraSpacingRight
            ),
            content.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: extraSpacingLeft
            ),
            bottomAnchor.constraint(
                equalTo: content.bottomAnchor,
                constant: extraSpacingBottom
            )
        ])
    }

    private func getBubbleFrame() -> CGRect {
        let bubbleWidth: CGFloat
        let bubbleHeight: CGFloat
        let bubbleXOrigin: CGFloat
        let bubbleYOrigin: CGFloat
        let tipViewSize = self.getTipViewSize(position: bubblePosition)

        switch bubblePosition {
        case .top, .bottom:

            bubbleWidth = tipViewSize.width
            bubbleHeight = tipViewSize.height - arrowHeight

            bubbleXOrigin = 0
            bubbleYOrigin = bubblePosition == .top ? 0 : arrowHeight

        case .right, .left:

            bubbleWidth = tipViewSize.width - arrowHeight
            bubbleHeight = tipViewSize.height

            bubbleXOrigin = bubblePosition == .left ? 0 : arrowHeight
            bubbleYOrigin = 0
        }

        return CGRect(x: bubbleXOrigin, y: bubbleYOrigin, width: bubbleWidth, height: bubbleHeight)
    }

    private func getContentRect(from bubbleFrame: CGRect) -> CGRect {
        return CGRect(
            x: bubbleFrame.origin.x,
            y: bubbleFrame.origin.y,
            width: contentSize.width,
            height: contentSize.height
        )
    }

    private func getTipViewSize(position: AndesTooltipPosition) -> CGSize {
        let width = contentSize.width
        let height = contentSize.height + arrowHeight
        return CGSize(width: width, height: height)
    }
}

// MARK: - UIView extension

fileprivate extension UIView {

    func hasSuperview(_ superview: UIView) -> Bool {
        return viewHasSuperview(self, superview: superview)
    }

    func viewHasSuperview(_ view: UIView, superview: UIView) -> Bool {
        guard let sView = view.superview else {
            return false
        }
        if sView === superview { return true }
        return viewHasSuperview(sView, superview: superview)
    }
}

// MARK: - CGRect extension -

fileprivate extension CGRect {
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self.origin.x = newValue
        }
    }

    var y: CGFloat {
        get {
            return self.origin.y
        }

        set {
            self.origin.y = newValue
        }
    }

    var center: CGPoint {
        return CGPoint(x: self.x + self.width / 2, y: self.y + self.height / 2)
    }
}
