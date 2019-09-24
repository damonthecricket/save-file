//
//  MainViewController.swift
//  SaveFile
//
//  Created by Damon Cricket on 22.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - MainViewController

class MainViewController: UIViewController, NoteNameViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    struct Constants {
        static let directory = "notes"
    }
    
    @IBOutlet var deleteBarButtonItem: UIBarButtonItem?
    
    @IBOutlet var doneBarButtonItem: UIBarButtonItem?

    @IBOutlet weak var tableView: UITableView?
    
    var files: [String] = []
    
    // MARK: - Object LifeCycle
    
    deinit {
        deleteBarButtonItem = nil
        doneBarButtonItem = nil
    }
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.tableFooterView = UIView(frame: .zero)
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = documentDirectory.appendingPathComponent(Constants.directory)
            if let urls = try? FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil) {
                files = urls.map {
                    $0.lastPathComponent
                }
                tableView?.reloadData()
            } else {
                do {
                    try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
                } catch let error {
                    print("Directory create error \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - Transition
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "present.note.name" {
            let vc = segue.destination as! NoteNameViewController
            vc.delegate = self
        } else if segue.identifier == "push.note" {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let folderPath = documentDirectory.appendingPathComponent(Constants.directory)
                let indexPath = tableView?.indexPathForSelectedRow
                let note = files[indexPath!.row]
                let vc = segue.destination as! NoteViewController
                vc.noteName = note
                vc.folderURL = folderPath
            }
        }
    }
    
    // MARK: - UIActions

    @IBAction func deleteBarButtonTap(sender: UIBarButtonItem) {
        tableView?.setEditing(true, animated: true)
        navigationItem.leftBarButtonItem = doneBarButtonItem
    }
    
    @IBAction func doneBarButtonTap(sender: UIBarButtonItem) {
        tableView?.setEditing(false, animated: true)
        navigationItem.leftBarButtonItem = deleteBarButtonItem
    }
    
    // MARK: - NoteNameViewControllerDelegate
    
    func noteNameViewController(_ vc: NoteNameViewController, canNameNote name: String) -> Bool {
        return !files.contains(name)
    }
    
    func noteNameViewController(_ vc: NoteNameViewController, didNameNote note: String) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent(Constants.directory).appendingPathComponent(note)
            do {
                let text = ""
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                files.append(note)
                tableView?.reloadData()
                dismiss(animated: true)
            } catch let error {
                print("File write error \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - UITableViewDelegate / UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "file.name.cell.identifier", for: indexPath) as! NoteTableViewCell
        let file = files[indexPath.row]
        cell.adjust(withNoteName: file)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        let file = files[indexPath.row]
        files.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent(Constants.directory).appendingPathComponent(file)
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch let error {
                print("File delete error \(error.localizedDescription)")
            }
        }
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
