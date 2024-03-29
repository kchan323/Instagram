# Project 4 - *Instagram*

**Instagram** is a photo sharing app using Parse as its backend.

Time spent: **22** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"
- [x] User can pull to refresh the last 20 posts submitted to "Instagram"
- [x] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [x] Run your app on your phone and use the camera to take the photo
- [x] Style the login page to look like the real Instagram login page.
- [x] Style the feed to look like the real Instagram feed.
- [x] User can use a tab bar to switch between all "Instagram" posts and posts published only by the user. AKA, tabs for Home Feed and Profile
- [x] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [x] Show the username and creation time for each post
- [x] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- User Profiles:
  - [x] Allow the logged in user to add a profile photo
  - [x] Display the profile photo with each post
  - [x] Tapping on a post's username or profile photo goes to that user's profile page
- [ ] User can comment on a post and see all comments for each post in the post details screen.
- [x] User can like a post and see number of likes for each post in the post details screen.
- [ ] Implement a custom camera view.

The following **additional** features are implemented:

- [x] Posts are displayed using a CollectionView
- [x] User can view post details by tapping on a cell
- [x] User sees an alert if either username or password field is empty when trying to log in
- [x] Using AutoLayout, Instagram should adjust it's layout for iPhone 7, Plus and SE device sizes as well as accommodate device rotation.
- [x] User can edit profile image and bio.
- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Protocols and delegates
2. Models

## Video Walkthrough

Here's a walkthrough of implemented user stories:

Sign up and log in
<img src='http://g.recordit.co/iqyeGAT0To.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Log out and alert if username/password is empty
<img src='http://g.recordit.co/vjGFI4E45U.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

User can post a photo and caption and pull to refresh
<img src='http://g.recordit.co/BY2mid9Lho.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

User can view more than 20 posts with infinite scroll
<img src='http://g.recordit.co/kXjY9u7VxA.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

User can use a tab bar for home and profile feeds and HUD while posts load
<img src='http://g.recordit.co/VPh2pMowF9.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

User can tap a post to view details and can like a post and see number of likes for each post
<img src='http://g.recordit.co/flvIhJcbfE.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

User can edit profile picture and bio
<img src='http://g.recordit.co/h3iZDZPK2r.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

User can tap on profile picture to view that user's profile page
<img src='http://g.recordit.co/6Es9iXXFLA.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

User can tap on a CollectionViewCell to view details
<img src='http://g.recordit.co/At4ohx0r7C.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />


GIF created with [Recordit](http://recordit.co).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- DateTools
- Parse
- MBProgressHUD

## Notes

Describe any challenges encountered while building the app.

## License

    Copyright [2019] [Katelin Chan]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
