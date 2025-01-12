COBCWARN = -W

all: build/day1
.PHONY: all

build/%: src/%.cbl
	cobc $(COBWARN) -x $^ -o $@

