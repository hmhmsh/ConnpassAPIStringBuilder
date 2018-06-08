# ConnpassAPIStringBuilder

ConnpassのAPIのQueryを簡単に使えます。
Queryを組み込んだString型のリクエストurl、または、Queryを[String: Any]型にしたものを生成できます。

# Usage

## Provide Request Url
```swift
let requestUrl = ConnpassAPIQueryBuilder().keywordAnd("swift").start(30).string()
// requestUrl = "https://connpass.com/api/v1/event/?keyword=swift&start=30"
```

- 複数の値の指定

可変長引数のメソッドでは複数の指定が可能です。
```swift
let requestUrl = ConnpassAPIQueryBuilder().keywordAnd("swift", "swift4").string()
// requestUrl = "https://connpass.com/api/v1/event/?keyword=swift&keyword=swift4"
```

## Provide Dictionary
```swift
let dictionary = ConnpassAPIQueryBuilder().eventId(0).dictionary()
// dictionary = ["event_id":0]
```

- 複数の値の指定

複数の値を指定した場合、valueが配列になります。
```swift
let dictionary = ConnpassAPIQueryBuilder().keywordAnd("swift", "swift4").dictionary()
// dictionary = ["keyword":["swift","swift4"]]
```
