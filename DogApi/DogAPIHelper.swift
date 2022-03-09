//
//  DogAPIHelper.swift
//  DogApi
//
//  Created by Francisco Escobar on 2022-02-13.
//

import Foundation

struct DogAPIHelper{
   private static let baseURL = "https://pokeapi.co/api/v2/pokemon"

 private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    
    
    static func fetch(callback: @escaping ([Dog]) -> Void){
        guard
        let url = URL(string: baseURL)
        else{return}
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            data, request, error in
            
            if let data = data {
                do{
                    let jsonObject = try JSONSerialization.jsonObject(with: data,
                    options: [])
                    
            guard
            let jsonDictionary = jsonObject as? [AnyHashable: Any],
            let results = jsonDictionary["results"] as? [[String:String]]
            else{preconditionFailure("Was not able to retreive results.")}
            print(results)
             
                   
                    var dogList = [Dog]()
                    for dog in results {
                        let newDog = Dog(name: dog["name"]!, url: dog["url"]!)
                        dogList.append(newDog)
                    }
                    
                
                    
                    OperationQueue.main.addOperation {
                        for _ in 1...1000{
                            continue
                        }
                        callback(dogList)
                    }
                    
                            
                } catch let e {
                    print("Could not serialize json data\(e)")
                }
            }else if let error = error {
                print("something went wrong when fetching. ERROR\(error)")
            }else {
                print("unknown error ")
            }
        }
        task.resume()
    }
}


