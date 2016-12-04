#define POISON_OVERLAY_ICON 'icons/obj/poison_overlays.dmi'

/obj/item/weapon
	var/poisonOverlayState
	var/image/poisonOverlay


/obj/item/weapon/attackby(obj/item/weapon/W as obj, mob/user as mob)
	. = ..()
	if(!poisonOverlayState)
		return

	if(istype(W, /obj/item/weapon/reagent_containers))

		if(!reagents)
			create_reagents(3)

		spawn(1) //Ток не бейте :((99
			update_icon()

/obj/item/weapon/afterattack(obj/target, mob/user, proximity)
	. = ..()
	if(!poisonOverlayState)
		return
	if(!reagents)
		return
	if(reagents.total_volume)
		if(istype(target, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = target
			var/target_zone = ran_zone(check_zone(user.zone_sel.selecting, target))
			var/obj/item/organ/external/affecting = H.get_organ(target_zone)

			if (!affecting || (affecting.status & ORGAN_DESTROYED) || affecting.is_stump())
				return
			if((user != target) && H.check_shields(7, "the [src.name]"))
				return
			if (target != user && H.getarmor(target_zone, "melee") > 5 && prob(50))
				return

			var/contained_reagents = reagents.get_reagents()
			var/trans = reagents.trans_to_mob(target, 3, CHEM_BLOOD)
			admin_inject_log(user, target, src, contained_reagents, trans, violent=1)
		update_icon()
	return


/obj/item/weapon/clean_blood()
	if(poisonOverlayState)
		if(reagents)
			reagents.clear_reagents()
			update_icon()
	. = ..()

/obj/item/weapon/update_icon()
	. = ..()
	if(poisonOverlayState)
		if(poisonOverlay)
			overlays -= poisonOverlay
		if(reagents)
			if(reagents.total_volume)
				poisonOverlay = image(POISON_OVERLAY_ICON, icon_state = poisonOverlayState)
				poisonOverlay.color = reagents.get_color()
				overlays += poisonOverlay

#undef POISON_OVERLAY_ICON