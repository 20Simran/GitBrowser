//
//  DateUtility.swift
//  GitBrowser
//
//  Created by Simran Semwal on 17/07/25.
//

import Foundation
struct FCDateUtility {
    
    static func formatDateString(_ inputDateString: String,
                                  from inputFormat: String,
                                  to outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        guard let date = dateFormatter.date(from: inputDateString) else {
            return nil
        }
        
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date)
    }
}
