//
//  SearchTextField.swift
//  BooQs
//
//  Created by Leonardo Domingues on 5/31/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import Foundation
import UIKit

class SearchTextField: UITextField {
    
    var customPlaceholder: String = "Try \"Harry potter\""
    var leftIcon: UIImage?
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func setupView() {
        layer.cornerRadius = 5
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        
        let searchView = UIImageView(
            frame: CGRect(x: 0, y: -2, width: 26, height: 16))
        searchView.image = UIImage(named: "search_ic")
        searchView.contentMode = .center
        leftView = searchView
        
        if let image = UIImage(named: "search_ic") {
            leftIcon = image
        }
        activateBasePlaceholder()
    }
    
    func activateBasePlaceholder() {
        textAlignment = .center
        setPlaceholder(text: customPlaceholder, image: leftIcon)
    }
    
    func activateEditingPlaceholder() {
        textAlignment = .left
        setPlaceholder(text: customPlaceholder, image: nil)
    }
    
    func activateResultPlaceholder(for query: String) {
        textAlignment = .center
        setPlaceholder(text: query, image: leftIcon)
    }
    
    private func setPlaceholder(text: String, image: UIImage?) {
        let updatedPlaceholder = NSMutableAttributedString()
        if let iconImage = image {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = iconImage
            imageAttachment.bounds = CGRect(x: -5, y: -2, width: 14, height: 14)
            let imageString = NSAttributedString(attachment: imageAttachment)
            updatedPlaceholder.append(imageString)
        }
        updatedPlaceholder.append(NSAttributedString(string: text))
        attributedPlaceholder = updatedPlaceholder
    }
    
}
