//
//  ViewController.swift
//  SimpleUIAlertWindow
//
//  Created by Erik Großkopf on 28.02.22.
//

import UIKit

class ViewController: UIViewController {
    private static let alertWindow = SimpleUIAlertWindow()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showAlert()
    }
    
    private func showAlert() {
        guard let overlayView = ViewController.alertWindow.overlayView else { return }

        let alertLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        alertLabel.text = "Oh oh..."
        alertLabel.backgroundColor = .red
        
        overlayView.addSubview(alertLabel)
        
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertLabel.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            alertLabel.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            alertLabel.widthAnchor.constraint(equalToConstant: 100),
            alertLabel.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
