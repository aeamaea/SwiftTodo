//
//  ViewController.swift
//  TodoApplication
//
//  Created by Rex Fatahi on 6/8/14.
//  Copyright (c) 2014 aug2uag. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CreateTaskDelegate, CompletedDelegate {
    
    var dataSource: Dictionary<String, String>[][] = [[], []]
    
    let tableViewRect = CGRectMake(20, 64, 280, UIScreen.mainScreen().bounds.size.height - 84)
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let createButtonRect = CGRectMake(UIScreen.mainScreen().bounds.size.width - 84, 10, 44, 44)
    
    let createButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let createViewController: TaskCreateViewController = {
        let viewController = TaskCreateViewController()
        return viewController
    }()
    
    let detailViewController: DetailViewController = {
        let viewController = DetailViewController()
        return viewController
    }()
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.frame = tableViewRect
        tableView.backgroundColor = UIColor.blueColor()
        self.view.addSubview(tableView)
        
        createButton.frame = createButtonRect
        createButton.backgroundColor = UIColor.orangeColor()
        createButton.setTitle("+", forState: UIControlState.Normal)
        createButton.addTarget(self, action: "createTask", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(createButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: tableView delegate
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell = tableView!.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath!) as UITableViewCell
        if let path = indexPath {
            
            let currentDictionary = dataSource[path.section][path.row]
            let currentString = currentDictionary["name"]
            cell.text = currentString
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        // display detailViewController
        detailViewController.delegate = self
        
        let currentDictionary = dataSource[indexPath.section][indexPath.row]
        let currentName = currentDictionary["name"]
        let currentDescription = currentDictionary["description"]
        
        detailViewController.nameVar = currentName!
        detailViewController.descriptionVar = currentDescription!
        detailViewController.indexPath = indexPath.row
        
        self.presentViewController(detailViewController, animated: true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String {
        switch (section) {
        case 0:
            return "Not Completed"
        case 1:
            return "Completed"
        default:
            return ""
        }
    }
    
    // MARK: button methods
    func createTask() {
        // present createViewController
        createViewController.delegate = self
        self.presentViewController(createViewController, animated: true, completion: nil)
    }
    
    // MARK: create task delegate
    func taskCreated(task: Dictionary<String, String>) {
        // add task to array at index 0
        dataSource[0] += task
        
        // update tableView
        tableView.reloadData()
        
    }
    
    // MARK: completed delegate
    func markComplete(indexPath: Int) {
        let currentTask = dataSource[0][indexPath]
        dataSource[0].removeAtIndex(indexPath)
        dataSource[1] += currentTask
        
        tableView.reloadData()
    }


}

