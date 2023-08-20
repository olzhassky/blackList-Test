//
//  TrySecondOption.swift
//  blackList
//
//  Created by Olzhas Zhakan on 23.07.2023.
//

import UIKit
import SnapKit

class SecondOption: UIViewController {
    let vegetables: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(vegetablesButton), for: .touchUpInside)
        let backgroundImage = UIImage(named: "vegetables")
        button.setImage(backgroundImage, for: .normal)
        return button
    }()
    let meat: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(meatButton), for: .touchUpInside)
        let backgroundImage = UIImage(named: "meat")
        button.setImage(backgroundImage, for: .normal)
        return button
    }()
    let dairy: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dairyButton), for: .touchUpInside)
        let backgroundImage = UIImage(named: "dairy")
        button.setImage(backgroundImage, for: .normal)
        return button
    }()

  
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        view.addSubview(vegetables)
        view.addSubview(meat)
        view.addSubview(dairy)
        makeConstraints()
        
        
    }
    func setupNavigationBar() {
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Второй метод"
    }
    func makeConstraints() {
        vegetables.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-220)
            $0.width.equalTo(400)
            $0.height.equalTo(200)
        }
        meat.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-5)
            $0.width.equalTo(400)
            $0.height.equalTo(200)
        }
        dairy.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(210)
            $0.width.equalTo(400)
            $0.height.equalTo(200)
        }
    
    }

    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    @objc func vegetablesButton() {
            let viewController = TableViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        }
    @objc func meatButton() {
        let viewController = TableViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    @objc func dairyButton() {
        let viewController = TableViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    }



