#iOS 9 Day by Day
#12. GameplayKit - Behaviors & Goals

In post 10, we looked at how you could use GameplayKit pathfinding APIs to calculate a path between two locations in your scene, while avoiding designated obstacles. 

In this post, we will take a different approach to moving nodes through our scene. Gameplay kit has introduced the concept of Behaviours and Goals, which provide you with a way to position the nodes in your scene based on constraints and desired achievements. Lets take a look at an example of how this works before looking into it in more detail.

<video width="100%" height="500" controls loop>
	<source src="images/Missile.mov" type="video/mp4">
	Your browser does not support the video tag.
</video>

In the above example (which we will build shortly), you can see a yellow box which represents the user. This box is controlled by the user moving their finger around the scene. Pretty basic stuff! The interesting part is the missile, which seeks the player, and will always try to reach the center point of the player node.

This doesn't use any physics or custom code, and is solely controlled by a simple behavior composed with a single seek goal. 

Now we know a bit about behaviours and goals work, lets take a look at how to create this demo app.

##Creating a Behavior and Goal Example

Lets walk through how to put this example together. First we need to set up a 


	let player:Player = Player()
	var missile:Missile?


##Further Reading
For more information on the the new GameplayKit features discussed in this post, take look at WWDC session 608, [Introducing GameplayKit](https://developer.apple.com/videos/wwdc/2015/?id=608). Don't forget, if you want to try out the project we created and described in this post, you can find it over at [GitHub](https://github.com/shinobicontrols/iOS9-day-by-day/tree/master/12-GameplayKit-Behaviors).

If you've enjoyed the last two GameplayKit blog, then why not try and integrate pathfinding with 

If you have any questions or comments then we would love to hear your feedback. Send me a tweet [@christhegrant](http://twitter.com/christhegrant) or you can follow [@shinobicontrols](http://twitter.com/shinobicontrols) to get the latest news and updates to the iOS9 Day-by-Day series!