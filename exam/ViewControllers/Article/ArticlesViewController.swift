//
//  ArticlesViewController.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import ReactorKit
import Rswift
import RxAppState
import Resolver

class ArticlesViewController: BaseViewController, StoryboardView {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(R.nib.articleCell)
        }
    }
}

extension ArticlesViewController {
    func bind(reactor: ArticlesViewReactor) {
        
        // Action
        rx.viewDidLoad
            .mapTo(Reactor.Action.observeArticles)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        rx.viewDidLoad
            .mapTo(Reactor.Action.getArticles)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state.filterMap { $0.isNeedToUpdate ? .map(()) : .ignore }
            .bind(onNext: tableView.reloadData)
            .disposed(by: disposeBag)
    }
}

// MARK: UITableViewDataSource
extension ArticlesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reactor?.currentState.articles.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.articleCell, for: indexPath), let state = reactor?.currentState else {
            fatalError()
        }
        cell.bind(element: state.articles[indexPath.row])
        return cell
    }
}

// MARK: DI
extension ArticlesViewController: StoryboardResolving {
  
    func resolveViewController() {
        reactor = resolver.optional()
    }
}
