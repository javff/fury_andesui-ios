//
//  AndesBaseTooltipView.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//

import Foundation
import UIKit

struct AndesBaseTooltipExternalConfig {
    let backgroundColor: UIColor
    let foregroundColor: UIColor
}

private struct AndesBaseTooltipInternalConfig {

    struct Positioning {
        let contentInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let maxWidth = CGFloat(200)
     }

    struct Drawing {
        let cornerRadius = CGFloat(5)
        let arrowHeight = CGFloat(5)
        let arrowWidth = CGFloat(10)
        let borderWidth = CGFloat(0)
        let borderColor = UIColor.clear
        let shadowColor = UIColor.gray
        let shadowOffset = CGSize(width: 2, height: 2)
        let shadowRadius = CGFloat(12)
        let shadowOpacity = CGFloat(0.7)
    }

    struct Animating {
        let dismissTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let showInitialTransform = CGAffineTransform(scaleX: 0, y: 0)
        let showFinalTransform = CGAffineTransform.identity
        let springDamping = CGFloat(0.7)
        let springVelocity = CGFloat(0.7)
        let showInitialAlpha = CGFloat(0)
        let dismissFinalAlpha = CGFloat(0)
        let showDuration = 0.7
        let dismissDuration = 0.7
        let dismissOnTap = true
    }

    let drawing = Drawing()
    let positioning = Positioning()
    let animating = Animating()
}

extension AndesBaseTooltipView {

    func show(forView view: UIView, withinSuperview superview: UIView) {

        let initialTransform = internalConfig.animating.showInitialTransform
        let finalTransform = internalConfig.animating.showFinalTransform
        let initialAlpha = internalConfig.animating.showInitialAlpha

        presentingView = view
        arrange(withinSuperview: superview)

        transform = initialTransform
        alpha = initialAlpha

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)

        superview.addSubview(self)

        let animationDuration = internalConfig.animating.showDuration
        let damping = internalConfig.animating.springDamping
        let velocity = internalConfig.animating.springVelocity

        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [.curveEaseInOut], animations: {
            self.transform = finalTransform
            self.alpha = 1
        })
    }

    func dismiss(withCompletion completion: (() -> Void)? = nil) {

        let damping = internalConfig.animating.springDamping
        let velocity = internalConfig.animating.springVelocity
        let dismissTransform = internalConfig.animating.dismissTransform
        let dismissAlpha = internalConfig.animating.dismissFinalAlpha

        UIView.animate(withDuration: internalConfig.animating.dismissDuration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [.curveEaseInOut], animations: {
            self.transform = dismissTransform
            self.alpha = dismissAlpha
        }) { (_) -> Void in
            completion?()
            self.removeFromSuperview()
        }
    }
}

enum AndesBaseTooltipArrowPosition: CaseIterable {
    case bottom
    case top
    case right
    case left
}

class AndesBaseTooltipView: UIView {

    // MARK: - Variables

    fileprivate weak var presentingView: UIView?
    fileprivate var arrowTip = CGPoint.zero
    private let externalConfig: AndesBaseTooltipExternalConfig
    private let content: UIView
    private let internalConfig = AndesBaseTooltipInternalConfig()
    var arrowPosition: AndesBaseTooltipArrowPosition = .right

    // MARK: - Lazy variables
    lazy var contentSize: CGSize = {
        let horizontalPriority = UILayoutPriority(750)
        let verticalPriority = UILayoutPriority(749)
        let targetWidth = self.internalConfig.positioning.maxWidth
        let targetSize = CGSize(width: targetWidth, height: 0)

        let candidateSize = content.systemLayoutSizeFitting(.zero)
        let size = candidateSize.width <= targetWidth ? candidateSize :
         content.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: horizontalPriority,
            verticalFittingPriority: verticalPriority
        )
        return size
    }()

    lazy var tipViewSize: CGSize = {
        let width = self.contentSize.width +
            self.internalConfig.positioning.contentInsets.left + self.internalConfig.positioning.contentInsets.right

        let height = self.contentSize.height + self.internalConfig.positioning.contentInsets.top + self.internalConfig.positioning.contentInsets.bottom
            //+self.internalConfig.drawing.arrowHeight

        return CGSize(width: width, height: height)
    }()

    // MARK: - Initializer -

    internal init (content: UIView, config: AndesBaseTooltipExternalConfig) {
        self.content = content
        self.externalConfig = config
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods -
    fileprivate func computeFrame(arrowPosition position: AndesBaseTooltipArrowPosition, refViewFrame: CGRect, superviewFrame: CGRect) -> CGRect {
        let xOrigin: CGFloat
        let yOrigin: CGFloat

        switch position {
        case .top:
            xOrigin = refViewFrame.center.x - tipViewSize.width / 2
            yOrigin = refViewFrame.maxY
        case .bottom:
            xOrigin = refViewFrame.center.x - tipViewSize.width / 2
            yOrigin = refViewFrame.y - tipViewSize.height
        case .right:
            xOrigin = refViewFrame.x - tipViewSize.width
            yOrigin = refViewFrame.center.y - tipViewSize.height / 2
        case .left:
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
        var position = arrowPosition
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

    fileprivate func createValidFrame(_ frame: CGRect, currentPosition: AndesBaseTooltipArrowPosition, refViewFrame: CGRect, superViewFrame: CGRect) -> (CGRect, AndesBaseTooltipArrowPosition) {

        var newFrame: CGRect = .zero
        var newPosition: AndesBaseTooltipArrowPosition = .bottom

        for value in AndesBaseTooltipArrowPosition.allCases where value != currentPosition {
            let frame = computeFrame(arrowPosition: value, refViewFrame: refViewFrame, superviewFrame: superViewFrame)
            if isFrameValid(frame, forRefViewFrame: refViewFrame, superViewFrame: superViewFrame) {
                newFrame = frame
                newPosition = value
                arrowPosition = value
                break
            }
        }

        return (newFrame, newPosition)
    }

    fileprivate func calculateArrowTipPoint(frame: CGRect, position: AndesBaseTooltipArrowPosition, refViewFrame: CGRect) -> CGPoint {
        switch position {
        case .bottom, .top:
            let arrowTipXOrigin: CGFloat
            if frame.width < refViewFrame.width {
                arrowTipXOrigin = tipViewSize.width / 2
            } else {
                arrowTipXOrigin = abs(frame.x - refViewFrame.x) + refViewFrame.width / 2
            }

            let yPosition = position == .bottom ? tipViewSize.height : 0

            return CGPoint(x: arrowTipXOrigin, y: yPosition)

        case .right, .left:
            let arrowTipYOrigin: CGFloat
            if frame.height < refViewFrame.height {
                arrowTipYOrigin = tipViewSize.height / 2
            } else {
                arrowTipYOrigin = abs(frame.y - refViewFrame.y) + refViewFrame.height / 2
            }

            let xPosition = arrowPosition == .left ? 0 : tipViewSize.width

            return CGPoint(x: xPosition, y: arrowTipYOrigin)

        }
    }

    // MARK: - Callbacks -

    @objc func handleTap() {
        guard internalConfig.animating.dismissOnTap else { return }
        dismiss()
    }

    // MARK: - Drawing -

    fileprivate func drawBubble(_ bubbleFrame: CGRect, arrowPosition: AndesBaseTooltipArrowPosition, context: CGContext) {

        let arrowWidth = internalConfig.drawing.arrowWidth
        let arrowHeight = internalConfig.drawing.arrowHeight
        let cornerRadius = internalConfig.drawing.cornerRadius

        let contourPath = CGMutablePath()

        contourPath.move(to: CGPoint(x: arrowTip.x, y: arrowTip.y))

        switch arrowPosition {

        case .bottom, .top:

            let firstLineX = arrowTip.x - arrowWidth / 2
            let firstLineY = arrowTip.y + (arrowPosition == .bottom ? -1 : 1) * arrowHeight
            let firstLinePoint = CGPoint(x: firstLineX, y: firstLineY)
            contourPath.addLine(to: firstLinePoint)

            if arrowPosition == .bottom {
                drawBubbleBottomShape(bubbleFrame, cornerRadius: cornerRadius, path: contourPath)
            } else {
                drawBubbleTopShape(bubbleFrame, cornerRadius: cornerRadius, path: contourPath)
            }

            let secondLineX = arrowTip.x + arrowWidth / 2
            let secondLineY = arrowTip.y + (arrowPosition == .bottom ? -1 : 1) * arrowHeight
            let pointRight = CGPoint(x: secondLineX, y: secondLineY)
            contourPath.addLine(to: pointRight)

        case .right, .left:

            let firstLineX = arrowTip.x + (arrowPosition == .right ? -1 : 1) * arrowHeight
            let firstLineY = arrowTip.y - arrowWidth / 2
            let firstLinePoint = CGPoint(x: firstLineX, y: firstLineY)
            contourPath.addLine(to: firstLinePoint)

            if arrowPosition == .right {
                drawBubbleRightShape(bubbleFrame, cornerRadius: cornerRadius, path: contourPath)
            } else {
                drawBubbleLeftShape(bubbleFrame, cornerRadius: cornerRadius, path: contourPath)
            }

            let secondLineX = arrowTip.x + (arrowPosition == .right ? -1 : 1) * arrowHeight
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

        path.addArc(tangent1End: CGPoint(x: frame.x, y: frame.y), tangent2End: CGPoint(x: frame.x, y: frame.y + frame.height), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x, y: frame.y + frame.height), tangent2End: CGPoint(x: frame.x + frame.width, y: frame.y + frame.height), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x + frame.width, y: frame.y + frame.height), tangent2End: CGPoint(x: frame.x + frame.width, y: frame.y), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x + frame.width, y: frame.y), tangent2End: CGPoint(x: frame.x, y: frame.y), radius: cornerRadius)
    }

    fileprivate func drawBubbleRightShape(_ frame: CGRect, cornerRadius: CGFloat, path: CGMutablePath) {

        path.addArc(tangent1End: CGPoint(x: frame.x + frame.width, y: frame.y), tangent2End: CGPoint(x: frame.x, y: frame.y), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x, y: frame.y), tangent2End: CGPoint(x: frame.x, y: frame.y + frame.height), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x, y: frame.y + frame.height), tangent2End: CGPoint(x: frame.x + frame.width, y: frame.y + frame.height), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x + frame.width, y: frame.y + frame.height), tangent2End: CGPoint(x: frame.x + frame.width, y: frame.height), radius: cornerRadius)

    }

    fileprivate func drawBubbleLeftShape(_ frame: CGRect, cornerRadius: CGFloat, path: CGMutablePath) {

        path.addArc(tangent1End: CGPoint(x: frame.x, y: frame.y), tangent2End: CGPoint(x: frame.x + frame.width, y: frame.y), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x + frame.width, y: frame.y), tangent2End: CGPoint(x: frame.x + frame.width, y: frame.y + frame.height), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x + frame.width, y: frame.y + frame.height), tangent2End: CGPoint(x: frame.x, y: frame.y + frame.height), radius: cornerRadius)
        path.addArc(tangent1End: CGPoint(x: frame.x, y: frame.y + frame.height), tangent2End: CGPoint(x: frame.x, y: frame.y), radius: cornerRadius)
    }

    fileprivate func paintBubble(_ context: CGContext) {
        context.setFillColor(externalConfig.backgroundColor.cgColor)
        context.fill(bounds)
    }

    fileprivate func drawShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = internalConfig.drawing.shadowColor.cgColor
        self.layer.shadowOffset = internalConfig.drawing.shadowOffset
        self.layer.shadowRadius = internalConfig.drawing.shadowRadius
        self.layer.shadowOpacity = Float(internalConfig.drawing.shadowOpacity)
    }

    override open func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let bubbleFrame = getBubbleFrame()
        context.saveGState()
        drawBubble(bubbleFrame, arrowPosition: arrowPosition, context: context)
        setupContentView()
        drawShadow()
        context.restoreGState()
    }

    private func setupContentView() {
        addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: topAnchor, constant: internalConfig.positioning.contentInsets.top),
            content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -internalConfig.positioning.contentInsets.right),
            content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: internalConfig.positioning.contentInsets.left),
            content.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -internalConfig.positioning.contentInsets.bottom)
        ])
    }

    private func getBubbleFrame() -> CGRect {
        let bubbleWidth: CGFloat
        let bubbleHeight: CGFloat
        let bubbleXOrigin: CGFloat
        let bubbleYOrigin: CGFloat

        switch arrowPosition {
        case .bottom, .top:

            bubbleWidth = tipViewSize.width
            bubbleHeight = tipViewSize.height - internalConfig.drawing.arrowHeight

            bubbleXOrigin = 0
            bubbleYOrigin = arrowPosition == .bottom ? 0 : internalConfig.drawing.arrowHeight

        case .left, .right:

            bubbleWidth = tipViewSize.width - internalConfig.drawing.arrowHeight
            bubbleHeight = tipViewSize.height

            bubbleXOrigin = arrowPosition == .right ? 0 : internalConfig.drawing.arrowHeight
            bubbleYOrigin = 0
        }

        return CGRect(x: bubbleXOrigin, y: bubbleYOrigin, width: bubbleWidth, height: bubbleHeight)
    }

    private func getContentRect(from bubbleFrame: CGRect) -> CGRect {
        return CGRect(x: bubbleFrame.origin.x + internalConfig.positioning.contentInsets.left, y: bubbleFrame.origin.y + internalConfig.positioning.contentInsets.top, width: contentSize.width, height: contentSize.height)
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
