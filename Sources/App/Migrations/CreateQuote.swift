import Fluent

struct CreateQuote: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Quote.schema)
            .id()
            .field("title", .string, .required)
            .field("quote", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Quote.schema).delete()
    }
}
