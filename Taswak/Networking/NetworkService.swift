//
//  NetworkService.swift
//  Taswak
//
//  Created by omar  on 09/03/2022.
//

import Foundation
struct NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func getFavoriteItems(headers:[String:String],completion:@escaping(Result<FavoritesItems,Error>)->Void){
        request(route: .getFavorites, methode: .get, headers: headers, parameters: nil, completion: completion)
    }
    
    func addOrDeleteFavourite(headers:[String:String],parameters:[String:Any],completion:@escaping(Result<AddDeleteFavoriteResponse,Error>)->Void){
        request(route: .addOrDeletefavorites, methode: .post, headers: headers, parameters: parameters, completion: completion)
    }
    
    func searchProuducts(headers:[String:String]?,parameters:[String:Any],complition: @escaping(Result<SearchProduct,Error>)->Void){
        request(route: .searchProducts, methode: .post, headers: headers, parameters: parameters, completion: complition)
    }
    
    func getCart(headers:[String:String]?, completion: @escaping(Result<CartItems,Error>)->Void){
        request(route: .getCart, methode: .get, headers: headers, parameters: nil, completion: completion)
    }
    
    func addOrDeleteToCart(headers:[String:String],parameters:[String:Any], completion: @escaping(Result<CartResponse,Error>)->Void){
        request(route: .addOrDeleteToCart, methode: .post, headers: headers, parameters: parameters, completion: completion)
    }
    
    func register(parameters:[String:Any], complition: @escaping(Result<RegisterResponse,Error>)->Void){
        request(route: .register, methode: .post, parameters: parameters, completion: complition)
    }
    
    func login(parameters: [String: Any], completion: @escaping(Result<LoginResponse,Error>)->Void){
        request(route: .loginIn, methode: .post, parameters: parameters, completion: completion)
    }
    func fetchAllCategories(completion: @escaping(Result<ApiResponse,Error>)->Void){
        request(route: .allCategories, methode: .get, completion: completion)
    }
    func fetchOneCategory(header:[String:String]?,categoryId:Int,completion: @escaping(Result<OneCategory,Error>)->Void){
        request(route: .oneCategory(categoryId), methode: .get, headers: header, parameters: nil, completion: completion)
    }
    func fetchhomeAndBanner(completion:@escaping(Result<HomeAndBanner,Error>)->Void){
        request(route: .homeAndBanner, methode: .get, completion: completion)
    }
    
     private func request <T:Decodable>(route: Route,
                                      methode: Method,
                                      headers:[String:String]? = nil,
                                      parameters: [String: Any]? = nil,
                                      completion: @escaping(Result <T,Error>) -> Void ){
        guard let urlRequest = createRequest(route: route, method: methode, headers: headers, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        URLSession.shared.dataTask(with: urlRequest){(data,response,error) in
            var result: Result <Data, Error >?
            if let data = data{
                result = .success(data)
                let dataString = String(data: data, encoding: .utf8)
//                print("Data String is \(dataString)")
            }else if let error = error{
                result = .failure(error)
            }
            
            DispatchQueue.main.async {
                self.handleRequest(result: result, completion: completion)
            }
            
        }.resume()
    }
    
    private func handleRequest<T:Decodable>(result: Result<Data, Error>?,
                                         completion: (Result<T,Error>)-> Void){
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch let error {
                    print("decoding Error is: \(error)")
                    completion(.failure(error))
                }
        case .failure(let error):
        completion(.failure(error))
        }
        
//        The Following commented code is is used by Emmanuell in his tutorial as he is parsing JSON into APIResponse Model as his JSON response hase parameteros of sataus, error, messege and data and in our case we dont have these parameters so we dont have to use APIResponse model so we comment it and use upper code lines instead
     /*
        switch result{
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(APIResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }

            if let error = response.error{
                completion(.failure(AppError.serverError(error)))
                return
            }

            if let decodedData = response.data{
                completion(.success(decodedData))
            }else {
                completion(.failure(AppError.unknownError))
            }
        case .failure (let error):
            completion(.failure(error))
        }
 */
    }
    
    /// Func To make URL Request
    /// - Parameters:
    ///   - route: to define the complete path of the APi Url
    ///   - method: to determine wich method api is like . post .GET ....
    ///   - parameters: parametes to be sent with the API end point if there
    /// - Returns: return is expected to urlRequest
    
    func createRequest(route: Route,
                       method: Method,
                       headers:[String:String]?,
                       parameters: [String: Any]?) -> URLRequest? {
        let urlString = Route.baseUrl + route.description        
        guard let url = urlString.asUrl else { return nil }
        print(url)
        var urlRequest = URLRequest(url: url)
        
//        Adding Headers to request if exsist
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("en", forHTTPHeaderField: "lang")
        if let headers = headers{
            urlRequest.allHTTPHeaderFields = headers
        }

        urlRequest.httpMethod = method.rawValue
        if let params = parameters{
            switch method{
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map {
                    URLQueryItem(name: $0, value: "\($1)")
                }
                    urlRequest.url = urlComponent?.url
                
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}
