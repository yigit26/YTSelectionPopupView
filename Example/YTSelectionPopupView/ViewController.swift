//
//  ViewController.swift
//  YTSelectionPopupView
//
//  Created by Yigit Can Ture on 03/23/2017.
//  Copyright (c) 2017 Yigit Can Ture. All rights reserved.
//

import UIKit
import YTSelectionPopupView

class ViewController: UIViewController,YTSelectionPopupViewDataSource, YTSelectionPopupViewDelegate {
    var selectionView : YTSelectionPopupView? = nil;
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var swcMultiple: UISwitch!
    @IBOutlet weak var swcTextfields: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createView() -> YTSelectionPopupView {
        selectionView = YTSelectionPopupView.instantiate()
        selectionView?.optionButtonTitleDone = "OK"
        selectionView?.optionButtonTitleCancel = "Cancel"
        selectionView?.optionBackgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        selectionView?.dataSource = self
        selectionView?.delegate = self
        selectionView?.optionSelectionType = swcMultiple.isOn ? .multiple : .single
        selectionView?.optionDisplayStyle = swcTextfields.isOn ?  .withTextField :  .withoutTextField
        selectionView?.optionPopupTitle = txtTitle.text!
        return selectionView!
    }
    
    @IBAction func clickedIt(_ sender: UIButton) {
        let view = self.createView()
        present(view, animated: true, completion: nil)
    }
    
    func singleItemSelected(in selectionView: YTSelectionPopupView, item: String, indexPath: IndexPath) {
        print("Single selection without textField")
    }
    
    func singleItemWithValueSelected(in selectionView: YTSelectionPopupView, item: String, value: String, indexPath: IndexPath) {
        print("Single selection with text field")
    }
    
    func multipleSelectedIndexPaths(in selectionView: YTSelectionPopupView, indexPaths: Array<IndexPath>) {
        print("Multi selection withoud textfields. It gives index paths.")
    }
    
    func multipleItemsWithValuesSelected(in selectionView: YTSelectionPopupView, items: Dictionary<Int, String>) {
        print("Multiple selection with textfields. It gives a dictionary which includes indexes and values as strings")
    }
    
    func titleForItem(in selectionView: YTSelectionPopupView, indexPath: IndexPath) -> String {
        switch indexPath.row {
        case 0:
            return "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
        case 1:
            return "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source."
        case 2:
            return "Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32"
        default:
            return "DEL!"
        }
    }
    
    func numberOfItems(in selectionView: YTSelectionPopupView) -> Int {
        return 3
    }
}

