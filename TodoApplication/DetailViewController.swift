//
//  DetailViewController.swift
//  TodoApplication
//
//  Created by Rex Fatahi on 6/8/14.
//  Copyright (c) 2014 aug2uag. All rights reserved.
//

import UIKit

protocol CompletedDelegate {
    func markComplete(indexPath: Int)
}

class DetailViewController: UIViewController {
    
    var nameVar: NSString = ""
    var descriptionVar: NSString = ""
    var indexPath: Int = 0
    
    var delegate: CompletedDelegate?
    
    // name label
    let nameLabelRect = CGRectMake(10, 44, 300, 44)
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // description label
    let descriptionRect = CGRectMake(10, 100, 300, 44)
    let descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    // task completed button
    let completedRect = CGRectMake(15, 160, 140, 44)
    let completedButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    // exit button
    let exitRect = CGRectMake(165, 160, 140, 44)
    let exitButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        nameLabel.frame = nameLabelRect
        nameLabel.text = nameVar
        self.view.addSubview(nameLabel)
        
        descriptionLabel.frame = descriptionRect
        descriptionLabel.text = descriptionVar
        self.view.addSubview(descriptionLabel)
        
        
        completedButton.frame = completedRect
        completedButton.setTitle("Mark Complete", forState: UIControlState.Normal)
        completedButton.addTarget(self, action: "completeAction", forControlEvents: UIControlEvents.TouchUpInside)
        completedButton.backgroundColor = UIColor.blueColor()
        self.view.addSubview(completedButton)
        
        
        exitButton.frame = exitRect
        exitButton.setTitle("Exit", forState: UIControlState.Normal)
        exitButton.addTarget(self, action: "exitAction", forControlEvents: UIControlEvents.TouchUpInside)
        exitButton.backgroundColor = UIColor.blueColor()
        self.view.addSubview(exitButton)
        
    }
    
    func completeAction() {
        // update viewController to mark item as complete
        delegate?.markComplete(indexPath)
        
        self.exitAction()
    }
    
    func exitAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
