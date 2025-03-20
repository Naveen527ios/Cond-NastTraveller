//
//  ImageExtention.swift
//  Condé Nast Traveller
//
//  Created by Naveen Kumar on 20/03/25.
//

import Foundation

import UIKit

extension UIImageView {
    
    func setCornerRadious(radious:CGFloat){
        self.layer.cornerRadius = radious
        self.layer.masksToBounds = true
    }
}
