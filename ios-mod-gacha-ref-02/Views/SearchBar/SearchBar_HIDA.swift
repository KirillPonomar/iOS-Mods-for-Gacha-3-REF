//
//  SearchBar_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class SearchBar_HIDA: UIView {
    
    let _YYYE2cac: (Int, Int, String) -> Int = { _, _, _ in
        let _Nd2iiv = "_Mdu3"
        let _JDU33 = 1
        for _ in 0...4 {
                return 0
            }
            let _ = (9...5).map { _ in
                return 0
            }
        return 0
    }
    
    @IBOutlet weak var searchTextField_HIDA: UITextField!
    @IBOutlet private weak var searchView_HIDA: UIView!
    @IBOutlet private weak var resultView_HIDA: UIView!
    @IBOutlet private weak var resultTableView_HIDA: UITableView!
    
    @IBOutlet private weak var bottomViewHeight_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var searchViewHeight_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var resultViewHeight_HIDA: NSLayoutConstraint!
    
    @IBOutlet private weak var rightIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_HIDA: NSLayoutConstraint!
    
    var textDidChange_HIDA: ((String?) -> Void)?
    var results_HIDA: [String] = []
    var dismiss_HIDA: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib_HIDA()
        setupViews_HIDA()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib_HIDA()
        setupViews_HIDA()
    }
    
    private func setupViews_HIDA() {
        searchTextField_HIDA.addTarget(self, action: #selector(textFieldDidChange_HIDA), for: .editingChanged)
        configureLayout_HIDA()
        configureTableView_HIDA()
    }
    
    private func configureLayout_HIDA() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        rightIndentConstraint_HIDA.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint_HIDA.constant = deviceType == .phone ? 20 : 85
        let fontSize: CGFloat = deviceType == .phone ? 22 : 28
        searchTextField_HIDA.font = UIFont(name: "SF Pro Display Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        searchTextField_HIDA.textColor = .white
        bottomViewHeight_HIDA.constant = deviceType == .phone ? 58 : 97
        searchViewHeight_HIDA.constant = deviceType == .phone ? 45 : 62
        resultView_HIDA.layer.cornerRadius = 12
        resultView_HIDA.layer.masksToBounds = true
        searchView_HIDA.layer.cornerRadius = deviceType == .phone ? 12 : 20
        resultViewHeight_HIDA.constant = 0
    }
    
    func configureTableView_HIDA() {
        resultTableView_HIDA.separatorStyle = .none
        resultTableView_HIDA.allowsMultipleSelection = false
        resultTableView_HIDA.registerNib_HIDA(for: DropDownCell_HIDA.self)
        resultTableView_HIDA.layer.cornerRadius = 12
    }
    
    func updateResultView_HIDA(with results: [String]) {
        self.results_HIDA = results
        let deviceType = UIDevice.current.userInterfaceIdiom
        let height: CGFloat = deviceType == .phone ? 48 : 63
        resultViewHeight_HIDA.constant = height * CGFloat(results.count)
        resultTableView_HIDA.reloadData()
    }
    
    @objc
    private func textFieldDidChange_HIDA(_ textField: UITextField) {
        textDidChange_HIDA?(textField.text)
    }
    
    @IBAction func dismissButtonDidTap_HIDA(_ sender: UIButton) {
        textDidChange_HIDA?(nil)
        searchTextField_HIDA.text = nil
        updateResultView_HIDA(with: [])
        searchTextField_HIDA.resignFirstResponder()
        dismiss_HIDA?()
    }
}

extension SearchBar_HIDA: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SearchBar_HIDA: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results_HIDA.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownCell_HIDA.identifier_HIDA, for: indexPath) as! DropDownCell_HIDA
        cell.buildCell_HIDA(with: results_HIDA[indexPath.row], titleColor: UIColor.white)
        return cell
    }
}

extension SearchBar_HIDA: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = results_HIDA[indexPath.row]
        searchTextField_HIDA.text = category
        textDidChange_HIDA?(category)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let deviceType = UIDevice.current.userInterfaceIdiom
        return deviceType == .phone ? 48 : 63
    }
}
