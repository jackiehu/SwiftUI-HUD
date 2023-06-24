//
//  PopupTopStackView.swift
//  Show
//
//  Created by iOS on 2023/5/4.
//

import SwiftUI

struct TopStackView: View {
    let items: [AnyHUD] 
    @State private var heights: [AnyHUD: CGFloat] = [:]
    @State private var gestureTranslation: CGFloat = 0
    @State private var cacheCleanerTrigger: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom, content: setupHudStack)
            .ignoresSafeArea()
            .animation(transitionAnimation, value: items)
            .animation(transitionAnimation, value: heights)
            .animation(dragGestureAnimation, value: gestureTranslation)
            .background(setupTapArea())
            .onDragGesture(onChanged: onDragGestureChanged, onEnded: onDragGestureEnded)
            .onChange(of: items, perform: onItemsChange)
            .clearCacheObjects(shouldClear: items.isEmpty, trigger: $cacheCleanerTrigger)
    }
}

private extension TopStackView {
    func setupHudStack() -> some View {
        ForEach(items, id: \.self, content: setupHud)
    }
    
    func setupTapArea() -> some View {
        Color.black.opacity(0.00000000001)
            .onTapGesture(perform: items.last?.dismiss ?? {})
            .active(if: config.touchOutsideToDismiss)
    }
}

private extension TopStackView {
    func setupHud(_ item: AnyHUD) -> some View {
        item.body
            .padding(.top, contentTopPadding)
            .padding(.horizontal, contentHorizontalPadding)
            .readHeight{ height in
                heights[item] = height
            }
            .background(backgroundColour,
                        radius: getCornerRadius(for: item),
                        corners: getCorners())
            .opacity(getOpacity(for: item))
            .offset(y: getOffset(for: item))
            .scaleEffect(getScale(for: item), anchor: .bottom)
            .compositingGroup()
            .focusSectionIfAvailable()
            .alignToTop(config.topPadding)
            .transition(transition)
            .zIndex(isLast(item).doubleValue)
            .shadow(color: config.shadowColour,
                    radius: config.shadowRadius,
                    x: config.shadowOffsetX,
                    y: config.shadowOffsetY)


    }
}

// MARK: -Gesture Handler
private extension TopStackView {
    func onDragGestureChanged(_ value: CGFloat) {
        if config.dragGestureEnabled {
            gestureTranslation = min(0, value)
        }
    }
    
    func onDragGestureEnded(_ value: CGFloat) {
        if translationProgress() >= gestureClosingThresholdFactor {
            items.last?.dismiss()
        }
        gestureTranslation = 0
    }
    
    func onItemsChange(_ items: [AnyHUD]) {
        items.last?.setupConfig(HUDConfig()).onFocus()
    }
}

// MARK: -View Handlers
private extension TopStackView {
    
    func getCornerRadius(for item: AnyHUD) -> CGFloat {
        if isLast(item) {
            return cornerRadius.active
        }
        if gestureTranslation.isZero || !isNextToLast(item) {
            return cornerRadius.inactive
        }
        
        let difference = cornerRadius.active - cornerRadius.inactive
        let differenceProgress = difference * translationProgress()
        return cornerRadius.inactive + differenceProgress
    }
    
    func getCorners() -> RectCorner {
        switch topPadding {
            case 0: return [.bottomLeft, .bottomRight]
            default: return .allCorners
        }
    }
    
    func getOpacity(for item: AnyHUD) -> Double {
        if isLast(item) {
            return 1
        }
        if gestureTranslation.isZero {
            return  1 - invertedIndex(of: item).doubleValue * opacityFactor
        }
        
        let scaleValue = invertedIndex(of: item).doubleValue * opacityFactor
        let progressDifference = isNextToLast(item) ? 1 - translationProgress() : max(0.6, 1 - translationProgress())
        return 1 - scaleValue * progressDifference
    }
    
    func getScale(for item: AnyHUD) -> CGFloat {
        if isLast(item) {
            return 1
        }
        if gestureTranslation.isZero {
            return  1 - invertedIndex(of: item).floatValue * scaleFactor
        }
        
        let scaleValue = invertedIndex(of: item).floatValue * scaleFactor
        let progressDifference = isNextToLast(item) ? 1 - translationProgress() : max(0.7, 1 - translationProgress())
        return 1 - scaleValue * progressDifference
    }
    
    func getOffset(for item: AnyHUD) -> CGFloat {
        isLast(item) ? gestureTranslation : invertedIndex(of: item).floatValue * offsetFactor
    }

}

private extension TopStackView {
    func translationProgress() -> CGFloat {
        abs(gestureTranslation) / height
    }
    
    func isLast(_ item: AnyHUD) -> Bool {
        items.last == item
    }
    
    func isNextToLast(_ item: AnyHUD) -> Bool {
        index(of: item) == items.count - 2
    }
    
    func invertedIndex(of item: AnyHUD) -> Int {
        items.count - 1 - index(of: item)
    }
    
    func index(of item: AnyHUD) -> Int {
        items.firstIndex(of: item) ?? 0
    }
}

private extension TopStackView {
    var contentTopPadding: CGFloat {
        config.ignoresSafeArea ? 0 : max(UIScreen.safeArea.top - config.topPadding, 0)
    }
    var topPadding: CGFloat {
        config.topPadding
    }
    var contentHorizontalPadding: CGFloat {
        config.horizontalPadding
    }
    
    var height: CGFloat {
        if let hud = items.last, let hei = heights[hud]{
            return  hei
        }
        return  0
    }
    
    var opacityFactor: Double {
        1 / config.maxStackCount.doubleValue
    }
    
    var offsetFactor: CGFloat {
        config.stackViewsOffset
    }
    
    var scaleFactor: CGFloat {
        config.stackViewsScale
    }
    
    var cornerRadius: (active: CGFloat, inactive: CGFloat) {
        (config.cornerRadius, config.stackViewsCornerRadius)
    }
    
    var backgroundColour: Color {
        config.backgroundColour
    }
    
    var transitionAnimation: Animation {
        config.transitionAnimation
    }
    
    var dragGestureAnimation: Animation {
        config.dragGestureAnimation
    }
    
    var gestureClosingThresholdFactor: CGFloat {
        config.dragGestureProgressToClose
    }
    
    var transition: AnyTransition {
        .move(edge: .top)
    }
    
    var config: HUDConfig {
        items.last?.setupConfig(HUDConfig()) ?? .init()
    }
}
