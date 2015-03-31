find google documentation on getting a route from two points, directions API
api call for direction is separate and based on google documentation

Today:
1. figure out how to access the crimes on line 55 properly
2. display a walking route on my site from a post from the landing page
3. display a crime and the walking route on the site at once
4. fix git tracking issue - download zip and copy and paste the right files - include images too
5. fix personal machine pg issue

Next:
look at google response for route gps and such
determine a way to see which crimes should actually be collected in a helper method
 + this crime will be captured in the catograph route with Crimes.relevant_crimes.to_json
 + the var all_crimes will become var all_relevant_crimes
 + look again about bounds on the search bar

Stretch:
color coding of actual walking route
get entire database back to 2003
create a normalized scale of danger from 0 to 100


application flow - mvp
landing page with sisfly. two boxes to submit two different params you can walk from

after submitting the streets you will be taken to a page with the walking route and the crimes that are within a predetermined gps range will be displayed along the route
- we will use the long and lat coordinates for placing the google map markers when someone makes an inquiry
- we will use the google maps direction api for display the walking route on my page
- we could create a search box on the left of the map for additional inquiries using ajax otherwise a link back to index '/'

stretch goals
- mobile plugin to google maps with a button for uber recommendation if its too unsafe

templating like handlebars or moustache for info box
