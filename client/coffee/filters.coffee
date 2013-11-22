app.filter("sec", ->
	(val) ->
		res = parseInt(val, 10) / 1000
		res = 'Ø ' + res + ' sek'
		res = res.replace('.', ',')
		return  res
)