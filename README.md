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
* Upvote posts to increase duration
* Filter by most recent posts/hottest ones
* Ability to create an account and a profile with avatar

## Control Flow
Users are initially presented with a sign up page when viewing the app first
time. After registering, they will then see a list of the recent/top active posts, and
can choose to boost the posts. They can also visit their own profile.

## Implementation
* Implement above features

### Model
*  Post.swift

### View
*  PostTableViewCell
*  PhotoPostTableViewCell
*  NewPostView
*  EditProfileView
*  UserProfileView
*  EmptyTableViewCell

### Controller
*  UserProfileViewController
*  EditProfileViewController
*  PostFeedTableViewController
*  NewPostViewController
