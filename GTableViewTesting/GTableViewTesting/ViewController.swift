//
//  ViewController.swift
//  GTableViewTesting
//
//  Created by Glenn Posadas on 3/14/17.
//  Copyright © 2017 CitusLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barButton_Edit: UIBarButtonItem!
    
    var cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    lazy var data = [String]()
    
    // MARK: - Functions
    // MARK: IBActions
    
    @IBAction func cancelApplications(_ sender: Any) {
        
        let indexPaths = self.tableView.indexPathsForSelectedRows
        
        for indexPath in indexPaths! {
            print("SELECTED : \(indexPath.section)")
        }
    }
    
    @IBAction func markAll(_ sender: Any) {
        
        guard let barButton_MarkAll = sender as? UIBarButtonItem else { return }
        
        let totalSections = self.tableView.numberOfSections - 1
        
        for section in 0...totalSections {
            let indexPath = IndexPath(row: 0, section: section)
            
            if barButton_MarkAll.title == "Mark All" {
                self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            } else {
                self.tableView.deselectRow(at: indexPath, animated: false)
            }
            
        }
        
        barButton_MarkAll.title = barButton_MarkAll.title == "Mark All" ? "Unmark All" : "Mark All"
    }
    
    @IBAction func edit(_ sender: Any) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
        self.barButton_Edit.title = self.tableView.isEditing ? "Cancel" : "Edit"
        
        self.tabBarController?.tabBar.isHidden = self.tableView.isEditing
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        for x in 1...20 {
            self.data.append("\(x) -- \(Date())")
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView Delegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.tableView.isEditing {
            print("tapped: \(indexPath.section)")
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle(rawValue: 3)!
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}

// MARK: - TableView Data Source

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let date = self.data[section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = date
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
