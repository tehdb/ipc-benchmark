$ ->
	class PerformanceMeasurement
		putUrlHost : ''
		localStorageKey : 'idPerfMsr'
		reqUrl : ''
		retry : {
			count : 0
			max : 5
			delay : 2000
		}

		constructor : ( url ) ->
			return if not @checkParams()
			@reqUrl = window.location.hostname + window.location.pathname
			@sendData() if @checkBrowserSupport() and @checkLocalStorageEntry()

		checkParams : () ->
			scrTag = $('#idPerfMsr')
			@putUrlHost = scrTag.data('puturl')
			return false if not @putUrlHost?

			@retry.max = parseInt(scrTag.data('retrymax'), 10) || @retry.max
			@retry.delay =  parseInt(scrTag.data('retrydelay'), 10) || @retry.delay
			return true

		# check location, performance and localStorage support
		checkBrowserSupport : () ->
			res = false
			res = true if window.location? and window.performance? and window.localStorage? and typeof MD5 is 'function'

			return res


		getData : () ->
			@retry.count++

			return false if window.performance.timing.loadEventEnd is 0

			data = {
				timing : window.performance.timing
				memory : window.performance.memory
				reqUrl : @reqUrl
				reqTime : new Date().getTime()
				userAgent : navigator.userAgent
				title : document.title
			}
			
			return data

		checkLocalStorageEntry : () ->
			urlhash = MD5( @reqUrl )
			item = window.localStorage.getItem( @localStorageKey )
			item = if item? then JSON.parse( item ) else []

			if item.indexOf( urlhash ) is -1
				item.push( urlhash )
				window.localStorage.setItem( @localStorageKey, JSON.stringify(item) )
				return true
			return false

		sendData : () ->
			slf = @
			data = slf.getData()
			if data isnt false
				$.ajax({
					url : slf.putUrlHost
					contentType : "application/json"
					data : JSON.stringify( data )
					dataType: 'json'
					type : "PUT"
				})

				#.done( (msg)->
				#	console.log("data send")
				#).fail( (jqXHR, textStatus)->
				#	console.log "Request failed: " + textStatus
				#)
			else if slf.retry.count < slf.retry.max
				window.setTimeout( ->
					slf.sendData()
				, slf.retry.delay)

	# PerformanceMeasurement

	new PerformanceMeasurement()