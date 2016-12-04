/atom/movable/lighting_overlay
	name = ""
	mouse_opacity = 0
	simulated = 0
	anchored = 1

	icon = LIGHTING_ICON
	icon_state = "light1"
	layer = LIGHTING_LAYER
	invisibility = INVISIBILITY_LIGHTING
	color = "#000000"

	var/lum_r
	var/lum_g
	var/lum_b

	var/needs_update

/atom/movable/lighting_overlay/New()
	. = ..()
	verbs.Cut()

	var/turf/T = loc //If this runtimes atleast we'll know what's creating overlays in things that aren't turfs.
	T.luminosity = 0

/atom/movable/lighting_overlay/proc/update_lumcount(delta_r, delta_g, delta_b)
	if(!delta_r && !delta_g && !delta_b) //Nothing is being changed all together.
		return

	var/should_update = 0

	if(!needs_update) //If this isn't true, we're already updating anyways.
		if(max(lum_r, lum_g, lum_b) < 1) //Any change that could happen WILL change appearance.
			should_update = 1

		else if(max(lum_r + delta_r, lum_g + delta_g, lum_b + delta_b) < 1) //The change would bring us under 1 max lum, again, guaranteed to change appearance.
			should_update = 1

		else //We need to make sure that the colour ratios won't change in this code block.
			var/mx1 = max(lum_r, lum_g, lum_b)
			var/mx2 = max(lum_r + delta_r, lum_g + delta_g, lum_b + delta_b)

			if(lum_r / mx1 != (lum_r + delta_r) / mx2 || lum_g / mx1 != (lum_g + delta_g) / mx2 || lum_b / mx1 != (lum_b + delta_b) / mx2) //Stuff would change.
				should_update = 1

	lum_r += delta_r
	lum_g += delta_g
	lum_b += delta_b

	if(!needs_update && should_update)
		needs_update = 1
		lighting_update_overlays += src

/atom/movable/lighting_overlay/proc/update_overlay()
	var/turf/T = loc
	if(istype(T)) //Incase we're not on a turf, pool ourselves, something happened.
		if(lum_r == lum_g && lum_r == lum_b) //greyscale
			if(lum_r <= 0)
				if(blend_mode == BLEND_OVERLAY)
					animate(src, T.luminosity = 0, time = LIGHTING_ANIMATE_TIME)
					animate(src, alpha = 255, time = LIGHTING_ANIMATE_TIME, flags = ANIMATION_PARALLEL)
				else
					T.luminosity = 0
					alpha = 255
				color = "#000000"
			else
				T.luminosity = 1
				color = "#000000"
				if(blend_mode == BLEND_OVERLAY)
					animate(src, alpha = (1 - min(lum_r, 1)) * 255, time = LIGHTING_ANIMATE_TIME)
				else
					alpha = (1 - min(lum_r, 1)) * 255
			blend_mode = BLEND_OVERLAY
		else
			alpha = 255
			var/mx = max(lum_r, lum_g, lum_b)
			. = 1 // factor
			if(mx > 1)
				. = 1/mx
			if(blend_mode == BLEND_MULTIPLY)
				animate(src, color = rgb(lum_r * 255 * ., lum_g * 255 * ., lum_b * 255 * .), time = LIGHTING_ANIMATE_TIME)
			else
				color = rgb(lum_r * 255 * ., lum_g * 255 * ., lum_b * 255 * .)
			if(color != "#000000")
				T.luminosity = 1
			else  //No light, set the turf's luminosity to 0 to remove it from view()
				T.luminosity = 0
			blend_mode = BLEND_MULTIPLY
	else
		warning("A lighting overlay realised its loc was NOT a turf (actual loc: [loc][loc ? ", " + loc.type : ""]) in update_overlay() and got pooled!")
		qdel(src)

/atom/movable/lighting_overlay/ResetVars()
	loc = null

	lum_r = 0
	lum_g = 0
	lum_b = 0

	color = "#000000"

	needs_update = 0

/atom/movable/lighting_overlay/Destroy()
	lighting_update_overlays -= src

	var/turf/T = loc
	if(istype(T))
		T.lighting_overlay = null

	..()
