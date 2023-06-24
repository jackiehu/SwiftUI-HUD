//
//  PopupCentreStackView.swift
//  Show
//
//  Created by iOS on 2023/5/4.
//

import SwiftUI

struct CenterStackView: View {
    let items: [AnyHUD]
    @State private var activeView: AnyView?
    @State private var configTemp: HUDConfig?
    @State private var contentIsAnimated: Bool = false
    @State private var cacheCleanerTrigger: Bool = false
    
    var body: some View {
        setupHud()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(setupTapArea())
            .animation(config.transitionAnimation, value: contentIsAnimated)
            .transition(getTransition())
            .onChange(of: items, perform: onItemsChange)
            .clearCacheObjects(shouldClear: items.isEmpty, trigger: $cacheCleanerTrigger)
    }
}

private extension CenterStackView {
    func setupHud() -> some View {
        activeView?
            .opacity(contentOpacity)
            .background(config.backgroundColour,
                        radius: config.cornerRadius,
                        corners: .allCorners)
            .padding(config.horizontalPadding)
            .compositingGroup()
            .focusSectionIfAvailable()
            .shadow(color: config.shadowColour,
                    radius: config.shadowRadius,
                    x: config.shadowOffsetX,
                    y: config.shadowOffsetY)
    }
    
    func setupTapArea() -> some View {
        Color.black.opacity(0.00000000001)
            .onTapGesture(perform: items.last?.dismiss ?? {})
            .active(if: config.touchOutsideToDismiss)
    }
}

// MARK: -Logic Handlers
private extension CenterStackView {
    func onItemsChange(_ items: [AnyHUD]) {
        guard let popup = items.last else { return handleClosingHud() }
        
        showNewHud(popup)
        animateContentIfNeeded()
        items.last?.setupConfig(HUDConfig()).onFocus()
    }
}
private extension CenterStackView {
    func showNewHud(_ popup: AnyHUD) {
        DispatchQueue.main.async {
            activeView = AnyView(popup.body)
            configTemp = popup.setupConfig(HUDConfig())
        }
    }
    
    func animateContentIfNeeded() {
        contentIsAnimated = true
        DispatchQueue.main.asyncAfter(deadline: .now() + config.centerAnimationTime) {
            contentIsAnimated = false
        }
    }
    
    func handleClosingHud() {
        DispatchQueue.main.async {
            activeView = nil
        }
    }
}

// MARK: -View Handlers
private extension CenterStackView {
    
    func getTransition() -> AnyTransition {
        .scale(scale: items.isEmpty ? config.centerTransitionExitScale : config.centerTransitionEntryScale)
        .combined(with: .opacity)
        .animation(items.isEmpty ? config.transitionAnimation : nil)
    }
}

private extension CenterStackView {
    
    var contentOpacity: CGFloat {
        contentIsAnimated ? 0 : 1
    }
    
    var config: HUDConfig {
        items.last?.setupConfig(HUDConfig()) ?? configTemp ?? .init()
    }
}
