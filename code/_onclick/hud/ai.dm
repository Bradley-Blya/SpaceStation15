/datum/hud/proc/ai_hud()

	src.adding = list()
	src.other = list()

	var/obj/screen/aibutton/using

//AI core
	using = new /obj/screen/aibutton()
	using.name = "AI Core"
	using.icon_state = "ai_core"
	using.screen_loc = "SOUTH:6,WEST"
	src.adding += using

//Camera list
	using = new /obj/screen/aibutton()
	using.name = "Show Camera List"
	using.icon_state = "camera"
	using.screen_loc = "SOUTH:6,WEST+1"
	src.adding += using

//Track
	using = new /obj/screen/aibutton()
	using.name = "Track With Camera"
	using.icon_state = "track"
	using.screen_loc = "SOUTH:6,WEST+2"
	src.adding += using

//Camera light

	using = new /obj/screen/aibutton()
	using.name = "Toggle Camera Light"
	using.icon_state = "camera_light"
	using.screen_loc = "SOUTH:6,WEST+3"
	src.adding += using

//Crew Monitorting

	using = new /obj/screen/aibutton()
	using.name = "Crew Monitorting"
	using.icon_state = "crew_monitor"
	using.screen_loc = "SOUTH:6,WEST+4"
	src.adding += using

//Crew Manifest

	using = new /obj/screen/aibutton()
	using.name = "Show Crew Manifest"
	using.icon_state = "manifest"
	using.screen_loc = "SOUTH:6,WEST+5"
	src.adding += using

//Alerts

	using = new /obj/screen/aibutton()
	using.name = "Show Alerts"
	using.icon_state = "alerts"
	using.screen_loc = "SOUTH:6,WEST+6"
	src.adding += using

//Announcement

	using = new /obj/screen/aibutton()
	using.name = "Announcement"
	using.icon_state = "announcement"
	using.screen_loc = "SOUTH:6,WEST+7"
	src.adding += using

//Shuttle

	using = new /obj/screen/aibutton()
	using.name = "Call Emergency Shuttle"
	using.icon_state = "call_shuttle"
	using.screen_loc = "SOUTH:6,WEST+8"
	src.adding += using

//Laws

	using = new /obj/screen/aibutton()
	using.name = "State Laws"
	using.icon_state = "state_laws"
	using.screen_loc = "SOUTH:6,WEST+9"
	src.adding += using

//PDA message

	using = new /obj/screen/aibutton()
	using.name = "PDA - Send Message"
	using.icon_state = "pda_send"
	using.screen_loc = "SOUTH:6,WEST+10"
	src.adding += using

//PDA log

	using = new /obj/screen/aibutton()
	using.name = "PDA - Show Message Log"
	using.icon_state = "pda_receive"
	using.screen_loc = "SOUTH:6,WEST+11"
	src.adding += using

//Take image

	using = new /obj/screen/aibutton()
	using.name = "Take Image"
	using.icon_state = "take_picture"
	using.screen_loc = "SOUTH:6,WEST+12"
	src.adding += using

//View images

	using = new /obj/screen/aibutton()
	using.name = "View Images"
	using.icon_state = "view_images"
	using.screen_loc = "SOUTH:6,WEST+13"
	src.adding += using

//Medical/Security sensors

	using = new /obj/screen/aibutton()
	using.name = "Sensor Augmentation"
	using.icon_state = "ai_sensor"
	using.screen_loc = "SOUTH:6,WEST+14"
	src.adding += using


	mymob.client.screen += adding + other
	return


/obj/screen/aibutton
	icon = 'icons/mob/screen_ai.dmi'
	layer = 20
	var/next_click

	MouseEntered()
		animate(src, color = list(4,0,0, 0,1,0, 0,0,1), time = 1)
	MouseExited()
		animate(src, color = rgb(255,255,255), time = 5)
	Click()
		if(next_click > world.time)
			return
		next_click = world.time + 1
		if(!usr) return 1

		switch(name)
			if("AI Core")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					AI.core()

			if("Show Camera List")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					var/camera = input(AI, "Choose which camera you want to view", "Cameras") as null|anything in AI.get_camera_list()
					AI.ai_camera_list(camera)

			if("Track With Camera")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					var/target_name = input(AI, "Choose who you want to track", "Tracking") as null|anything in AI.trackable_mobs()
					AI.ai_camera_track(target_name)

			if("Toggle Camera Light")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					AI.toggle_camera_light()

			if("Crew Monitorting")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					AI.subsystem_crew_monitor()

			if("Show Crew Manifest")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					AI.ai_roster()

			if("Show Alerts")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					AI.subsystem_alarm_monitor()

			if("Announcement")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					AI.ai_announcement()

			if("Call Emergency Shuttle")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					AI.ai_call_shuttle()

			if("State Laws")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					AI.ai_checklaws()

			if("PDA - Send Message")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					if(AI.aiPDA)
						AI.aiPDA.cmd_send_pdamesg()

			if("PDA - Show Message Log")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					if(AI.aiPDA)
						AI.aiPDA.cmd_show_message_log()

			if("Take Image")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					if(AI.aiCamera)
						AI.aiCamera.toggle_camera_mode()

			if("View Images")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					if(AI.aiCamera)
						AI.aiCamera.viewpictures()

			if("Sensor Augmentation")
				if(isAI(usr))
					var/mob/living/silicon/ai/AI = usr
					AI.sensor_mode()
			else
				return 0