//
//  URLRequest+Extensions.swift
//  NEWSAPPWITHRxSwift_Rxcoco
//
//  Created by IwasakIYuta on 2022/01/12.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    //Observable<T?>を返してサブスクできるようにする
    static func load<T>(resource: Resource<T>) -> Observable<T?> {
        
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T? in
                return try? JSONDecoder().decode(T.self, from: data)
                
        }.asObservable()
        
    }
    
}
