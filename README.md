# SnapBook

## Authors
*  Jake Moskowitz
*  Alex Zhang

## Purpose
SnapBook is an app that allows you to post messages or photos that expire and
get deleted after a certain duration. Likes and comments extend the duration of
posts, so the hotter it gets, the longer it burns!

## Features
* Ability to post photos/text
* Comment on posts, and view all comments
* Upvote/Downvote posts (increase/decrease duration)
* Filter by most recent posts/hottest ones
* Ability to create an account and a profile with avatar
* *(Optional)* Profile page has stats like number of posts, total duration,
longest running post
* *(Optional)* Ability to view posts based on geolocation or globally
* *(Optional)* Leaderboard with longest running posts based on week, day, year,
 all time
* *(Optional)* Ability to add other users with friends and only share with a
 subset of them

## Control Flow
Users are initially presented with a sign up page when viewing the app first
time. After registering, they will then see a list of the top active posts, and
can choose to browse and interact (comment, upvote/downvote) with the posts.
They can also view other people's profiles.

## Implementation
*Does not include optional features*

### Model
*  User.swift
*  Post.swift
*  Comment.swift

### View
*  UserProfileView
*  PostTableView
*  PostView
*  NewPostView
*  UserRegistrationView
*  UserSignInView

### Controller
*  UserProfileViewController
*  PostTableViewController
*  PostViewController
*  NewPostViewController
*  UserRegistrationViewController
*  UserSignInViewController
