$(function () {
	var app = new Vue({
		el: '#redmini',
		data: initData,
		edit_id: null,
		methods: {
			toggleEdit: function (task) {
				Vue.set(task, 'editMode', !task.editMode)
			}
			, isOverdue: function (task) {
				if (!task.due_date)
					return false
				return (new Date(task.due_date)) < (new Date())
			}
		}
	})	
})