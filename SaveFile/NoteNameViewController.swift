//
//  NoteNameViewController.swift
//  SaveFile
//
//  Created by Damon Cricket on 23.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - NoteNameViewControllerDelegate

protocol NoteNameViewControllerDelegate: class {
    
    func noteNameViewController(_ vc: NoteNameViewController, canNameNote name: String) -> Bool
    
    func noteNameViewController(_ vc: NoteNameViewController, didNameNote note: String)
}

// MARK: - NoteNameViewController

class NoteNameViewController: UIViewController {
    
    weak var delegate: NoteNameViewControllerDelegate?
    
    @IBOutlet weak var contentView: UIView?
    
    @IBOutlet weak var okButton: UIButton?

    @IBOutlet weak var textField: UITextField?
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentView?.layer.cornerRadius = 10.0
        contentView?.layer.masksToBounds = true
        
        textField?.addTarget(self, action: #selector(textFieldDidChangeText(textField:)), for: .editingChanged)
    }
    
    // MARK: - UIActions
    
    @IBAction func okButtonTap(sender: UIButton) {
        let name = textField!.text!
        if delegate!.noteNameViewController(self, canNameNote: name) {
            delegate!.noteNameViewController(self, didNameNote: name)
        }
    }
    
    @IBAction func cancelButtonTap(sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func textFieldDidChangeText(textField: UITextField) {
        okButton?.isEnabled = textField.text != nil && !textField.text!.isEmpty
    }
}
