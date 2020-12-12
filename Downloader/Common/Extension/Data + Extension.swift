//
//  String + Extension.swift
//  Downloader
//
//  Created by Alex Kharchenko on 12.12.2020.
//

import Foundation

extension Data {
    
    func getDataModel<DataModel>(model: DataModel.Type) -> DataModel? where DataModel : Decodable {
        do {
            return try JSONDecoder().decode(model, from: self)
        } catch {
            return nil
        }
    }
    
    func getSizeInMB() -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
        bcf.countStyle = .file
        return bcf.string(fromByteCount: Int64(self.count))
    }
    
}


