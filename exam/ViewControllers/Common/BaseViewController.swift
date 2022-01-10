//
//  BaseViewController.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import UIKit
import RxSwift
import RxAppState

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()

    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()

    deinit {
        print("DEINIT: \(self.className)")
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        _ = rx.viewDidLoad
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        _ = rx.viewDidLoad
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        _ = rx.viewDidLoad
    }
}
