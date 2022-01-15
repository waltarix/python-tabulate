python := 'PYTHONPATH=.tox/py310/lib/python3.10/site-packages python3'
tabulate := python + ' tabulate.py'

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
	echo '==> without gutter (default)'
	just _sample_csv | {{ tabulate }} -s, -f fancy_outline_rounded -1 -accc
	echo '==> -g0'
	just _sample_csv | {{ tabulate }} -s, -f fancy_outline_rounded -1 -g0 -accc

_sample_csv:
	#!/bin/bash
	cat <<EOS
	one,two,three
	…,……,………
	...,......,.........
	EOS
