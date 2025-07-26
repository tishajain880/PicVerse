# Assignment 1

Name : Tisha Jain

Id : 202412026

## Project Title: PicVerse – A Smart Image Sharing & Community Platform

This document outlines the core concepts used in the PicVerse project. The concepts are categorized into three sections: Objects, Context, and Information (as per context).

## Objects

These are the primary components of the system, represented as entities in the codebase:

- User → Represents any registered person on the platform
- Image → An image file uploaded by a user
- Comment → A text-based response to an image or a discussion thread
- Like → An expression of appreciation given to an image or comment
- DiscussionThread → A topic posted in the discussion forum
- Message → A private, direct message between users
- Session → Represents the login activity of a user
- Admin → A privileged user with permissions to assign badges and ban users
- Badge → A reward or recognition assigned to users by the admin

## Context

This section describes scenarios where the above objects are used:

- User registration and login  
  → Involves User and Session

- Uploading an image  
  → Involves User and Image

- Commenting on images or threads  
  → Involves User, Comment, and either Image or DiscussionThread

- Liking content  
  → Involves User, Like, and either Image or Comment

- Creating discussion threads  
  → Involves User and DiscussionThread

- Sending private messages  
  → Involves User and Message

- Assigning badges  
  → Involves Admin, Badge, and User

- Banning a user  
  → Involves Admin and User

## Information (as per context)

This section lists the data points used in each context:

- User registration and login  
  → username, email, password, profile picture, bio, session token, login time

- Image upload  
  → image file, caption, uploaded by, upload timestamp

- Commenting  
  → comment text, author ID, parent type (image/thread), comment timestamp

- Liking  
  → liked by (user ID), target type (image/comment), target ID, timestamp

- Discussion threads  
  → thread title, content, created by, created at

- Messaging  
  → sender ID, receiver ID, message body, sent time

- Badge assignment  
  → badge name, assigned to (user ID), reason, assigned by (admin ID), assigned date

- Banning a user  
  → banned user ID, reason for ban, banned by (admin ID), date of ban

- Session tracking  
  → session token, user ID, login time, logout time
