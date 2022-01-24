//
//  GetData.swift
//  A4
//
//  Created by ofir david on 2021-12-01.
//

import SwiftUI

public struct Score: Codable, Hashable{
    
    public var ID: String
    public var Name: String
    public var Score: String
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(Name)
    }
}


public class GetData: ObservableObject {
  
  @Published var scores = [Score]()
    
    init() {
          
        let url = URL(string: "https://davidof.dev.fast.sheridanc.on.ca/mydata/sqlToJson.php")!
      
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let scoreData = data {
                    
                    let decodedData = try JSONDecoder().decode([Score].self, from: scoreData)
                    DispatchQueue.main.async {
                        print(decodedData)
                        self.scores = decodedData
                        
                    }
                } else {
                    print("No data")
                }
            } catch {
            
                print("Error: \(error)")
            }
        }.resume()
 
    }
      
}
