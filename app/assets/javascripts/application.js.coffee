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
				#$('html').css 'background-color', colors[time % 3]
				$('#home-hero').css 'background-color', colors[time % 3]
				time += 1
				time = 1 if time > 24
			, 4000

	ResizeAll : () ->
		#window.base.ResizeHomeHeroBG()

	AngularDropDown : (selector, event = 'click') ->
		$(selector).dropdown
			on: event
			onChange: (text, value) ->
				$("#{selector} .text").html value
				$("#{selector} input.angularData").val text
				scope = angular.element($("#{selector} input.angularData")).scope()
				#scope.rdefaltContact = text
				scope.$apply () ->
					scope.registData.defaltContact = text
				console.log "ChangeData for Angular!Value: #{value}, text: #{text}"


	Initialize : () ->
		window.base.InitDropDown()
		window.base.ResizeAll()
		window.base.ChangeBGColor()

window.onresize = ->
	window.base.ResizeAll()


#################
#
# Form Validations
#
#################

window.form =
	ValidateFormOne : () ->
		$('.ui.form#step1').form
			name:
				inline: true
				on: 'blur'
				identifier: 'name'
				rules: [
					{
						type: 'empty',
						prompt: '请填写姓名哟~'
					}
				]
			graduateAt:
				inline: true
				on: 'blur'
				identifier: 'graduateAt'
				rules: [
					{
						type: 'empty'
						prompt: "请填写毕业年份哟~"
					}
				]
			email:
				inline: true
				on: 'blur'
				identifier: 'email'
				rules: [
					type: 'email'
					prompt: '亲你好像填的不是电子邮件格式吧~'
				]
			password:
				inline: true
				on: 'blur'
				identifier: "password"
				rules: [
					{
						type: 'length[6]'
						prompt: "密码要多于六位哟~"
					},{
						type: 'maxLength[32]'
						prompt: "密码太长啦！"
					}
				]
			sexal:
				inline: true
				on: 'blur'
				identifier: 'sexal'
				rules: [
					{
						type: 'empty'
						prompt: '请填写一下性别哟~'
					}
				]
			phone:
				inline: true
				on: 'blur'
				identifier: 'phone'
				rules: [
					{
						type: 'empty'
						prompt: '请填写一下联系电话哟~'
					}
				]
			,{
				inline: true
				on: 'blur'
				onSuccess: () ->
					$('#nextStep1').css 'display', 'inline-block'
					$('#toStep1').addClass 'completed'
					return
			}
	Validate : (formID) ->
		$(".ui.form##{formID}").form 'validate form'

	ValidateFormTwo : ->
		$('.ui.form#step2').form
			school:
				identifier: 'school'
				rules: [
					{
						type: 'empty'
						prompt: 'cant be empty'
					}
				]
			major:
				identifier: 'major'
				rules: [
					{
						type: 'empty'
						prompt: 'cant be empty'
					}
				]
			,{
				inline: true
				on: 'blur'
				onSuccess: ->
					$('#nextStep2').css 'display', 'inline-block'
					$('#toStep2').addClass 'completed'
			}
	ValidateFormThree : ->
		$('.ui.form#step3').form
			region:
				identifier: 'region'
				rules: [
					{
						type: 'empty'
						prompt: 'cant be empty'
					}
				]
			,{
				inline: true
				on: 'blur'
				onSuccess: ->
					$('#nextStep3').css 'display', 'inline-block'
					$('#toStep3').addClass 'completed'
			}


#################
#
# Angular App
#
#################

window.angular_app = angular.module('AlumniApp', [
	'ngCookies',
	'ngRoute',
	'ngSanitize',
	'ngResource'
])

window.secret = "<%= Rails.application.secrets.secret_key_base %>"

window.angular_app
	.directive 'ngUpdateHidden', () ->
		(scope, el, attr) ->
			model = attr['ngModel']
			scope.$watch model, (newValue) ->
				el.val newValue

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
				saved: false
				completed: false
				onEdit:	true
			},
			{
				step: 2
				saved: false
				completed: false
				onEdit:	false
			},
			{
				step: 3
				saved: false
				completed: false
				onEdit:	false
			},
			{
				step: 4
				saved: false
				completed: false
				onEdit:	false
			}
		]
		$rs.onEditStep = 1
		$rs.showForm = false
		$rs.postSuccess = false

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