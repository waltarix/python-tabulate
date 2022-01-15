python := 'PYTHONPATH=.tox/py312/lib/python3.12/site-packages python3.12'
tabulate := python + ' tabulate/__init__.py'

@_list:
	just -l

tox:
	tox

test:
	tox -e py312
test-extra:
	tox -e py312-extra

lint:
	tox -e lint

@sample:
	echo '==> without gutter (default)'
	just _sample_csv | {{ tabulate }} -s, -f rounded_outline -1 -accc
	echo '==> -g0'
	just _sample_csv | {{ tabulate }} -s, -f rounded_outline -1 -g0 -accc
@sample-num:
	just _sample_csv_num | {{ tabulate }} -s, -f simple_outline -1 -aln

sample-ansi:
	#!/usr/bin/env zsh
	git branch -a --color=always \
	  --format='%(color:green)%(HEAD)%(color:reset)%09%(color:yellow)%(refname:strip=2)%(color:reset)%09%(subject)' \
	  | { echo -e 'current\tname\tsubject'; cat - } \
	  | {{ tabulate }} -s'\t' -1 -g0 -f fancy_grid -acll

_sample_csv:
	#!/bin/bash
	cat <<EOS
	one,two,three
	…,……,………
	...,......,.........
	EOS

_sample_csv_num:
	#!/bin/bash
	cat <<EOS
	strings,numbers
	spam,41.9999
	eggs,451
	EOS
