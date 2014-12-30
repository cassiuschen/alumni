window.angular_app.controller 'RegisterController', [
	'$rootScope',
	'$http',
	'$scope',
	'$timeout',
	($rs, $http, $s, $tOut) ->
		$s.changeStatus = (stepIndex) ->
			$s.checkProgress($rs.onEditStep)
			console.log "Changing onEditStep info to #{stepIndex}!"
			$rs.onEditStep = stepIndex
			$rs.registStatus[stepIndex - 1].onEdit = true

		# Data
		# Initialization
		$s.registData =
			password: ""


		$s.checkProgress = (stepIndex) ->
			console.log 'Now Check Progrss but all pass!'
			$s.stepHasCompleted(stepIndex)

		$s.stepHasCompleted = (stepIndex) ->
			console.log 'Setting StepInfo completed!'
			$rs.registStatus[stepIndex - 1].completed = true

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

		window.changeStep = (stepIndex) ->
			$s.changeStatus(stepIndex)
			$rs.onEditStep = stepIndex
			$render()



]