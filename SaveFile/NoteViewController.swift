//
//  NoteViewController.swift
//  SaveFile
//
//  Created by Damon Cricket on 24.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - NoteViewController

class NoteViewController: UIViewController {
    
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem?
    
    @IBOutlet weak var textField: UITextField?
    
    var noteName = ""
    
    var folderURL: URL!

    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - UIActions
    
    @IBAction func saveBarButtonTap(sender: UIBarButtonItem) {
        
    }
}
