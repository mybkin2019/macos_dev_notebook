//
//  Logger.swift
//  MacosDevNotebook
//
//  Created by mabs on 28/11/2022.
//

import Cocoa

class Logger: NSObject {
    static let shared = makeShared()
    
    var loggerConfig: LoggerConfig
    
    init(with loggerConfig: LoggerConfig) {
        self.loggerConfig = loggerConfig
    }
    
    func logToConsole(_ msg: Any) -> () {
        if true == loggerConfig.canPrintToConsole {
            print(msg)
        }
    }
    
    func logToConsole(_ msgs: Any...) -> () {
        if true == loggerConfig.canPrintToConsole {
            print(msgs)
        }
    }
    
    private static func makeShared() -> Logger {
        let config = LoggerConfig()
        return Logger(with: config)
    }
}

class LoggerConfig: NSObject {
    var canPrintToConsole: Bool = true
}
