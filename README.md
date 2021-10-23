## Inspiration
We're building `eco.club` as we realised, today, it wasn't easy to make MEANINGFUL CONTRIBUTIONS EASILY in helping preserve the environment.
We noticed two main challenges people who're enthusiastic about helping in the fight against climate change face:
1. CONFUSED - Lack of Information & Open Conversations
2. Monetary DONATIONS - How & Where?

## Video Demo Link
https://youtu.be/qQfWm1JK0rM

## What it does
`eco.club` is a one stop destination for you to do your bit in this endeavour to help the environment.

- `eco.lens`
   Want to know how to help reduce your carbon footprint?
   Click a picture of any product that you use or about to buy. `eco.lens` uses Machine Learning to identify the product and help you calculate the carbon footprint of the product in the image.

- `eco.pay`
   Users often fail to develop a habit to contribute regularly to Campaigns and Organisations helping in this fight.
   Whenever you make any online payment anywhere, `eco.pay` automatically nudges the user to donate 1% - 5% of the amount through our platform. Any donations made are automatically routed to getchange.io, which matches every donation, and forwards the funds collected to Campaigns around the world.

- `eco.crew` 
   You use glass bottles instead of plastic ones? Share your efforts with the world with `eco.crew`!
   A social portal for users to share their daily efforts and knowledge to help others learn more, and promote eco friendly practices and articles.

- `eco.bits`
   We value your time! `eco.bits` are bite-sized short articles or videos to help you gain knowledge, inspiration or ideas quickly and efficiently in swipeable card formats. 


## How we built it
- `eco.club` is a complete Mobile Application developed using Dart & Flutter.
- We used FireBase as our data store, and FireBase ML-Kit for Object Detection in `eco.lens`.
- We developed a Node.JS server which acts as our backend. It is responsible for interacting with carbon-footprint API, and returning the carbon footprint in `eco.lens`. It also stores all donation data and routes all payments to getchange.io.
- The backend node server is hosted on Heroku.
- We used *StoryBlok CMS* to dynamically and easily publish data for `eco.bits`.

## Challenges we ran into
- SMS detection wasn't possible in background at all times, but had a timeout of few minutes.
- Carbon Footprint Database / APIs are not easily and freely available.

## What we learned
- Climate change is real, and we hope eco.club makes it easier for users to help prevent climate change.
- We learnt how to integrate our front-end with StoryBlok CMS. StoryBlok has been really helpful and easy to use to publish content dynamically on to multiple platforms!
- Reading incoming SMS automatically by our app, and extracting the payment information was something that we did for the first time.
- We integrated with FireBase ML to easily apply machine learning to our images.

## What's next for Eco.Club
- Integrate with a payments infrastructure
- Adding functionality to monitor SMSs for online payments at all times in the background
- Generating revenue by either charging a bare minimum processing fees for all transactions, or generating revenue from all deposits made to us.
