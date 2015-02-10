Ghost
=====

[Ghost](http://ghost.org) is a simple, powerful publishing platform that allows you to share your stories with the world. Ghost is a kickstarter funded project which is growing rapidly. The source from Ghost is available to run on your own server, different hosted alternatives exists as well.

Purpose of RGhost
-----------------

While Ghost is great at writing and publishing content, there is /was no easy way to integrate code, examples and grpahs from R into blogposts. The RGhost package and its shiny implementation aims to help R users create an easy workflow from idea, to analysis to publising content.

Ghost API: UNDER DEVELOPMENT
----------------------------

Ghost is under heavy development and the team is pushing out new features an a rapid pace. This is also true for the Ghost api. As of now there is no official release of the api. The documentation is scarce but can be found on the forums and here. I'll make a best effort to keep the package up to date with the developements as they are rolled out.

The current implementation is based on Ghost version 0.5.7.

RGhost code
===========

The current package is an clear alpha, the following features need to be implemented improved: - [ ] Update secuirity of storing passwords 

- [ ] Error handling 
- [ ] Implement adding, updating tags for new and existing posts 
- [ ] Implement uploading pictures with posts


Installation
------------

Please use the devtools package to install [the latest version](https://github.com/good-marketing/RGhost) from RGhost `devtools::install_github(goodmarketing/RGhost)`.

**NOTE**

RGhost has only been tested with a self-hosted version. Technically it should work with the hosted versions of Ghost.

Usage
-----

Please see the help documentation in the package itself.

### Authentication

-   Authentication is based on username and password. There is no official release yet for Oauth for Ghost).Once the Ghost API officially will be released Oauth will be implemented.See [here](https://github.com/TryGhost/Ghost/wiki/How-does-oAuth-work-with-Ghost%3F) for the initial details.
-   Note: Ghost locks down for one hour if to many false authentication request have been made. If you control your own ghost installation you can restart the instance and authenticate again.

### Get operations

-   Get all posts (published and draft)
-   Get all users / Get current user
-   Get all tags

### (Blog)post operations

-   Create new posts
-   Update existsing post
-   Delete a post

<hr/>

RGhost: Shiny Application
=========================

![](https://www.filepicker.io/api/file/JO0Uska3Qf2ntpxyr6Az)

Introduction
------------

The RGhost shiny application is a web application which provides an easy way to combine markdown & R code and publish to Ghost. RGhost shiny application is based on [editR](https://github.com/swarm-lab/editR) by [Simon Garnier](https://github.com/sjmgarnier).

editR is a basic Rmarkdown editor with instant previewing of your document. It allows you to create and edit Rmarkdown documents while instantly previewing the result of your writing and coding. It also allows you to render your Rmarkdown file in any format permitted by the rmarkdown R package

Installation RGhost shiny application
-------------------------------------

Before you install the applicatin you can give it a try on [shinyapps](https://good-marketing.shinyapps.io/rghost/). In order to run the RGhost shiny application the following packages are required:

### Required packages

-   shiny
-   shinyBS
-   shinyAce
-   shinyFiles
-   shinyStore
-   shinybootstrap2
-   rmarkdown
-   knitr

### Run the RGhost shiny application

To launch the application load the RGhost library `library (RGhost)` and run the following command

    library (RGhost)
    launch_rghost_app()

Usage
-----

RGhost extends editR by the ability to post, update and delete content. The most prominent features of the Ghost blogging platform are implemented. Users can create status pages, edit drafts, mark a post as featured, add and remove tags and provide a cover image for a blog post.

Implementation of the Ghost feature may depend on the chosen theme. For example how the image property used per post depends on the ghost theme used.

Login
-----

Login requires the Ghost admin username (email) and password. Using the shinyStore package it is possible to save the credentials for later use. Also supply the url (inc <http://>) to the shiny application.

![](https://www.filepicker.io/api/file/qYvGhTJPRAiMhX7zp7XX)

1.  Fill out your login information.
2.  Click the **Save** button. This stores the information for future sessions.
3.  Click the **Connect** button.

You are now ready to interact with the Ghost blogging platform.

**Note** The current implementation is not secure and your credentials are send over http and stored as is. Future feature will support hashed passwords for storage and Oauth 2.0 implementation which uses SSL/TSL.

Working with files
------------------

Thanks to editR you can work with files (currently there is now way to create a new file from the application.) You can open and save existing Rmd files. To view your file in HTML format hit the render button. A new window will open showing you a html version of your content.

NOTE: On shinyapps.io the home directory is a relative directory (posts), which is publicly available.

![](https://www.filepicker.io/api/file/vzuD0kecQkqER7AZAyLS)

Post a new post
---------------

Write your content in (R) markdown and use the left hand options to set the properties of the post.

![](https://www.filepicker.io/api/file/qmdrUW4FRcSru3jyMhw6)

Most field are self explanatory, but a number of notes

-   **Url**: you can determine the url of the post. Ghost accepts any type of string and converts it to a valid url.

-   **Image**: for the image property to work you need to full link to an online image. Currently uploading is not supported (yet).

-   **Tags**: you can select multiple tags.

-   **Feature** : depending on the Ghost theme applied the feature property is used to provide a post a prominent position on the homepage.

**NOTE**

The application stores an Rmd file the first time you publish a post in the 'posts' directory. As the RMarkdown is parsed by knitr and then Ghost the original r code you write will be converted. Storing an Rmd file allows for retreival of the R code.

### Markdown Content

You can use regular markdown to style your blogposts, the preview allows you to see the results immediatly.Ghost will convert the markdown to proper HTML for you, once a blogpost is published or updated. You can also incorporate html tags.

### Running R code

The best feature of the application is the ability to mix content with R code. Check out the R Markdown documentation for a run down of the possibilities.

Please note once content is converted from RMarkdown to Markdown, the original r code is converted in markdown and cannot be editted anymore.

-   A workaround is to set the echo property on the r code chunk to true. This option will include the r code in a code box and the r code will be included in your blogpost. I'd recommend using this option when you are editting draft posts, depending on your preference you may or may not want to include the source code.

-   Another method to preserve the r code is to open an Rmd file in the editor and save the file once you are done, and only post it to ghost once you are completly done with the post.

A couple of highlights

### Charting

An important feature of any data driven blogpost are charts. By added chart to an R chunch you can now easily integrate charts into your blogposts. I'd recommend one of two ways to do this

#### Plotting using standard plotting libs.

Create any chart you want in an r chunk, you can use the [r chunk options](http://rmarkdown.rstudio.com/authoring_rcodechunks.html) to control size, code preview etc.. It will be displayed in the preview window, so you can review it in real time. Using one of the awesome features of knitr, any chart /figure will be automatically uploaded to imgur. See [knitr](http://yihui.name/knitr/demo/upload/) for more information and an img tag including url is added to the markdown code. Ghost also allows image uploads, a custom hook to the knitr package could be created to upload images to your Ghost account. This feature is currently on the to do list. Here is an example using [ggthemes](https://github.com/jrnold/ggthemes).

``` {.r}
# Load libraries

library("ggthemes")

(qplot(hp, mpg, data = subset(mtcars, cyl != 5), geom = "point", color = factor(cyl)) + 
    geom_smooth(method = "lm", se = FALSE) + scale_color_fivethirtyeight() + 
    theme_fivethirtyeight())
```

<img src="http://i.imgur.com/LG6rCbT.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" style="display: block; margin: auto;" />

#### Interactive plots: rCharts & rMaps

Since your readers will be viewing your content online you can take advantage of interactive graphing libraries such as the great [rCharts](https://github.com/ramnathv/rCharts) and [rMaps](https://github.com/ramnathv/rMaps) by [Ramnath Vaidyanathan] (<https://github.com/ramnathv>).

mr Vaidyanathan defines [two options](http://bl.ocks.org/ramnathv/raw/8084330/) for integrating rCharts in R Markdown. I found that using an Iframe to display the chart works best with Ghost. Here is an example using highcharts. Please note that the chunck options need to be set as follows, for the chart to render properly:`comment = NA, results = "asis", tidy = F`

``` {.r}
library(rCharts)
h1 <- Highcharts$new()
h1$chart(type = "spline")
h1$series(data = c(1, 3, 2, 4, 5, 4, 6, 2, 3, 5, NA), dashStyle = "longdash")
h1$series(data = c(NA, 4, 1, 3, 4, 2, 9, 1, 2, 3, 4), dashStyle = "shortdot")
h1$legend(symbolWidth = 80)
h1$set(width = 800)
h1$show('iframesrc', cdn = TRUE)
```

<iframe srcdoc=' &lt;!doctype HTML&gt;
&lt;meta charset = &#039;utf-8&#039;&gt;
&lt;html&gt;
  &lt;head&gt;
    
    &lt;script src=&#039;//code.jquery.com/jquery-1.9.1.min.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;//code.highcharts.com/highcharts.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;//code.highcharts.com/highcharts-more.js&quot;&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;//code.highcharts.com/modules/exporting.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    
    &lt;style&gt;
    .rChart {
      display: block;
      margin-left: auto; 
      margin-right: auto;
      width: 800px;
      height: 400px;
    }  
    &lt;/style&gt;
    
  &lt;/head&gt;
  &lt;body &gt;
    
    &lt;div id = &#039;chart55163300266a&#039; class = &#039;rChart highcharts&#039;&gt;&lt;/div&gt;    
    &lt;script type=&#039;text/javascript&#039;&gt;
    (function($){
        $(function () {
            var chart = new Highcharts.Chart({
 &quot;dom&quot;: &quot;chart55163300266a&quot;,
&quot;width&quot;:            800,
&quot;height&quot;:            400,
&quot;credits&quot;: {
 &quot;href&quot;: null,
&quot;text&quot;: null 
},
&quot;exporting&quot;: {
 &quot;enabled&quot;: false 
},
&quot;title&quot;: {
 &quot;text&quot;: null 
},
&quot;yAxis&quot;: {
 &quot;title&quot;: {
 &quot;text&quot;: null 
} 
},
&quot;chart&quot;: {
 &quot;type&quot;: &quot;spline&quot;,
&quot;renderTo&quot;: &quot;chart55163300266a&quot; 
},
&quot;series&quot;: [
 {
 &quot;data&quot;: [
              1,
             3,
             2,
             4,
             5,
             4,
             6,
             2,
             3,
             5,
null 
],
&quot;dashStyle&quot;: &quot;longdash&quot; 
},
{
 &quot;data&quot;: [
 null,
             4,
             1,
             3,
             4,
             2,
             9,
             1,
             2,
             3,
             4 
],
&quot;dashStyle&quot;: &quot;shortdot&quot; 
} 
],
&quot;legend&quot;: {
 &quot;symbolWidth&quot;:             80 
},
&quot;id&quot;: &quot;chart55163300266a&quot; 
});
        });
    })(jQuery);
&lt;/script&gt;
    
    &lt;script&gt;&lt;/script&gt;    
  &lt;/body&gt;
&lt;/html&gt; ' scrolling='no' frameBorder='0' seamless class='rChart  highcharts  ' id='iframe-chart55163300266a'> </iframe>
 <style>iframe.rChart{ width: 100%; height: 400px;}</style>

In a similar fashion you can create interactive maps using the rMaps package

``` {.r}
library(rMaps)
map <- Leaflet$new()
map$setView(c(52.36, 4.90), zoom = 5)
map$tileLayer(provider = 'Stamen.Watercolor')
map$marker(c(52.36, 4.90), bindPopup = 'Hi. Welcome to Amsterdam')
map$set(width = 800)
map$show('iframesrc', cdn = TRUE)
```

<iframe srcdoc=' &lt;!doctype HTML&gt;
&lt;meta charset = &#039;utf-8&#039;&gt;
&lt;html&gt;
  &lt;head&gt;
    &lt;link rel=&#039;stylesheet&#039; href=&#039;http://cdn.leafletjs.com/leaflet-0.5.1/leaflet.css&#039;&gt;
    
    &lt;script src=&#039;http://cdn.leafletjs.com/leaflet-0.5.1/leaflet.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;https://rawgithub.com/leaflet-extras/leaflet-providers/gh-pages/leaflet-providers.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;http://harrywood.co.uk/maps/examples/leaflet/leaflet-plugins/layer/vector/KML.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    
    &lt;style&gt;
    .rChart {
      display: block;
      margin-left: auto; 
      margin-right: auto;
      width: 800px;
      height: 400px;
    }  
    &lt;/style&gt;
    
  &lt;/head&gt;
  &lt;body &gt;
    
    &lt;div id = &#039;chart55164eda134e&#039; class = &#039;rChart leaflet&#039;&gt;&lt;/div&gt;    
    &lt;script&gt;
  var spec = {
 &quot;dom&quot;: &quot;chart55164eda134e&quot;,
&quot;width&quot;:            800,
&quot;height&quot;:            400,
&quot;urlTemplate&quot;: &quot;http://{s}.tile.osm.org/{z}/{x}/{y}.png&quot;,
&quot;layerOpts&quot;: {
 &quot;attribution&quot;: &quot;Map data&lt;a href=\&quot;http://openstreetmap.org\&quot;&gt;OpenStreetMap&lt;/a&gt;\n         contributors, Imagery&lt;a href=\&quot;http://mapbox.com\&quot;&gt;MapBox&lt;/a&gt;&quot; 
},
&quot;center&quot;: [          52.36,            4.9 ],
&quot;zoom&quot;:              5,
&quot;provider&quot;: &quot;Stamen.Watercolor&quot;,
&quot;id&quot;: &quot;chart55164eda134e&quot; 
}

  var map = L.map(spec.dom, spec.mapOpts)
  
    map.setView(spec.center, spec.zoom);

    if (spec.provider){
      L.tileLayer.provider(spec.provider).addTo(map)    
    } else {
          L.tileLayer(spec.urlTemplate, spec.layerOpts).addTo(map)
    }
     
    L
  .marker([
  52.36,
   4.9 
])
  .addTo( map )
  .bindPopup(&quot;Hi. Welcome to Amsterdam&quot;)
    
    
    
    
    if (spec.circle2){
      for (var c in spec.circle2){
        var circle = L.circle(c.center, c.radius, c.opts)
         .addTo(map);
      }
    }
    
    
    
    
    
   
   
   
&lt;/script&gt;
    
    &lt;script&gt;&lt;/script&gt;    
  &lt;/body&gt;
&lt;/html&gt; ' scrolling='no' frameBorder='0' seamless class='rChart  leaflet  ' id='iframe-chart55164eda134e'> </iframe>
 <style>iframe.rChart{ width: 100%; height: 400px;}</style>


### Tables

Currently Ghost does not support markdown tables. There are probably more than one ways around this, my current most convenient solution is xtable.

If you produce a table in a R chunck you can use the following to publish this to Ghost

``` {.r}

a <- head(cars) #Your results

library(xtable) # Load xtable library
tab <- xtable(a) #xtable your results

# Styling table using css
print(tab, type="html",html.table.attributes='class:mytable') # print them to html. Ghost accepts standard html in markdown.
```

<!-- html table generated in R 3.1.2 by xtable 1.7-4 package -->
<!-- Tue Feb 10 13:47:07 2015 -->
<table class:mytable>
<tr> <th>  </th> <th> 
speed
</th> <th> 
dist
</th>  </tr>
  <tr> <td align="right"> 
1
</td> <td align="right"> 
4.00
</td> <td align="right"> 
2.00
</td> </tr>
  <tr> <td align="right"> 
2
</td> <td align="right"> 
4.00
</td> <td align="right"> 
10.00
</td> </tr>
  <tr> <td align="right"> 
3
</td> <td align="right"> 
7.00
</td> <td align="right"> 
4.00
</td> </tr>
  <tr> <td align="right"> 
4
</td> <td align="right"> 
7.00
</td> <td align="right"> 
22.00
</td> </tr>
  <tr> <td align="right"> 
5
</td> <td align="right"> 
8.00
</td> <td align="right"> 
16.00
</td> </tr>
  <tr> <td align="right"> 
6
</td> <td align="right"> 
9.00
</td> <td align="right"> 
10.00
</td> </tr>
   </table>

``` {.r}

# Styling table using html properties
print(tab, type="html", html.table.attributes = list('border="0" bgcolor="#FFCC00" cellpadding="10"'))
```

<!-- html table generated in R 3.1.2 by xtable 1.7-4 package -->
<!-- Tue Feb 10 13:47:07 2015 -->
<table border="0" bgcolor="#FFCC00" cellpadding="10">
<tr> <th>  </th> <th> 
speed
</th> <th> 
dist
</th>  </tr>
  <tr> <td align="right"> 
1
</td> <td align="right"> 
4.00
</td> <td align="right"> 
2.00
</td> </tr>
  <tr> <td align="right"> 
2
</td> <td align="right"> 
4.00
</td> <td align="right"> 
10.00
</td> </tr>
  <tr> <td align="right"> 
3
</td> <td align="right"> 
7.00
</td> <td align="right"> 
4.00
</td> </tr>
  <tr> <td align="right"> 
4
</td> <td align="right"> 
7.00
</td> <td align="right"> 
22.00
</td> </tr>
  <tr> <td align="right"> 
5
</td> <td align="right"> 
8.00
</td> <td align="right"> 
16.00
</td> </tr>
  <tr> <td align="right"> 
6
</td> <td align="right"> 
9.00
</td> <td align="right"> 
10.00
</td> </tr>
   </table>

TIP: if you use html.table.attributes and set the table class attribute you can style you output tables with CSS. Usually Ghost themes have a class for styling table, so if you set it to this class all you tables will be outputted in the same format.

Update a post
-------------

### Get existing posts

In order to update an existing post you need to get them from ghost. Currently all posts (draft and published) will be loaded and a selectbox will be displayed.

You can type in the select field to find the post you are looking for.

![](https://www.filepicker.io/api/file/sjIvkOyCTeq1XUyeJsp3)

### Update

Edit the post content and properties and hit update. Upon success a message will be displayed.

![](https://www.filepicker.io/api/file/ZytCgVhBSgO4TX456ys6)

Delete a post
-------------

Select a post you want to delete and hit the Delete button. (Be careful deletion is permanent).
