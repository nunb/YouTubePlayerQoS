VideoPlayerQoS
==============

iOS YouTube Video Player Measuring and Collecting QoS data in a scientific approach.

Dedicated to generating a data-demonstrated solution to improve quality of service.

Tasks
-----

-	[ ] YouTube Video Playback
	-	[x] play list
	-	[ ] play selected item
	-	[ ] UIWebView memory, now leak ~5M
-	[ ] YouSlow measurements
	-	[x] localtime
	-	[x] city, region, country, loc
	-	[x] org
	-	[x] numofrebufferings, bufferduration, bufferdurationwithtime
	-	[x] resolutionchanges, requestedresolutions, requestedresolutionswithtime
	-	[ ] timelength, abandonment, allquality
	-	[ ] initialbufferingtime
	-	[ ] version
	-	[ ] report to server when video ended
-	[ ] YouSlow demo
	-	[ ] charts show history data

References
----------

-	YouSlow Project: https://dyswis.cs.columbia.edu/youslow/
-	YouSlow Chrome extension: https://chrome.google.com/webstore/detail/youtube-too-slow-youslow/agpnjngphbdlfoeoglcamjgabcocpobi
-	API used: https://developers.google.com/youtube
