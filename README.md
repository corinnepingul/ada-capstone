#Stash This Moment
**Ada Developer's Academy Capstone Project, October 2015**

\*Note: this project is not currently available for users...sorry! But, you can check out a short video clip of the final product [_here_] (https://www.youtube.com/watch?v=O3o29zglYFo)

###Introduction:
**Stash This Moment** is designed to be a web application that allows users to upload and store bits of text and/or photos (called "moments") via mms/sms to a private timeline. The inspiration for this project came from a very good college friend of mine, named Louise. She once sent me the best birthday card I have ever received. In her card she listed out distinct memories she had of me when she described me being the most confident - most me - version of myself. I was so touched that she remembered some of the most simple moments that I had completely forgotten. But, she had been collecting these small moments in a word document for many years. For each of her friends. One day, when her computer crashed, she lost all of these files. She was devastated and asked her friends to help her compile these small stories again. This is where I thought I could help out. What if there was a web application for her? One where she could go about her day and when she experienced a moment she wanted to save she could send a quick text or picture message to her app and know it was being kept safe for her. So that's how I decided to build **Stash This Moment**.

My **three main goals** for this project were to make a web application that:

1. Was really simple and easy to use

2. Could connect to phone mms and sms data

3. Would be a _private_ compilation of the users "moments" they wanted to remember, unlike social media (but potentially with the option to "share" moments via social media platforms like Facebook, Instagram, etc.)

[_Link to My Trello Board_](https://trello.com/b/UvwfucOT/capstone-project)

###Product Plan:
1. **Problem Statement:** A clear, concise statement describing the problem your project will solve.
  - My project will allow users to create their own personal web-based timeline of memories and photos that they can search and access. It will allow people to keep track of small moments throughout their lives that they want to hold onto.
  - The user will be able to send the web-app these moments via sms test messages and mms photo messages where they will be able to include hashtags for grouping and searching their moments
  - The moments will be displayed on the web-application in the form of a visual timeline that is also searchable and editable

2. **Market Research**: Outline the key insights from your research, including:
  - your application’s competition - what alternatives are already out there (competing apps and/or non-app solutions)
    - Day One (http://dayoneapp.com/) is the most similar application I have found, other than widely popular applications like Facebook, Instagram, and Twitter
  - research from users on why these alternatives do not effectively address the problem.
  - differentiation: what makes your idea/product different
    - My application will differ from One Day in that:
      - it will be free
      - it will use text message as the primary way of adding new moments to the timeline (instead of as a mobile app). This will allow even "dumb" phone users to use my app
      - it will not include a lot of the features that One Day does (trying to simplify functionality and user experience)
    - My application will differ from Facebook, Twitter, Instagram in that:
      - it will be private
      - it will have the option of sharing with people or keeping the messages private

3. **User Personas**: A summary of your main target user group(s). What are their key characteristics? How do those characteristics factor into project/app/idea?
  - My main target are people who are too busy to scrapbook, but who still want a way to easily keep track of the small things that happen in their lives that they want to remember
  - Because I want to make it really easy to use out and about even if you don't have a smart phone, I will use text messaging as the primary way to add moments to your timeline.
  - I also imagine my users to be people who don't always want to share the content that they want to keep track of...so this is a good alternative to social media sites, but will also allow for sharing if that is important to the user.

4. **Technologies**
  - Ruby on Rails, PostgreSQL, S3?
  - HTMl, CSS, Javascript, Jquery, Ajax, Ember?, D3?
  - Twilio for sms and mms
  - Authy (Twilio) for authentication
  - Other APIs
    - Facebook, Instagram, Twitter, Weather, Location?
  - Rspec, Mocha, FactoryGirl for testing
  - Code Climate, Coverage

5. **Integrations**
  - Front-end Framework (Bootstrap)
  - Third-party OAuth (Twilio)

6. **Advanced Features**
  - Secure Socket Layer (SSL)
  - Internationalization (i18n)
  - S3 storage/delivery
