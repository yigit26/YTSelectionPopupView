//
//  YTSelectionCell.swift
//  Pods
//
//  Created by Yiğit Can Türe on 22/03/2017.
//
//

import UIKit

class YTSelectionCell: UITableViewCell {
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var valueField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueField.returnKeyType = .done
        valueField.addTarget(self, action: #selector(textFieldFinished(_:)), for: .editingDidEndOnExit)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .none
        }
        super.setSelected(selected, animated: animated)
    }
    
    func textFieldFinished(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
