# PRI @ morse
> **Privacy @ morse** using @sign P2P encryption

This project is created keeping **privacy** at the top of the head. What it looks from outside is just a chatting chatting. But it is built with privacy at it's core.

* P2P encryption (using **@sign**)
* Morse translation (uses **custom morse code standard**, on top of the INTERNATIONAL MORSE STD.)

> **NOTE:** This is just the concept of the app created as a part of the `@challenge` (Flutter Vikings Community). So, there is limited functionality and the experience can be a bit buggy.

***Disclaimer:** This solution was just created in a matter of some hours (approximately 11 hrs), including the concept, planning, set up and implementation.*

## @ a glance

![App](https://github.com/sbis04/pri_at_morse/raw/master/screenshots/pri%40morse.png)

## @Concept

There are very few apps in the market who are really concerned about privacy of it's users. This concept came in my mind thinking of just how to protect privacy (but not overdoing it).

The app provides privacy at the server level using the `@protocol` designed by "**The @ Company**". And, it also provides in the app level (the frontend) by translating the texts to a `Morse code`, which can be converted to a normal text with just a click of a button.

*I believe this concept will help to secure user data at the utmost level possible.*

## @Planing

![Planing](https://github.com/sbis04/pri_at_morse/raw/master/screenshots/planing.png)

## @Usage

In order to use this app, you need to do some set up:

> This app is tested on **Android** only (due to time constraint).
> Used the id as `com.example.newserverdemo`, because any other id is causing an issue in connection.

***@1:*** Run the **Docker** container to start the virtual environment

***@2:*** Set up networking (add the required DNS)

***@3:*** Clone this repo

***@4:*** Use the test `@signs`

The full guide is available [here](https://atsign.dev/gettingstarted.html).

## @Plugins

- [path_provider](https://pub.dev/packages/path_provider)
- [at_demo_data](https://pub.dev/packages/at_demo_data)
- [at_client_mobile](https://pub.dev/packages/at_client_mobile)
- [modal_progress_hud](https://pub.dev/packages/modal_progress_hud)
- [flutter_emoji](https://pub.dev/packages/flutter_emoji)

## @License

Copyright (c) 2020 Souvik Biswas

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
