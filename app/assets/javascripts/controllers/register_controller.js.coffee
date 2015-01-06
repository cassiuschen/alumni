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
			$rs.registStatus[stepIndex - 1].onEdit = true

		$s.changeStep = (stepIndex) ->
			$s.saveForm($rs.onEditStep)
			$rs.onEditStep = stepIndex
			$rs.registStatus[stepIndex - 1].onEdit = true

		# Data
		# Initialization
		$s.registData = {
			name: $cookie.get 'name' || ''
			graduateAt: $cookie.get 'graduateAt' || ''
			email: $cookie.get 'email' || ''
			password: $cookie.get 'password' || ''
			phone: $cookie.get 'phone' || ''
			sex: $cookie.get 'sex' || ''
			defaultContact: $cookie.get 'defaultContact' || 'email'
			isWorking: $cookie.get 'isWorking' || false
		}

		$s.haveMoreContact = $cookie.get 'haveMoreContact' || false



		$s.isWorking = ->
			$s.registData.isWorking = !($s.registData.isWorking)

		$s.showMoreContact = ->
			if $s.haveMoreContact
				$('#getMoreContact').html '更多联系方式'
			else
				$('#getMoreContact').html '隐藏其他联系方式'
			$s.haveMoreContact = !($s.haveMoreContact)
		# Validation

		$s.saveForm = (stepIndex) ->
			switch stepIndex
				when 1
					$s.registData.graduateAt = $('input#graduateAt').val()
					$s.registData.sex = $('input#sexal').val()
					$cookie.put 'name', $s.registData.name
					$cookie.put 'graduateAt', $s.registData.graduateAt
					$cookie.put 'email', $s.registData.email
					$cookie.put 'password', $s.registData.password
					$cookie.put 'phone', $s.registData.phone
					$cookie.put 'sex', $s.registData.sex
					console.log 'Step 1 has been save!'
				when 2
					$s.registData.isWorking = $('.ui.checkbox#worked').checkbox 'is checked'
			

		$s.postData = ->
			$http
					method: 'POST'
					url: "/api/v1/user.json"
					data: $s.registData
				.success (data) ->
					$rs.isSuccess = true
					$rs.userData = data
				.error (data) ->
					$rs.error = true



]