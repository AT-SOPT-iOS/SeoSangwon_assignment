//
//  ViewController.swift
//  SOPT36_week01
//
//  Created by 서상원 on 4/5/25.
//

import UIKit

class ViewController: UIViewController {

    private var testView: UIView = UIView(frame: .init(origin: .init(x: 300, y: 300),
                                                       size: .init(width: 300, height: 300)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        testView.backgroundColor = .magenta
        
        self.view.addSubview(testView)
    }
}

