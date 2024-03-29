//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 27..
//

import SwiftHtml

struct AggregatorFeedPageTemplate: TemplateRepresentable {
    
    var context: AggregatorFeedPageContext
    
    init(_ context: AggregatorFeedPageContext) {    
        self.context = context
    }
    
    @TagBuilder
    func render(_ req: Request) -> Tag {
        WebIndexTemplate(.init(title: "items")) {
            Div {
                Header {
                    H1("Feed items")
                    P("Latest news from all around the world.")
                }
                .class("lead")

                Section {
                    for group in context.groups {
                        Div {
                            P {
                                Span("\(group.items.count) item\(group.items.count > 1 ? "s" : "")")
                                Text(" &middot; ")
                                Text(group.day)
                            }
                            
                            for item in group.items {
                                A {
                                    Div {
                                        if let key = item.feed.imageKey {
                                            Img(src: req.fs.resolve(key: key), alt: item.feed.title)
                                                .class("profile")
                                        }
                                        H3(item.feed.title)
                                        H2(item.title)
                                    }
                                    .class("content")
                                }
                                .class("card")
                                .target(.blank)
                                .href(item.url)
                            }
                            
                        }
                        .class("group")
                    }
                }
            }
            .id("feed-items")
            .class("container")
        }
        .render(req)
    }
}

