/obj/item/weapon/grenade/illusion
	name = "illusion grenade"
	desc = "A hand held grenade, with an adjustable timer."
	icon_state = "illusion"
	var/explosionRange = 4

/obj/item/weapon/grenade/illusion/prime()
	. = ..()
	var/turf/T = get_turf(src)

	if(T)
		playsound(loc, 'sound/effects/EMPulse.ogg', 25, 1)
		var/obj/effect/dark/Effect = new(get_turf(src))
		Effect.start()

		for(var/atom/movable/A in range(4,T))
			if(istype(A, /obj/item) || istype(A, /mob/living))
				A.stealth(150,5,15)
	qdel(src)


/atom/movable/proc/stealth(var/time = 10, var/phase_in = 5, var/phase_out = 5, var/newInvisibility = INVISIBILITY_LEVEL_ONE)
	if(invisibility >= newInvisibility)
		return
	spawn()
		var/alphaSaved = alpha
		var/invisibilitySaved = invisibility

		animate(src, alpha = 0, time = phase_in)

		sleep(phase_in)
		invisibility = newInvisibility
		sleep(time)

		animate(src, alpha = alphaSaved, time = phase_out)
		invisibility = invisibilitySaved

