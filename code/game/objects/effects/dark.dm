/obj/effect/dark
	name = "effect"
	icon = 'icons/effects/effects.dmi'
	icon_state = "white_circle"
	blend_mode = BLEND_SUBTRACT
	layer = LIGHTING_LAYER+0.5
	//alpha = 200

/obj/effect/dark/proc/start(var/scaleRange = 10, var/time = 0, var/phase_in = 1.5, var/phase_out = 15)
	spawn()
		var/matrix/M = matrix()
		alpha = 0
		animate(src, transform = M.Scale(scaleRange), alpha = 255, time = phase_in)

		sleep(phase_in+time)
		animate(src, alpha = 0, time = phase_out)
		sleep(phase_out)

		qdel(src)