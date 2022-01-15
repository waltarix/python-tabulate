@_list:
	just -l

tox:
	tox

test:
	tox -e py310
test-extra:
	tox -e py310-extra

lint:
	tox -e lint

@sample:
	docker ps | PYTHONPATH=.tox/py310/lib/python3.10/site-packages python3 tabulate.py -s ' {2,}' -f fancy_outline_rounded -1 -A lclllrc
