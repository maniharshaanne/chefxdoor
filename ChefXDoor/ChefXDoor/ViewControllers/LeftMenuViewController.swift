//
//  LeftMenuViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 7/28/18.
//  Copyright © 2018 ChefXDoor. All rights reserved.
//

import UIKit

/**
 Menu controller is responsible for creating its content and showing/hiding menu using 'menuContainerViewController' property.
 */
class LeftMenuViewController: UIViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet fileprivate weak var avatarImageViewCenterXConstraint: NSLayoutConstraint!
    private var gradientLayer = CAGradientLayer()
    var titles = ["Categories", "Profile", "Previous Orders", "Settings"]
    
    private var gradientApplied: Bool = false
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Select the initial row
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        avatarImageViewCenterXConstraint.constant = 50
        
        if gradientLayer.superlayer != nil {
            gradientLayer.removeFromSuperlayer()
        }
        let topColor = UIColor(red: 16.0/255.0, green: 12.0/255.0, blue: 54.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 57.0/255.0, green: 33.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    deinit{
        print()
    }
}

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SampleTableCell.self), for: indexPath) as? SampleTableCell else {
            preconditionFailure("Unregistered table view cell")
        }
        
        cell.titleLabel.text = titles[indexPath.row]
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let menuContainerViewController = self.menuContainerViewController else {
//            return
//        }
//
//        menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[indexPath.row])
//        menuContainerViewController.hideSideMenu()
//    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
}

