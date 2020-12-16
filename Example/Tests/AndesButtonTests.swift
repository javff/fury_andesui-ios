//
//  AndesButtonTests.swift
//  AndesUI_Tests
//
//  Created by LEANDRO FURYK on 26/12/2019.
//  Copyright © 2019 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesButtonTests: QuickSpec {

    override func spec() {
        describe("AndesButton should draw its view depends on the style") {
            context("AndesButtonLarge is selected") {
                it("Should be an AndesButtonLargeLeftIcon subclass if icon is provided and orientation is left") {
                    //Given
                    let iconImage = UIImage(named: "andes")!
                    let icon = AndesButtonIcon(icon: iconImage, orientation: .left)
                    let title = "Comprar"

                    //When
                    let button = AndesButton(text: title, hierarchy: .loud, size: .large, icon: icon)

                    //Expect
                    expect(button.view.isKind(of: AndesButtonViewIconLeft.self)).to(beTrue())
                }

                it("Should be an AndesButtonLargeLeftIcon subclass if icon is provided and orientation is right") {
                    //Given
                    let iconImage = UIImage(named: "andes")!
                    let icon = AndesButtonIcon(icon: iconImage, orientation: .right)
                    let title = "Comprar"

                    //When
                    let button = AndesButton(text: title, hierarchy: .loud, size: .large, icon: icon)

                    //Expect
                    expect(button.view.isKind(of: AndesButtonViewIconRight.self)).to(beTrue())
                }

                it("Should be an AndesButtonDefaultView subclass if no icon is provided") {
                    //Given
                    let title = "Comprar"

                    //When
                    let button = AndesButton(text: title, hierarchy: .loud, size: .large)

                    //Expect
                    expect(button.view.isKind(of: AndesButtonViewDefault.self)).to(beTrue())
                }

                it("Should be an AndesButtonLargeLeftIcon subclass if no icon is provided but is setted after constructor") {
                    //Given
                    let title = "Comprar"
                    let icon = UIImage(named: "andes")!

                    //When
                    let button = AndesButton(text: title, hierarchy: .loud, size: .large)
                    button.setLargeSizeWithIcon(AndesButtonIcon(icon: icon, orientation: .left))

                    //Expect
                    expect(button.view.isKind(of: AndesButtonViewIconLeft.self)).to(beTrue())
                }
            }
        }

        describe("AndesButton should be able to change their color at touch") {

            context("AndesButtonLoud is touched") {
                it("should change its colors") {
                    //Given
                    let style = AndesButtonHierarchyLoud()
                    let button = AndesButton(text: "Comprar Test", hierarchy: .loud, size: .large)
                    let view: AndesButtonViewDefault = button.view as! AndesButtonViewDefault

                    //When
                    button.touchDown()

                    //Then
                    expect(button.view.isKind(of: AndesButtonViewDefault.self)).to(beTrue())
                    expect(view.backgroundLayer.backgroundColor).to(be(style.pressedColor.cgColor))
                }

                it("should keep idle color after been touched") {
                    //Given
                    let style = AndesButtonHierarchyLoud()
                    let button = AndesButton(text: "Comprar Test", hierarchy: .loud, size: .large)
                    let view: AndesButtonViewDefault = button.view as! AndesButtonViewDefault

                    //When
                    button.touchDown()
                    button.touchUp()

                    //Then
                    expect(button.view.isKind(of: AndesButtonViewDefault.self)).to(beTrue())
                    expect(view.backgroundLayer.backgroundColor).to(be(style.idleColor.cgColor))
                }
            }
        }

        describe("AndesButton should be able to be disable") {
            context("AndesButton is disabled") {
                it("should not be interactable") {
                    //Given
                    let style = AndesButtonHierarchyLoud()
                    let title = "Comprar Test"

                    let button = AndesButton(text: title, hierarchy: .loud, size: .large)

                    //When
                    button.isEnabled = false

                    //Then
                    let view: AndesButtonViewDefault = button.view as! AndesButtonViewDefault
                    expect(view.backgroundLayer.backgroundColor).to(be(style.disableColor.cgColor))
                    expect(view.label.textColor).to(be(AndesStyleSheetManager.styleSheet.textColorDisabled))
                }

                it("should be interactable after enabled it again") {
                    //Given
                    let style = AndesButtonHierarchyLoud()
                    let title = "Comprar Test"

                    let button = AndesButton(text: title, hierarchy: .loud, size: .large)

                    //When
                    button.isEnabled = false

                    button.isEnabled = true

                    //Then
                    let view: AndesButtonViewDefault = button.view as! AndesButtonViewDefault
                    expect(view.backgroundLayer.backgroundColor).to(be(style.idleColor.cgColor))
                    expect(view.label.textColor).to(be(style.fontColor))
                    expect(button.isUserInteractionEnabled).to(beTrue())
                }
            }
        }

        describe("AndesButton should be able to show text") {
            context("AndesButton is setted up") {
                it("should have a label with the actual title") {
                    //Given
                    let title = "Comprar Test"

                    //When
                    let button = AndesButton(text: title, hierarchy: .loud, size: .large)

                    //Then
                    let view: AndesButtonViewDefault = button.view as! AndesButtonViewDefault
                    expect(view.label.text == title).to(beTrue())
                }

                it("should change title when it is required") {
                    //Given
                    let title = "Comprar Test"
                    let button = AndesButton(text: title, hierarchy: .loud, size: .large)

                    //When
                    let changedTitle = "Soy test"
                    button.text = changedTitle

                    //Then
                    let view: AndesButtonViewDefault = button.view as! AndesButtonViewDefault
                    expect(view.label.text == changedTitle).to(beTrue())
                }
            }
        }

        describe("AndesButton should be able to be change on runtime") {
            context("AndesButton is now Quiet") {
                it("Should take the new configuration") {
                    //Given
                    let title = "Comprar Test"
                    let button = AndesButton(text: title, hierarchy: .loud, size: .large)

                    //When
                    let newStyle = AndesButtonHierarchyQuiet()
                    button.hierarchy = .quiet

                    //Then
                    let view: AndesButtonViewDefault = button.view as! AndesButtonViewDefault
                    expect(self.compareColors(firstColor: view.backgroundLayer.backgroundColor!, secondColor: newStyle.idleColor.cgColor)).to(beTrue())
                    expect(view.label.textColor).to(be(newStyle.fontColor))
                }
            }
        }

        describe("AndesButton spinner state") {
            context("AndesButton StartSpinner") {
                it("Should set false userInteractionEnabled") {
                    //Given
                    let title = "test"
                    let button = AndesButton(text: title, hierarchy: .loud, size: .large)

                    //When
                    button.startSpinner()

                    //Then
                    expect(button.isUserInteractionEnabled).to(beFalse())
                }
            }

            context("AndesButton StopSpinner") {
                it("Should set true userInteractionEnabled") {
                    //Given
                    let title = "test"
                    let button = AndesButton(text: title, hierarchy: .loud, size: .large)

                    //When
                    button.stopSpinner()

                    //Then
                    expect(button.isUserInteractionEnabled).to(beTrue())
                }
            }
        }
    }

    private func compareColors(firstColor: CGColor, secondColor: CGColor) -> Bool {
        return firstColor.components!.elementsEqual(secondColor.components!)
    }

}
