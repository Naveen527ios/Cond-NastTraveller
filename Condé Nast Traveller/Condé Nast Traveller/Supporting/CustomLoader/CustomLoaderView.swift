//
//  CustomLoaderView.swift
//  Condé Nast Traveller
//
//  Created by Naveen Kumar on 20/03/25.
//

import Foundation
import UIKit

class CustomLoaderView {
    
    static let shared = CustomLoaderView()
    
    private var activityIndicator: UIActivityIndicatorView
    private var viewController: UIViewController?
    
    private init(){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .red
    }
    
    func show(in viewController: UIViewController) {
        self.viewController = viewController
        if activityIndicator.superview == nil {
            activityIndicator.center = viewController.view.center
            viewController.view.addSubview(activityIndicator)
        }
        activityIndicator.startAnimating()
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
       
    }
}
