//
//  BadgeBarButtonItem.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 12/11/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import UIKit

public class BadgeBarButtonItem: UIBarButtonItem {
    
    private(set) public lazy var badgeLabel: UILabel = {
        let label = UILabel()
        
        label.text = badgeText?.isEmpty == false ? " \(badgeText!) " : nil
        label.isHidden = false
        label.textColor = badgeFontColor
        label.backgroundColor = badgeBackgroundColor
        
        label.font = .systemFont(ofSize: badgeFontSize)
        label.layer.cornerRadius = badgeFontSize * CGFloat(0.6)
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addConstraint(
            NSLayoutConstraint(
                item: label,
                attribute: .width,
                relatedBy: .greaterThanOrEqual,
                toItem: label,
                attribute: .height,
                multiplier: 1,
                constant: 0
            )
        )
        
        return label
    }()
    
    public var badgeButton: UIButton? {
        return customView as? UIButton
    }
    
    public var badgeText: String? {
        didSet {
            badgeLabel.text = badgeText?.isEmpty == false ? " \(badgeText!) " : nil
            badgeLabel.isHidden = false
            badgeLabel.sizeToFit()
        }
    }
    
    public var badgeBackgroundColor: UIColor = .red {
        didSet { badgeLabel.backgroundColor = badgeBackgroundColor }
    }
    
    public var badgeFontColor: UIColor = .white {
        didSet { badgeLabel.textColor = badgeFontColor }
    }
    
    public var badgeFontSize: CGFloat = UIFont.smallSystemFontSize {
        didSet {
            badgeLabel.font = .systemFont(ofSize: badgeFontSize)
            badgeLabel.layer.cornerRadius = badgeFontSize * CGFloat(0.6)
            badgeLabel.sizeToFit()
        }
    }
}

public extension BadgeBarButtonItem {
    
    convenience init(button: UIButton, badgeText: String? = nil, target: AnyObject?, action: Selector) {
        self.init(customView: button)
        
        self.badgeText = badgeText
        
        button.addTarget(target, action: action, for: .touchUpInside)
        button.sizeToFit()
        button.addSubview(badgeLabel)
        
        badgeLabel.addGestureRecognizer(
            UITapGestureRecognizer(target: target, action: action)
        )
        
        button.addConstraint(
            NSLayoutConstraint(
                item: badgeLabel,
                attribute: button.currentTitle?.isEmpty == false ? .top : .centerY,
                relatedBy: .equal,
                toItem: button,
                attribute: .top,
                multiplier: 1,
                constant: 0
            )
        )
        
        button.addConstraint(
            NSLayoutConstraint(
                item: badgeLabel,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: button,
                attribute: .trailing,
                multiplier: 1,
                constant: 0
            )
        )
    }
}

public extension BadgeBarButtonItem {
    
    convenience init(image: UIImage, badgeText: String? = nil, target: AnyObject?, action: Selector) {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: image.size.width + 10, height: image.size.height + 10)
        button.setBackgroundImage(image, for: .normal)
        
        self.init(button: button, badgeText: badgeText, target: target, action: action)
    }
    
    convenience init(title: String, badgeText: String? = nil, target: AnyObject?, action: Selector) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.buttonFontSize)
        
        self.init(button: button, badgeText: badgeText, target: target, action: action)
    }
    
    convenience init?(image: String, badgeText: String? = nil, target: AnyObject?, action: Selector) {
        guard let image = UIImage(named: image) else { return nil }
        self.init(image: image, badgeText: badgeText, target: target, action: action)
    }
}
