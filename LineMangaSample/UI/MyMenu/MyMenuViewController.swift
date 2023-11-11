//
//  MyMenuViewController.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/11.
//

import UIKit

final class MyMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        cofigureHierarchy()
    }
}

extension MyMenuViewController {
    private func cofigureHierarchy() {
        self.navigationItem.title = "マイメニュー"
    }
}
