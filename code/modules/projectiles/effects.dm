/obj/effect/projectile
	icon = 'icons/effects/projectiles.dmi'
	icon_state = "bolt"
	layer = 20

	light_power = 1
	light_range = 0
	light_color

/obj/effect/projectile/New(var/turf/location)
	if(istype(location))
		loc = location

/obj/effect/projectile/proc/set_transform(var/matrix/M)
	if(istype(M))
		transform = M

/obj/effect/projectile/proc/activate(var/kill_delay = 5)
	set_light(light_range, light_power, light_color)
	spawn(kill_delay)
		qdel(src)	//see effect_system.dm - sets loc to null and lets GC handle removing these effects

	return

//----------------------------
// Laser beam
//----------------------------
/obj/effect/projectile/laser
	light_range = 2
	light_color = "FF0000"

/obj/effect/projectile/laser/tracer
	icon_state = "beam"

/obj/effect/projectile/laser/muzzle
	icon_state = "muzzle_laser"

/obj/effect/projectile/laser/impact
	icon_state = "impact_laser"

//----------------------------
// Blue laser beam
//----------------------------
/obj/effect/projectile/laser_blue
	light_range = 2
	light_color = "0000FF"

/obj/effect/projectile/laser_blue/tracer
	icon_state = "beam_blue"

/obj/effect/projectile/laser_blue/muzzle
	icon_state = "muzzle_blue"

/obj/effect/projectile/laser_blue/impact
	icon_state = "impact_blue"

//----------------------------
// Omni laser beam
//----------------------------
/obj/effect/projectile/laser_omni
	light_range = 2
	light_color = "5050FF"

/obj/effect/projectile/laser_omni/tracer
	icon_state = "beam_omni"

/obj/effect/projectile/laser_omni/muzzle
	icon_state = "muzzle_omni"

/obj/effect/projectile/laser_omni/impact
	icon_state = "impact_omni"

//----------------------------
// Xray laser beam
//----------------------------
/obj/effect/projectile/xray
	light_range = 2
	light_color = "00FF00"

/obj/effect/projectile/xray/tracer
	icon_state = "xray"

/obj/effect/projectile/xray/muzzle
	icon_state = "muzzle_xray"

/obj/effect/projectile/xray/impact
	icon_state = "impact_xray"

//----------------------------
// Heavy laser beam
//----------------------------
/obj/effect/projectile/laser_heavy
	light_range = 2
	light_color = "FF0000"

/obj/effect/projectile/laser_heavy/tracer
	icon_state = "beam_heavy"

/obj/effect/projectile/laser_heavy/muzzle
	icon_state = "muzzle_beam_heavy"

/obj/effect/projectile/laser_heavy/impact
	icon_state = "impact_beam_heavy"

//----------------------------
// Pulse laser beam
//----------------------------
/obj/effect/projectile/laser_pulse
	light_range = 2
	light_color = "0000FF"

/obj/effect/projectile/laser_pulse/tracer
	icon_state = "u_laser"

/obj/effect/projectile/laser_pulse/muzzle
	icon_state = "muzzle_u_laser"

/obj/effect/projectile/laser_pulse/impact
	icon_state = "impact_u_laser"

//----------------------------
// Pulse muzzle effect only
//----------------------------
/obj/effect/projectile/pulse/muzzle
	icon_state = "muzzle_pulse"

//----------------------------
// Emitter beam
//----------------------------
/obj/effect/projectile/emitter
	light_range = 2
	light_color = "#64FF64"

/obj/effect/projectile/emitter/tracer
	icon_state = "emitter"

/obj/effect/projectile/emitter/muzzle
	icon_state = "muzzle_emitter"

/obj/effect/projectile/emitter/impact
	icon_state = "impact_emitter"

//----------------------------
// Stun beam
//----------------------------
/obj/effect/projectile/stun
	light_range = 2
	light_color = "#FFFFA0"

/obj/effect/projectile/stun/tracer
	icon_state = "stun"

/obj/effect/projectile/stun/muzzle
	icon_state = "muzzle_stun"

/obj/effect/projectile/stun/impact
	icon_state = "impact_stun"

//----------------------------
// Bullet
//----------------------------
/obj/effect/projectile/bullet/muzzle
	light_power = 2
	light_range = 3
	light_color = "#FFFF78"
	icon_state = "muzzle_bullet"
