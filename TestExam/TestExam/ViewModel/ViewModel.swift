//
//  ViewModel.swift
//  TestExam
//
//  Created by Mahmud Mostofa on 17/8/22.
//

import Foundation

struct Parser {
    
    func parse(comp : @escaping ([Result])->()){
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=marvel")!)){
            (data,req,error) in
            
            do{
                let result = try JSONDecoder().decode(MovieResult.self, from: data!)
                comp(result.results)
            } catch {
                
            }
        } .resume()
    }
}

    
