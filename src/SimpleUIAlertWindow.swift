import UIKit

/// In order to present alert views, use `overlayView` to add/remove subviews.
/// Limitation of this implementation: Status bar changes of underlying UIWindows are not forwarded to
/// OverlayViewController.
class SimpleUIAlertWindow: UIWindow {
    var overlayView: UIView? {
        return self.rootViewController?.view
    }
    
    init() {
        // TODO: Assign desired UIWindowScene
        if let windowScene = (UIApplication.shared
                                .connectedScenes
                                .filter { $0.activationState == .foregroundActive }
                                .first) as? UIWindowScene {
            super.init(windowScene: windowScene)
        } else { // No SceneDelegate fallback
            super.init(frame: UIScreen.main.bounds)
        }
        
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.windowLevel = .alert
        self.isHidden = false
        self.rootViewController = OverlayViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self.overlayView?.hitTest(point, with: event)
    }
}

/// Forward any user interactions to the window below if none of the subviews was tapped
class OverlayViewController: UIViewController {
    private class DummyView: UIView {
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            let hittedView = super.hitTest(point, with: event)

            if hittedView is DummyView {
               return nil
            } else {
                return hittedView
            }
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)

        self.view = DummyView(frame: self.view.frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
