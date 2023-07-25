//
//  menuViewController.swift
//  blackList
//
//  Created by Olzhas Zhakan on 19.07.2023.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {
    
    let homeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Главный экран", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(home), for: .touchUpInside)
        return button
    }()
    let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Список покупок", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buy), for: .touchUpInside)
        return button
    }()
    let settingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Настойки", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        return button
    }()
    let secondBuy: UIButton = {
        let button = UIButton()
        button.setTitle("Второй метод", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(secondBuyButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        view.addSubview(homeButton)
        view.addSubview(buyButton)
        view.addSubview(settingButton)
        view.addSubview(secondBuy)
        makeConstraints()
        setupButtonIcons()
        
    }
    func makeConstraints() {
        homeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-85)
            $0.top.equalToSuperview().offset(20)
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        buyButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-80)
            $0.top.equalTo(homeButton.snp.bottom).offset(20)
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        settingButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-105)
            $0.top.equalTo(buyButton.snp.bottom).offset(20)
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        secondBuy.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-88.4)
            $0.top.equalTo(settingButton.snp.bottom).offset(20)
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        
    }
    func setupButtonIcons() {
        let homeIcon = UIImage(systemName: "house")
        homeButton.setImage(homeIcon, for: .normal)
        homeButton.imageView?.contentMode = .scaleAspectFit
        homeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        
        
        let buyIcon = UIImage(systemName: "cart")
        buyButton.setImage(buyIcon, for: .normal)
        buyButton.imageView?.contentMode = .scaleAspectFit
        buyButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        
        
        let settingIcon = UIImage(systemName: "gearshape")
        settingButton.setImage(settingIcon, for: .normal)
        settingButton.imageView?.contentMode = .scaleAspectFit
        settingButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 42)
        
        let buyIcon2 = UIImage(systemName: "cart")
        secondBuy.setImage(buyIcon2, for: .normal)
        secondBuy.imageView?.contentMode = .scaleAspectFit
        secondBuy.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
    }
    func setButtonTitleColor(_ color: UIColor) {
        homeButton.setTitleColor(color, for: .normal)
        buyButton.setTitleColor(color, for: .normal)
        settingButton.setTitleColor(color, for: .normal)
        secondBuy.setTitleColor(color, for: .normal)
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            if self.traitCollection.userInterfaceStyle == .dark {
                view.backgroundColor = .systemGray6
                setButtonTitleColor(.white)
            } else {
                view.backgroundColor = .white
                setButtonTitleColor(.black)
            }
        }
    }
    
    
    @objc func home() {
        dismiss(animated: true, completion: nil)
        
    }
    @objc func buy() {
        let viewController = TableViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    @objc func settingButtonTapped() {
        let viewController = SettingsViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    @objc func secondBuyButton() {
        let viewController = SecondOption()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}
