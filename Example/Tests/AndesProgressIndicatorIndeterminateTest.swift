//
//  AndesProgressIndicatorIndeterminateTest.swift
//  AndesUI_Tests
//
//  Created by Juan Andres Vasquez Ferrer on 03-12-20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesProgressIndicatorIndeterminateTest: QuickSpec {

    override func spec() {
        describe("AndesProgressIndicatorIndeterminate should draw its view with circular style") {

            context("AndesProgressIndicatorIndeterminate with some sizes") {

                it("Should be an AndesProgressIndicatorCircularView subclass using large size") {
                    let progressIndicator = AndesProgressIndicatorIndeterminate(size: .large, tint: UIColor.blue)
                    expect(progressIndicator.contentView.isKind(of: AndesProgressIndicatorViewCircular.self)).to(beTrue())
                }

                it("Should be an AndesProgressIndicatorCircularView subclass using medium size") {
                    let progressIndicator = AndesProgressIndicatorIndeterminate(size: .medium, tint: UIColor.blue)
                    expect(progressIndicator.contentView.isKind(of: AndesProgressIndicatorViewCircular.self)).to(beTrue())
                }

                it("Should be an AndesProgressIndicatorCircularView subclass using small size") {
                    let progressIndicator = AndesProgressIndicatorIndeterminate(size: .small, tint: UIColor.blue)
                    expect(progressIndicator.contentView.isKind(of: AndesProgressIndicatorViewCircular.self)).to(beTrue())
                }

                it("Large size should have a specific style") {
                    let progressIndicator = AndesProgressIndicatorIndeterminate(size: .large, tint: UIColor.blue)
                    guard let contentView = progressIndicator.contentView as? AndesProgressIndicatorViewCircular else {
                        fail()
                        return
                    }

                    let expectedFont = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 16)

                    expect(contentView.config.size?.height).to(equal(48))
                    expect(contentView.config.size?.strokeWidth).to(equal(4))
                    expect(contentView.config.size?.textSpacing).to(equal(20))
                    expect(contentView.config.size?.textFont).to(equal(expectedFont))
                }

                it("Medium size should have a specific style") {
                    let progressIndicator = AndesProgressIndicatorIndeterminate(size: .medium, tint: UIColor.blue)
                    guard let contentView = progressIndicator.contentView as? AndesProgressIndicatorViewCircular else {
                        fail()
                        return
                    }

                    let expectedFont = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 14)

                    expect(contentView.config.size?.height).to(equal(32))
                    expect(contentView.config.size?.strokeWidth).to(equal(3))
                    expect(contentView.config.size?.textSpacing).to(equal(16))
                    expect(contentView.config.size?.textFont).to(equal(expectedFont))
                }

                it("Small size should have a specific style") {
                    let progressIndicator = AndesProgressIndicatorIndeterminate(size: .small, tint: UIColor.blue)
                    guard let contentView = progressIndicator.contentView as? AndesProgressIndicatorViewCircular else {
                        fail()
                        return
                    }

                    let expectedFont = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 14)

                    expect(contentView.config.size?.height).to(equal(24))
                    expect(contentView.config.size?.strokeWidth).to(equal(2.5))
                    expect(contentView.config.size?.textSpacing).to(equal(16))
                    expect(contentView.config.size?.textFont).to(equal(expectedFont))
                }
            }

            context("AndesProgressIndicatorIndeterminate with animations") {

                it("Should be an infinite animation when startAnimation is called") {
                    // given
                    let progressIndicator = AndesProgressIndicatorIndeterminate(size: .large, tint: UIColor.blue)

                    guard let contentView = progressIndicator.contentView as? AndesProgressIndicatorViewCircular else {
                        fail()
                        return
                    }

                    // when
                    progressIndicator.startAnimation()

                    // then
                    let numberOfanimations = contentView.circularProgressBar.layer.mask?.animationKeys()?.count ?? 0

                    let containAnimations = numberOfanimations > 0
                    expect(containAnimations).to(beTrue())
                }

                it("Should be an removeAllAnimations when stopAnimation is called") {
                    // given
                    let progressIndicator = AndesProgressIndicatorIndeterminate(size: .large, tint: UIColor.blue)

                    guard let contentView = progressIndicator.contentView as? AndesProgressIndicatorViewCircular else {
                        fail()
                        return
                    }

                    // when
                    progressIndicator.startAnimation()
                    progressIndicator.stopAnimation()

                    // then
                    let numberOfanimations = contentView.circularProgressBar.layer.mask?.animationKeys()?.count ?? 0

                    let containAnimations = numberOfanimations > 0
                    expect(containAnimations).to(beFalse())
                }
            }
        }

        describe("AndesProgressIndicatorIndeterminate should draw its view with specific params") {
            context("Passing data via init") {

                it("It should show the specific data") {
                    let progressIndicator = AndesProgressIndicatorIndeterminate(size: .large, tint: .blue, textColor: .red, label: "testing")

                    guard let contentView = progressIndicator.contentView as? AndesProgressIndicatorViewCircular else {
                        fail()
                        return
                    }

                    expect(contentView.textLabel.text).to(equal("testing"))
                    expect(contentView.circularProgressBar.color).to(equal(.blue))
                    expect(contentView.textLabel.textColor).to(equal(.red))
                    expect(contentView.config.size).to(beAKindOf(AndesProgressIndicatorSizeLarge.self))
                }
            }

            context("Passing data via property") {

                it("It should show the specific data") {
                    let progressIndicator = AndesProgressIndicatorIndeterminate()

                    progressIndicator.size = .large
                    progressIndicator.tint = .blue
                    progressIndicator.textColor = .red
                    progressIndicator.label = "testing"

                    guard let contentView = progressIndicator.contentView as? AndesProgressIndicatorViewCircular else {
                        fail()
                        return
                    }

                    expect(contentView.textLabel.text).to(equal("testing"))
                    expect(contentView.circularProgressBar.color).to(equal(.blue))
                    expect(contentView.textLabel.textColor).to(equal(.red))
                    expect(contentView.config.size).to(beAKindOf(AndesProgressIndicatorSizeLarge.self))
                }
            }
        }
    }
}
