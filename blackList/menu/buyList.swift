//
//  buyList.swift
//  blackList
//
//  Created by Olzhas Zhakan on 19.07.2023.
//

import UIKit
import Foil

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    var selectedProducts: Set<Int> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Список покупок"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDefaults.shared.shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let productJSONString = AppDefaults.shared.shoppingList[indexPath.row]
        let product = JSONHelper.convertJSON(productJSONString) ?? Product(name: "Error", amount: 0, selected: false)

        cell.textLabel?.text = "\(product.name), \(product.amount)"
         
        cell.accessoryType = product.selected ? .checkmark : .none
          cell.selectionStyle = .default
          
          if self.traitCollection.userInterfaceStyle == .dark {
              cell.textLabel?.textColor = product.selected ? .gray : .white
          } else {
              cell.textLabel?.textColor = product.selected ? .gray : .black
          }


        return cell
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let productJSONString = AppDefaults.shared.shoppingList[indexPath.row]
        let product = JSONHelper.convertJSON(productJSONString) ?? Product(name: "Error", amount: 0, selected: false)
        
        let newProduct = Product(name: product.name, amount: product.amount, selected: !product.selected)
        let newProductJSONString = JSONHelper.convertToJSONString(newProduct)!
        
        AppDefaults.shared.shoppingList[indexPath.row] = newProductJSONString
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDefaults.shared.shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    @objc private func addButtonTapped() {
        let alertController = UIAlertController(title: "Добавить товар", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Название товара"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Количество"
            textField.keyboardType = .numberPad
        }
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { (action) in
            if let nameTextField = alertController.textFields?[0],
               let amountTextField = alertController.textFields?[1],
               let name = nameTextField.text,
               let amountString = amountTextField.text,
               let amount = Int(amountString) {
                let product = Product(name: name, amount: amount, selected: false)
                let productJSONString = JSONHelper.convertToJSONString(product)
                AppDefaults.shared.shoppingList.append(productJSONString!)
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
