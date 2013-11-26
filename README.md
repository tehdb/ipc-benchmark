<h2>Prerequisites</h2>

Node.js http://nodejs.org/

MongoDB http://www.mongodb.org/downloads

Sass/Compass http://compass-style.org/

<h2>global npm packages</h2>

    sudo npm install -g nodemon
    sudo npm install -g coffee-script


<h2>local npm packages</h2>

    npm install


<h2>start server</h2>

    # start mongodb
    mongod

    # start node
    npm start

<h2>usage</h2>
```html
<!-- 
data-puturl : (string) url of the web service to store measurement data
data-retrymax : (integer) amount of attempts to read performance.timing data
data-retrydelay : (number) delay between attempt to read data
--!>    
<script src="//md5.min.js"></script>
<script src="//performance.js" id="idPerfMsr" data-puturl="//:3000/timing"></script>
```



