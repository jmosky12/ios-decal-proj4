# SnapBook

## Authors
*  Jake Moskowitz
*  Alex Zhang

## Purpose
SnapBook is an app that allows you to post messages or photos that expire and get deleted after a certain duration. Likes and comments extend the duration of posts, so the hotter it gets, the longer it burns!

## Features
* Ability to post photos/text
* Comment on posts, and view all comments
* Upvote/Downvote posts (increase/decrease duration)
* Filter by most recent posts/hottest ones
* Ability to create an account and a profile with avatar
* (Optional) Profile page has stats like number of posts, total duration, longest running post
* (Optional) Ability to view posts based on geolocation or globally
* (Optional) Leaderboard with longest running posts based on week, day, year, all time
* (Optional) Ability to add other users with friends and only share with a subset of them


## Control Flow

Users are initially presented with a list of the top active posts, and can choose to browse anonymously and interact with the posts without registering. They can also post
-idea: can be anonymous or registered, registered has stats, anonymous could still have stats (still assign unique ids to people even if anonymous)
-can post or comment
-firebase
-circle visualization with color of remaining duration
Bullet Points: [Walk us through how your app would work - how the user would interact with it, starting from the initial screen. e.g. Users are initially presented with a splash screen, where they can log in or browse as a guest. Once done, they see a curated list of some of the newest and coolest cat outfits. Tapping on a cat outfit entry takes you to that cat outfit's listing page.]

## Implementation
### Model
*  User.swift
*  Post.swift
*  Comment.swift

### View
*  UserProfileView
*  PostTableView
*  PostView
*  NewPostView

### Controller
*  UserProfileViewController
*  PostTableViewController
*  PostViewController
*  NewPostViewControllre
*  UserRegistration
*  LeaderboardView
*  UserSignIn


