public class Log {
  
  public static var prefix: String = "test:"
  public static var dateFormat: String = "{yyyy MMM dd}"
  public static var timeFormat: String = "[HH:mm:ss]"
  
  public static var withTime: Bool = true
  public static var withPrefix: Bool = true
  public static var withLine: Bool = true
  
}

// Logging
extension Log {
  public class func debug(line: Int = #line, _ key: String = "", _ date: Date?, _ showTime: Bool = true) {
    print("\(fullPrefix(line: line)) \(key) - \(formattedDate(of: date, showTime: showTime))")
  }
  
  public class func debug(line: Int = #line, _ date: Date?, _ showTime: Bool = true) {
    print("\(fullPrefix(line: line)) \(formattedDate(of: date, showTime: showTime))")
  }
  
  public class func debug(line: Int = #line, _ key: String = "", _ object: Any?) {
    let value = object != nil ? object : ""
    print("\(fullPrefix(line: line)) \(key) - \(value ?? "nil")")
  }
  
  public class func debug(line: Int = #line, _ object:Any?) {
    let value = object != nil ? object : ""
    print("\(fullPrefix(line: line)) \(value ?? "nil")")
  }
  
  public class func line(line: Int = #line) {
    print("\(fullPrefix(line: line)) ----------------")
  }
  
  public class func thisFunction(file: String = #file, functionName: String = #function, line: Int = #line) {
    let functionName = Log.functionName(file: file, functionName: functionName, line: line)
    print("\(fullPrefix(line: line)) \(functionName)")
  }
}

// Helpers
private extension Log {
  class func functionName(file: String, functionName: String, line: Int) -> String {
    let fileName = file.components(separatedBy: "/").last!.components(separatedBy: ".").first!
    return "\(fileName).\(functionName)[\(line)]"
  }
  
  class func lineNumber(line: Int) -> String {
    return "[\(line)]"
  }
  
  class func fullPrefix(line: Int) -> String {
    let prefix = withPrefix ? prefix : ""
    let timePrefix = withTime ? lineTime() : ""
    let linePrefix = withLine ? lineNumber(line: line) : ""
    return "\(prefix) \(timePrefix) \(linePrefix) -"
  }
  
  class func lineTime() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = timeFormat
    return dateFormatter.string(from: Date())
  }
  
  class func formattedDate(of date: Date?, showTime: Bool = true) -> String {
    guard let date = date else { return "nil" }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    if showTime {
      dateFormatter.dateFormat += " \(timeFormat)"
    }
    return dateFormatter.string(from: date)
  }
}
