app.filter("sec", ->
	(val) ->
		res = parseInt(val, 10) / 1000
		res = 'Ø ' + res + ' sec'
		res = res.replace('.', ',')
		return  res
)

app.filter("sortlbl", ->
	(val) ->
		res = ''
		switch val
			when 'default'
				res = 'unsorted '
			when 'title'
				res = 'sort by title '
			when 'average.browser'
				res = 'sort by load time '

		return res
)