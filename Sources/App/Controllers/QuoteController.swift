import Fluent
import Vapor

struct QuoteController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let quotes = routes.grouped("quotes")
        quotes.get(use: index)
        quotes.post(use: create)
        quotes.group(":quoteID") { quote in
            quote.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Quote]> {
        return Quote.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Quote> {
        let quote = try req.content.decode(Quote.self)
        return quote.save(on: req.db).map { quote }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Quote.find(req.parameters.get("quoteID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
