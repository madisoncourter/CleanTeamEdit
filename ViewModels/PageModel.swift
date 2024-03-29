//
//  PageModel.swift
//  CleanTeamEdit
//
//  Created by Madison  Courter on 12/7/23.
//

import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var image: String
    var tag: Int
    
    static var samplePage = Page(name: "Title Example", description: "This is a sample description for the purpose of debugging", image: "work", tag: 0)
    
    static var samplePages: [Page] = [
        Page(name: "Welcome to CleanTeam!", description: "Live better, together", image: "Welcome Screen", tag: 0),
        Page(name: "Accountability, Finally", description: "Teammates have a shared chore to-do list, keeping everyone accountable.", image: "To-Do Screen", tag: 1),
        Page(name: "Leaderboard Glory", description: "Complete a task, check it off, and earn points! Gain more points to win rewards or avoid penalties.", image: "Leaderboard Screen", tag: 2),
        Page(name: "Reward or Penalize? You Decide!", description: "Choose between two systems: rewards for the highest points or penalties for the lowest. Your call!", image: "Rewards Screen", tag: 3),
        Page(name: "Silently Nunge", description: "If you feel like a teammate is slacking on their chores, you can anonymously nudge them to keep them motivated.", image: "Nudge Screen", tag: 4),
        Page(name: "Congrats!", description: "Now you're ready to create or join a group and live better together!", image: "Congratulations Screen", tag: 5),
    ]
}
