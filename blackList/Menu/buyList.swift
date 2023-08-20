//
//  buyList.swift
//  blackList
//
//  Created by Olzhas Zhakan on 19.07.2023.
//

import UIKit
import Foil
import RealmSwift

class ProductClass: Object {
    @Persisted var name: String = ""
    @Persisted var amount: Int = 0
    @Persisted var selected: Bool = false
}

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    var products: Results<ProductClass>?
    var notificationToker: NotificationToken?
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        realmProducts()
        if let realm = try? Realm() {
                print("Realm database file URL: \(realm.configuration.fileURL?.path ?? "Not available")")
            }
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorColor = .systemBlue
    }
    private func realmProducts() {
        products = realm.objects(ProductClass.self)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Название товара: \(product?.name ?? ""), Количество: \(product?.amount ?? 0)"
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let object = products?[indexPath.row] else { return }
            try! realm.write {
                realm.delete(object)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Добавить товар", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Название товара"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Количество"
            textField.keyboardType = .decimalPad
        }
        let addAction = UIAlertAction(title: "Добавить", style: .default) { action in
            guard let productName = alertController.textFields?[0].text, let productAmount = alertController.textFields?[1].text else { return }
            let product = ProductClass()
            product.name = productName
            product.amount = Int(productAmount) ?? 0
            try! self.realm.write {
                self.realm.add(product)
            }
            self.realmProducts()
        }

        alertController.addAction(addAction)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
