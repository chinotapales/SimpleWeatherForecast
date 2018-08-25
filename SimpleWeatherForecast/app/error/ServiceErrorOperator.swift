//
//  ServiceErrorOperator.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation
import RxSwift
import Moya

extension ObservableType where E == Response {
    
    func mapErrors() -> Observable<E> {
        return self
            .filterSuccessfulStatusCodes()
            .catchError({ (e) -> Observable<Response> in
                
                guard let error = e as? MoyaError else { throw e }
                guard case .statusCode(let errorAsResponse) = error else { throw e }
                
                if let mappableError = try? errorAsResponse.map(ApiError.self) {
                    throw mappableError
                }
                
                throw e
                
            })
        
    }
    
}
