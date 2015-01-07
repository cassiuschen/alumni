window.angular_app.controller 'RegisterController', [
	'$rootScope',
	'$http',
	'$scope',
	'$timeout',
	'$cookieStore',
	($rs, $http, $s, $tOut, $cookie) ->
		$s.changeStatus = (stepIndex) ->
			console.log "Changing onEditStep info to #{stepIndex}!"
			$rs.onEditStep = stepIndex

		$s.changeStep = (stepIndex) ->
			$s.saveForm($rs.onEditStep)
			$rs.onEditStep = stepIndex

		# Data
		# Initialization
		$s.registData = {
			name: $cookie.get('name') || ''
			graduateAt: $cookie.get('graduateAt') || ''
			email: $cookie.get('email') || ''
			password: $cookie.get('password') || ''
			phone: $cookie.get('phone') || ''
			sex: $cookie.get('sex') || ''
			defaultContact: 'email'
			isWorking: $cookie.get('isWorking') || false

			department_member: $cookie.get('department_member') || false
			school: $cookie.get('school') || ''
			major: $cookie.get('major') || ''
		}

		$s.haveMoreContact = false
		$s.zone = ''

		# TEST
		#$rs.postSuccess = true
		#$rs.userData =
		#	name: "陈小紫"
		#	BdfzerId: "201400100002"
		#	email: "chzdsh3d821@gmail.com"
		#	region: "北京分部"
		#	department: "诚意书院 - 三单元"
		#	graduateAt: 2014

		$s.isWorking = ->
			$s.registData.isWorking = !($s.registData.isWorking)

		$s.showMoreContact = ->
			if $s.haveMoreContact
				$('#getMoreContact').html '更多联系方式'
				$('#contactsMenu .item.extra').remove()
			else
				$('#getMoreContact')
					.html '隐藏其他联系方式'
				$('#contactsMenu').append '
					<a class="item extra" data-text="微信" data-value="wechat"><i class="wechat icon"></i>微信</a>
					<a class="item extra" data-text="QQ" data-value="qq"><i class="qq icon"></i>QQ</a>
					<a class="item extra" data-text="Skype" data-value="skype"><i class="skype icon"></i>Skype</a>
				'
			$s.haveMoreContact = !($s.haveMoreContact)
				
		# Validation

		$s.saveForm = (stepIndex) ->
			switch stepIndex
				when 1

					$cookie.put 'name', $s.registData.name
					$cookie.put 'graduateAt', $s.registData.graduateAt
					$cookie.put 'email', $s.registData.email
					$cookie.put 'password', $s.registData.password
					$cookie.put 'phone', $s.registData.phone
					$cookie.put 'sex', $s.registData.sex
					$cookie.put 'wechat', $s.registData.wechat
					$cookie.put 'qq', $s.registData.qq
					$cookie.put 'defaultContact', $s.registData.defaultContact
					$cookie.put 'skype', $s.registData.skype
					console.log 'Step 1 has been save!'
				when 2
					$s.registData.isWorking = $('.ui.checkbox#worked').checkbox 'is checked'
					$cookie.put 'school', $s.registData.school
					$cookie.put 'major', $s.registData.major
					console.log 'Step 2 has been save!'
				when 3
					$cookie.put 'region', $s.registData.region
					$cookie.put 'zone', $s.zone
			

		$s.postData = ->
			$http
					method: 'POST'
					url: "/api/v1/user.json"
					data: $s.registData
				.success (data) ->
					$rs.onEditStep = 4
					$rs.postSuccess = true
					$rs.userData = data.data
				.error (data) ->
					$rs.error = true



]