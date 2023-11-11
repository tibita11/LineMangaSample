//
//  LineMangaNavigationController.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/11.
//

import UIKit

enum Target {
    case myMenu
    case search
}

final class LineMangaNavigationController: UINavigationController {
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: false)
    }
}

extension UINavigationController {
    
    func transition(target: Target) {
        switch target {
        case .myMenu:
            let myMenuVC = MyMenuViewController()
            self.pushViewController(myMenuVC, animated: false)
        case .search:
            let searchVC = SearchViewController()
            self.pushViewController(searchVC, animated: false)
        }
    }
    
    func addCommonButton(to viewController: UIViewController) {
        navigationBar.isHidden = false
        viewController.navigationItem.backButtonDisplayMode = .minimal
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(tapMyMenuButton))
        viewController.navigationItem.rightBarButtonItem?.tintColor = .black
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(tapSearchButton))
    }
    
    @objc private func tapMyMenuButton() {
        transition(target: .myMenu)
    }
    
    @objc private func tapSearchButton() {
        transition(target: .search)
    }
    
}
