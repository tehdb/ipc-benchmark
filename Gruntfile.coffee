module.exports = (grunt) ->
	"use strict"
	grunt.initConfig
		watch :
			dev :
				files : [
					'client/coffee/**.coffee',
					'client/jade/**.jade',
					'client/sass/**.sass'
					]
				tasks : ['build']

		compass : 
			compile :
				options : 
					#config : 'client_src/config.rb'
					sassDir : 'client/sass'
					cssDir : 'public/css'
		coffee : 
			compile :
				options :
					#bare : true
					join : true
				files :
					'public/js/app.js' : [
						'client/coffee/app.coffee',
						'client/coffee/services.coffee',
						'client/coffee/controllers.coffee',
						'client/coffee/filters.coffee',
						'client/coffee/directives.coffee'
						]

		jade : 
			compile :
				files : 'public/partials/dashboard.tpl.html' : 'client/jade/dashboard.jade'

	
	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-compass')
	grunt.loadNpmTasks('grunt-contrib-jade')
	grunt.loadNpmTasks('grunt-contrib-watch')
	grunt.registerTask('build', ['compass:compile', 'coffee:compile', 'jade:compile'])


