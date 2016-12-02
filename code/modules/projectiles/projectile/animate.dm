/obj/item/projectile/animate
	name = "bolt of animation"
	icon_state = "ice_1"
	damage = 0
	damage_type = BURN
	nodamage = 1
	check_armour = "energy"

	light_range = 3
	light_color = "5050FF"


/obj/item/projectile/animate/Bump(var/atom/change)
	if((istype(change, /obj/item) || istype(change, /obj/structure)) && !is_type_in_list(change, protected_objects))
		var/obj/O = change
		new /mob/living/simple_animal/hostile/mimic/copy(O.loc, O, firer)
	..()
