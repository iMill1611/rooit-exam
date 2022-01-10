//
//  Networking.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import RxSwift
import Moya

class Networking<Target>: MoyaProvider<Target> where Target: TargetType {

    init(plugins: [PluginType] = [], stubClosure: @escaping StubClosure = MoyaProvider.neverStub) {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = API.timeout
        
        super.init(stubClosure: stubClosure,
                   session: Session(configuration: configuration, startRequestsImmediately: false),
                   plugins: plugins)
    }

    func request(_ target: Target) -> Observable<Response> {
        return Single.create { [weak self] single in
            let cancellableToken = self?.request(target) { result in
                switch result {
                case let .success(response):
                    if (200...299).contains(response.statusCode) {
                        single(.success(response))
                    } else {
                        single(.error(MoyaError.statusCode(response).transform()))
                    }

                case let .failure(error):
                    single(.error(error.transform()))
                }
            }
            return Disposables.create {
                cancellableToken?.cancel()
            }}
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.asyncInstance)
            .asObservable()
    }
}
