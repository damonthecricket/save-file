//
//  FileTableViewCell.swift
//  SaveFile
//
//  Created by Damon Cricket on 22.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - FileTableViewCell

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel?

    // MARK: - Adjust
    
    func adjust(withNoteName noteName: String) {
        label?.text = noteName
    }
}
