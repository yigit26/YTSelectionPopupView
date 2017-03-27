//
//  YTSelectionPopupView.swift
//  Pods
//
//  Created by Yiğit Can Türe on 22/03/2017.
//
//


import UIKit

@objc public protocol YTSelectionPopupViewDataSource {
    @objc func numberOfItems(in selectionView: YTSelectionPopupView) -> Int
    @objc func titleForItem(in selectionView: YTSelectionPopupView, indexPath : IndexPath) -> String
}

@objc public protocol YTSelectionPopupViewDelegate {
    
    /// Method
    ///
    /// This method is only called when `optionSelectionType` is `.single` and 'optionDisplayStyle' is  '.withoutTextField'.
    ///
    ///
    /// - Parameters:
    ///     - selectionView: The selectionView that will be dismissed.
    ///     - item: Selected item.
    ///     - indexPath : Selected item's indexPath
    @objc optional func singleItemSelected(in selectionView: YTSelectionPopupView, item :String, indexPath : IndexPath)
    
    /// Method
    ///
    /// This method is only called when -`optionSelectionType` : `.single` , 'optionDisplayStyle' : '.withTextField' - 'OK' button tapped..
    ///
    ///
    /// - Parameters:
    ///     - selectionView: The selectionView that will be dismissed.
    ///     - item: Selected item.
    ///     - indexPath : Selected item's indexPath
    ///     - value : The value which is textfield.text
    @objc optional func singleItemWithValueSelected(in selectionView: YTSelectionPopupView, item :String,value :String, indexPath : IndexPath)
    
    
    /// Method
    ///
    /// This method is only called when -`optionSelectionType` : `.multiple` , 'optionDisplayStyle' : '.withoutTextField' - 'OK' button tapped..
    ///
    ///
    /// - Parameters:
    ///     - selectionView: The selectionView that will be dismissed.
    ///     - indexPaths: Selected items.
    @objc optional func multipleSelectedIndexPaths(in selectionView:YTSelectionPopupView, indexPaths : Array<IndexPath>)
    
    /// Method
    ///
    /// This method is only called when -`optionSelectionType` : `.multiple` , 'optionDisplayStyle' : '.withTextField' - 'OK' button tapped..
    ///
    ///
    /// - Parameters:
    ///     - selectionView: The selectionView that will be dismissed.
    ///     - items: Selected item's index,Value.
    @objc optional func multipleItemsWithValuesSelected(in selectionView:YTSelectionPopupView, items : Dictionary<Int,String>)
    
}

@objc public enum YTSelectionPopupViewSelection: Int {
    /// Single Selection.
    case single
    /// Multiple Selection.
    case multiple
}




@objc public enum YTSelectionPopupViewDisplayStyle: Int {
    
    /// Only item label
    case withoutTextField
    /// Item label and text field for value
    case withTextField
}

open class YTSelectionPopupView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    open weak var dataSource: YTSelectionPopupViewDataSource?
    open weak var delegate: YTSelectionPopupViewDelegate?
    
    open var optionSelectionType: YTSelectionPopupViewSelection = .single
    open var optionDisplayStyle: YTSelectionPopupViewDisplayStyle = .withoutTextField
    open var optionBackgroundColor : UIColor = .blue
    open var optionDoneButtonTintColor : UIColor = #colorLiteral(red: 0.8901960784, green: 0.9490196078, blue: 0.9921568627, alpha: 1)
    open var optionCancelButtonTintColor : UIColor = #colorLiteral(red: 0.8901960784, green: 0.9490196078, blue: 0.9921568627, alpha: 1)
    open var optionTitleColor : UIColor = #colorLiteral(red: 0.8901960784, green: 0.9490196078, blue: 0.9921568627, alpha: 1)
    
    open var optionButtonTitleDone: String = "Done"
    open var optionButtonTitleCancel: String = "Cancel"
    open var optionPopupTitle: String = "Select"
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var cancelButton: UIButton!
    @IBOutlet fileprivate weak var okButton: UIButton!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    fileprivate var dictOfIndexesAndValues = Dictionary<Int,String>()
    
    open static func instantiate() -> YTSelectionPopupView {
        let podBundle = Bundle(for: self.classForCoder())
        let bundleURL = podBundle.url(forResource: "YTSelectionPopupView", withExtension: "bundle")
        var bundle: Bundle?
        if let bundleURL = bundleURL {
            bundle = Bundle(url: bundleURL)
        }
        return UIStoryboard(name: "YTSelectionPopupView", bundle: bundle).instantiateInitialViewController() as! YTSelectionPopupView
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.prepareTitles()
        self.prepareTable()
        self.prepareBackgroundView()
    }
    
    fileprivate func prepareBackgroundView(){
        self.backgroundView.layer.masksToBounds = false
        self.backgroundView.layer.cornerRadius = 3.0
        self.backgroundView.layer.shadowOpacity = 0.8
        self.backgroundView.layer.shadowRadius = 3.0
        self.backgroundView.layer.shadowOffset = CGSize(width:0.0, height:2.0)
        self.backgroundView.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
        self.backgroundView.backgroundColor = optionBackgroundColor
    }
    
    fileprivate func prepareTitles(){
        self.okButton.setTitle(optionButtonTitleDone, for: .normal)
        self.okButton.titleLabel?.textColor = optionDoneButtonTintColor
        
        self.cancelButton.setTitle(optionButtonTitleCancel, for: .normal)
        self.cancelButton.titleLabel?.textColor = optionCancelButtonTintColor
        
        self.titleLabel.text = optionPopupTitle
        self.titleLabel.textColor = optionTitleColor
    }
    
    fileprivate func prepareTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 40.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.allowsMultipleSelection = self.optionSelectionType == .multiple ? true : false
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let data = self.dataSource {
            let title = data.titleForItem(in: self,indexPath: indexPath)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "YTSelectionCell", for: indexPath) as? YTSelectionCell {
                cell.itemLabel?.text = title
                if self.optionDisplayStyle == .withoutTextField {
                    cell.valueField.isHidden = true
                }
                return cell
            }
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = self.dataSource {
            return data.numberOfItems(in: self)
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? YTSelectionCell {
            if self.optionSelectionType == .single && self.optionDisplayStyle == .withoutTextField {
                self.delegate?.singleItemSelected!(in: self, item: cell.itemLabel.text!, indexPath: indexPath)
                dismiss()
            } else if self.optionSelectionType == .multiple && self.optionDisplayStyle == .withTextField {
                dictOfIndexesAndValues[indexPath.row] = cell.valueField.text
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let index = dictOfIndexesAndValues.index(where: { (key, str) -> Bool in
            key == indexPath.row
        }){
            dictOfIndexesAndValues.remove(at: index)
        }
        
    }
    
    @IBAction func done(_ sender: UIButton) {
        if let indexPaths = self.tableView.indexPathsForSelectedRows {
            if self.optionSelectionType == .multiple {
                if self.optionDisplayStyle == .withoutTextField {
                    self.delegate?.multipleSelectedIndexPaths!(in: self, indexPaths: indexPaths)
                } else {
                    self.delegate?.multipleItemsWithValuesSelected!(in: self, items: dictOfIndexesAndValues)
                }
            } else {
                let indexPath = indexPaths[0]
                if let cell = self.tableView.cellForRow(at: indexPath) as? YTSelectionCell {
                    self.delegate?.singleItemWithValueSelected!(in: self, item: cell.itemLabel.text!, value: cell.valueField.text!, indexPath: indexPath)
                }
                
            }
        }
        dismiss()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss()
    }
    
    
    fileprivate func dismiss() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
            
        } else if presentingViewController != nil {
            dismiss(animated: true) {
                
            }
        }
    }
}
