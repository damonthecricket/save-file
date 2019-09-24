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

    @IBOutlet weak var textView: UITextView?
    
    var noteName = ""
    
    var folderURL: URL!

    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = noteName
        
        let url = fileURL()
        textView?.text = try? String(contentsOf: url, encoding: .utf8)
    }
    
    // MARK: - UIActions
    
    @IBAction func saveBarButtonTap(sender: UIBarButtonItem) {
        do {
            let text = textView!.text
            let url = fileURL()
            try text?.write(to: url, atomically: false, encoding: .utf8)
        } catch let error {
            print("File save error \(error.localizedDescription)")
        }
    }
    
    // MARK: - Private
    
    private func fileURL() -> URL {
        return folderURL.appendingPathComponent(noteName)
    }
}
