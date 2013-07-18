module.exports = (grunt)->
	grunt.initConfig
		pkg: "<json:package.json>"
		coffee:
			all:
				files:
					"app.js": "app.coffee"
					"field.js": "field.coffee"
					"td.js": "td.coffee"
				options:
					bare: true
					sourceMap: true

	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.registerTask "c", ["coffee"]