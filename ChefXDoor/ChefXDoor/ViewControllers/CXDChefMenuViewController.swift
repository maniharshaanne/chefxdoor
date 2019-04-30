//
//  CXDChefMenuViewController.swift
//  ChefXDoor
//
//  Created by Anne, Mani on 2/25/19.
//  Copyright © 2019 ChefXDoor. All rights reserved.
//

import Foundation
import PKHUD

class CXDChefMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var endTimeButton: UIButton!
    @IBOutlet weak var menuItemsTableView: UITableView!
    @IBOutlet weak var addReceipeButton: UIButton!
    var menuItems: [CXDMeal]?
    let timePicker = UIDatePicker()

    override func viewDidLoad() {
        
        self.navigationItem.leftBarButtonItem = menuLeftBarButton()
        menuItemsTableView.delegate = self
        menuItemsTableView.dataSource = self
        menuItemsTableView.backgroundColor = CXDAppearance.primaryBackgroundColor()
        updateMealsTableView()
        
        startTimeButton.titleLabel?.textColor = UIColor.black
        startTimeButton.layer.cornerRadius = 4
        startTimeButton.backgroundColor = CXDAppearance.primaryColor()
        startTimeButton.setTitle("9:00 AM", for: .normal)
        
        endTimeButton.titleLabel?.textColor = UIColor.black
        endTimeButton.layer.cornerRadius = 4
        endTimeButton.backgroundColor = CXDAppearance.primaryColor()
        endTimeButton.setTitle("5:00 PM", for: .normal)

        addReceipeButton.titleLabel?.textColor = UIColor.black
        addReceipeButton.layer.cornerRadius = 4
        addReceipeButton.backgroundColor = CXDAppearance.primaryColor()
        
        menuItemsTableView.register(UINib.init(nibName: "CXDChefMenuTableViewCell", bundle: Bundle(for: CXDChefMenuTableViewCell.self)),
                                               forCellReuseIdentifier: "CXDChefMenuTableViewCell")

    }
    
    func updateMealsTableView() {
        HUD.show(.progress)
        
        CXDApiServiceController.awsGetFromEndPoint(urlString: "/meals/recommended", queryParametersDict: ["lat" : 38.994373, "long" : -77.029778, "distance" : 10, "page" : 0, "sort":"price"], pathParametersDict: nil, classType: CXDMeal.self).continueWith { (task) -> Any? in
            
            DispatchQueue.main.async {
                HUD.hide()
                if let error = task.error {
                    print("Error: \(error)")
                } else if let result = task.result {
                    let res = result as! Array<CXDMeal>
                    self.menuItems = res
                    self.menuItemsTableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = menuItemsTableView.dequeueReusableCell(withIdentifier: "CXDChefMenuTableViewCell") as! CXDChefMenuTableViewCell
       cell.updateInfo(meal: menuItems![indexPath.row])
       return cell
    }
    
    
    @IBAction func updateTime(_ sender: UIButton) {
        
        timePicker.datePickerMode = UIDatePickerMode.time
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        if let time = sender.titleLabel?.text
        {
            timePicker.date = formatter.date(from: time) ?? Date()
        }
        
        let dateChooserAlert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        dateChooserAlert.view.addSubview(timePicker)
        dateChooserAlert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { action in
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            sender.setTitle(formatter.string(from: self.timePicker.date), for: .normal)
        }))
        let height: NSLayoutConstraint = NSLayoutConstraint(item: dateChooserAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 300)
        dateChooserAlert.view.addConstraint(height)
        self.present(dateChooserAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func addReceipeButtonPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Chef", bundle: Bundle(for: CXDAddReceipeViewController.self))
        if let addReceipeViewController = storyBoard.instantiateViewController(withIdentifier: "CXDAddReceipeViewController") as? CXDAddReceipeViewController
        {
            self.navigationController?.pushViewController(addReceipeViewController, animated: true)
        }
    }
    
}
