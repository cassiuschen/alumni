# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https:#github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require jquery.event.move
#= require jquery.event.swipe
#= require turbolinks
#= require angular
#= require angular-resource
#= require angular-sanitize
#= require angular-touch
#= require angular-route
#= require angular-loader
#= require angular-cookies
#= require angular-animate
#= require semantic
#= require swiper
#= require_self
#= require_tree ./controllers
# require_tree .

window.base =
	InitDropDown : () ->
		$('.ui.dropdown').dropdown()

	ResizeHomeHeroBG : () ->
		@width = $(window).width() / 3
		@height = $(window).height() / 2
		if @width >= @height
			$('#home-hero').css 'background-size', '100% auto'
		if @width < @height
			$('#home-hero').css 'background-size', 'auto 100%'

	ChangeBGColor : () ->
		colors = ['#e08283', '#89c4f4', '#3fc380']
		time = 0
		setInterval () ->
				$('#home-hero').css 'background-color', colors[time % 3]
				time += 1
			, 4000

	ResizeAll : () ->
		#window.base.ResizeHomeHeroBG()

	Validation : (stepIndex) ->
		console.log 'validation is running'
		switch stepIndex
			when 1
				$('.ui.form#step1').form
					name:
						identifier: 'name'
						rules: [
							{
								type: 'empty',
								prompt: 'Name Shouldnt be empty'
							}
						]
					graduateAt:
						identifier: 'graduateAt'
						rules: [
							{
								type: 'empty'
								prompt: "Should do this"
							}
						]
				return

	Initialize : () ->
		window.base.InitDropDown()
		window.base.ResizeAll()
		window.base.ChangeBGColor()

window.onresize = ->
	window.base.ResizeAll()

window.angular_app = angular.module('AlumniApp', [
	'ngCookies',
	'ngRoute',
	'ngSanitize',
	'ngResource'
])

window.secret = "<%= Rails.application.secrets.secret_key_base %>"

window.angular_app.config(["$httpProvider", (provider) ->
	provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
	provider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest'
])

window.angular_app.run [
	'$rootScope',
	($rs) ->
		$rs.registStatus = [
			{
				step: 1
				completed: false
				onEdit:	true
			},
			{
				step: 2
				completed: false
				onEdit:	false
			},
			{
				step: 3
				completed: false
				onEdit:	false
			},
			{
				step: 4
				completed: false
				onEdit:	false
			}
		]
		$rs.onEditStep = 1
		$rs.showForm = false

]

$ ->
	#swiper = $('.pages').swiper
	#	mode:'vertical'
	#	loop: false
	#	keyboardControl: true
	#	#mousewheelControl: true
	#	moveStartThreshold: 8
	window.base.Initialize()
	$('.ui.sticky').sticky()