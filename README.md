### Steps to Run the App

1. From XCode, select a simulator device or connect a device with capatability for iOS 17.
2. Run the app (Cmd+R).
3. Refresh the list by clicking the refresh icon in the top right.
4. Change the url endpoint the app is connecting to by toggling the menu in the top left.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

My largest focus was on the Network layer, both building and testing it. I saw this as the part with most potential to get wrong and cause problems. I wanted to set it up so that it is scalable, so that adding more http methods and endpoints isn't too difficult. I wanted errors to be handled easily, so that when they happen, I'm getting good information about what happened. I needed to make sure that I'm running the callout asynchronously, but handling UI changes on the main actor.
I also put some focus to the structure of my views, and how I wanted to split them up. I don't want my views to have too much code.
I spent some time but not more than needed to make a nice-looking UI by adjusting font weights, sizes, shadows, backgrounds etc. 

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

~6 hours total. It took 4 hours to build out the app and 2 hours to write the test code.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I decided not to put too much info from the Recipe object into the UI (e.g. youtube url, large photo). I felt that belonged in its own 'RecipeView'. I didn't want to spend too much time focusing on a nice-looking UI, so I only did was was necessary and still looks good. 

### Weakest Part of the Project: What do you think is the weakest part of your project?

Probably unit testing, and writing code with unit testing in mind. It's something I still have a lot to learn about.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

Yes, I used Nuke for lazy loading of images and caching on disc.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

Unit Testing is still something I'm learning about. I learned how to mock as I was doing this project. I had to rewrite some code so that my URL callouts were testable with dependency injection. 
