#define MAX_TICK_USAGE 80
#define MAX_SLEEP_TIME 20 //2 second

proc/lagcheck()
	if(world.tick_usage > MAX_TICK_USAGE)
		var/tickToSleep = 1
		do
			sleep(world.tick_lag*tickToSleep)
			tickToSleep *= 2
		while((world.tick_usage > MAX_TICK_USAGE) && (tickToSleep*world.tick_lag) < MAX_SLEEP_TIME)

#undef MAX_TICK_USAGE
#undef MAX_SLEEP_TIME