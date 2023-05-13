module ticker

import time

pub struct Ticker {
mut:
	last_sent time.Time
	interval  time.Duration
	stopped   bool
pub:
	c         chan time.Time
}

pub fn new_ticker(interval time.Duration) &Ticker {
	mut t := &Ticker{
		last_sent: time.now()
		interval: interval
		c: chan time.Time{}
		stopped: false
	}
	spawn t.tick()
	return t
}

fn (mut t Ticker) tick() {
	for !t.stopped {
		now := time.now()
		if now - t.last_sent >= t.interval {
			t.last_sent = now
			t.c <- now
		}
	}
}

pub fn (mut t Ticker) stop() {
	t.stopped = true
}
