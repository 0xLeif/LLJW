import Fluent
import Vapor

final class Quote: Model, Content {
    static let schema = "quotes"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "quote")
    var quote: String

    init() { }

    init(id: UUID? = nil, title: String, quote: String) {
        self.id = id
        self.title = title
        self.quote = quote
    }
}
