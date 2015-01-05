window.angular_app.controller 'RegisterController', [
	'$rootScope',
	'$http',
	'$scope',
	'$timeout',
	($rs, $http, $s, $tOut) ->
		$s.changeStatus = (stepIndex) ->
			console.log "Changing onEditStep info to #{stepIndex}!"
			$rs.onEditStep = stepIndex
			$rs.registStatus[stepIndex - 1].onEdit = true

		# Data
		# Initialization
		$s.registData =
			password: ""
			isWorking: false

		$s.isWorking = ->
			$s.registData.isWorking = !($s.registData.isWorking)

		# Validation
		$s.validation = (stepIndex) ->
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

		$s.saveForm = (stepIndex) ->
			switch stepIndex
				when 1
					console.log 'Step 1 has been save!'

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