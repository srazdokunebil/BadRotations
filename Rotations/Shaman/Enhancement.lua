if select(3, UnitClass("player")) == 7 then
	function ShamanEnhancement()
	    if Currentconfig ~= "Enhancement CuteOne" then
	        EnhancementConfig();
	        Currentconfig = "Enhancement CuteOne";
	    end
	    KeyToggles()
	    if not canRun() then
	    	return true
	    end
-------------------------------------
--- Shields Up! / Weapons Online! ---
-------------------------------------
	--Lightning Shield		
		if getBuffRemain("player",_LightningShield)<10 and getPower("player")>=75 then
			if castSpell("player",_LightningShield,true) then return; end
		end
	--Water Shield
		if getBuffRemain("player",_WaterShield)<10 and getPower("player")<25 then
			if castSpell("player",_WaterShield,true) then return; end
		end
	--Windfury/Flametongue Mainhand
		if UnitLevel("player") >= 30 and getMainRemain()<5 then
			if castSpell("player",_WindfuryWeapon,true) then return; end
		end
		if UnitLevel("player") < 30 and getMainRemain()<5 then
			if castSpell("player",_FlametongueWeapon,true) then return; end
		end
	--Flametongue Offhand
		if getOffRemain()<5 then
			if castSpell("player",_FlametongueWeapon,true) then return; end
		end

------------------
--- Dummy Test ---
------------------
	-- Dummy Test
		if BadBoy_data["Check DPS Testing"] == 1 then
			if UnitExists("target") then
				if getCombatTime() >= (tonumber(BadBoy_data["Box DPS Testing"])*60) and isDummy() then  
					if castSpell("player",_TotemRecall,true) and hasTotem() then return; end
					StopAttack()
					ClearTarget()
					print(tonumber(BadBoy_data["Box DPS Testing"]) .." Minute Dummy Test Concluded - Profile Stopped")
				end
			end
		end

-----------------------
--- Doge/Jebus Mode ---
-----------------------
	--Ghost Wolf
		if not IsMounted()
			and not UnitBuffID("player",_GhostWolf)
			and isMoving("player")
			and not isCasting("player")
		then
			if castSpell("player",_GhostWolf,true) then return; end
		end
	--Water Walking
		if IsSwimming() then
			if castSpell("player",_WaterWalking,true) then return; end
		end
	--Ancestral Spirit
		if not isAlive("mouseover") 
			and not isEnnemy("mouseover") 
			and not isCasting("player")
			and not isInCombat("player") 
		then
			if castSpell("mouseover",_AncestralSpirit,true) then return; end
		end
	--Healing Surge
		if not isInCombat("player")
			and getHP("player") < 75
			and not isCasting("player")
			and not isMoving("player")
			and not isLooting("player")
		then
			if castSpell("player",_HealingSurge,true) then return; end
		end

--------------
--- Totems ---
--------------
	-- Recall
		if not isInCombat("player") 
			and not hasHST() 
			and hasTotem()
		then
			if castSpell("player",_TotemRecall,true) then return; end
		end
	-- Earth
		if isMoving("target") and getDistance("target") <= 10 then
			if castSpell("player",_EarthbindTotem,true) then return; end
		end
		if not isCasting("player") 
			and isCasting("target") 
			and getSpellCD(_WindSheer) > 0 
			and getSpellCD(_Windsheer) < 12
		then
			if castSpell("player",_GroundingTotem,true) then return; end
		end
		if hasNoControl(_TremorTotem) then
			if castSpell("player",_TremorTotem,true) then return; end
		end
		if useCDs() and getSpellCD(_FireElementalTotem) > 0 and getDistance("target") <= 10 and isInCombat("player") then
			if castSpell("player",_EarthElementalTotem,true) then return; end
		end
	-- Fire
		if useCDs() and getDistance("target") <= 10 and isInCombat("player") then
			if castSpell("player",_FireElementalTotem,true) then return; end
		end
		if (not hasFire() or (hasFire() and getTotemDistance("target") > 20)) and getDistance("target")<=20 and getNumEnnemies("player",8)<6 and isInCombat("player") then
			if castSpell("player",_SearingTotem,true) then return; end
		end
		if (not hasFire() or (hasFire() and getTotemDistance("target") > 8)) and getDistance("target")<=8 and getNumEnnemies("player",8)>=6 and isInCombat("player") then
			if castSpell("player",_MagmaTotem,true) then return; end
		end
	-- Wind
		if hasNoControl(_WindwalkTotem) then
			if castSpell("player",_WindwalkTotem,true) then return; end
		end
		if getNumEnnemies("player",8)>3 then
			if castSpell("player",_CapacitorTotem,true) then return; end
		end
		if useCDs() and getDistance("target")<8 and isInCombat("player") then
			if castSpell("player",_StormlashTotem,true) then return; end
		end
	-- Water
		if getHP("player") < 25 then
			if castSpell("player",_HealingStreamTotem,true) then return; end
		end
	-- Heart?!?!!
		--No Captain Totem =(

---------------------------
--- Defensive Abilities ---
---------------------------
		if not isCasting("player") and isInCombat("player") then	
	-- Gift of the Naaru		
			if getHP("player") <= 25 then
				if castSpell("player",59547,true) then return; end
			end
	-- Shamanistic Rage
			if getHP("player") <= 70 then
				if castSpell("player",_ShamanisticRage,true) then return; end
			end
	-- Astral Shift
			if not isCasting("player") and getHP("player")<=30 then
				if castSpell("player",_AstralShift,true) then return; end
			end
	-- Healing Surge
			if getHP("player")<50 and getMWC() >= 3 and not isCasting("player") then
				if castSpell("player",_HealingSurge,true) then return; end
			end
	-- Frost Shock
			if isMoving("target") and getDistance("target")>=10 and getHP("target")<25 then
				if castSpell("target",_FrostShock,false) then return; end
			end
	-- Purge
			
	-- Cleanse Spirit
			if canDispel("player",_CleanseSpirit) then
				if castSpells("player",_CleanseSpirit,true) then return; end
			end
			if canDispel("mouseover",_CleanseSpirit) then
				if castSpells("mouseover",_CleanseSpirit,true) then return; end
			end
		end

------------------
--- Interrupts ---
------------------
	-- Wind Shear
		if canInterrupt(_WindShear) then
			if castSpell("target",_WindShear,false) then return; end
		end

-----------------
--- Cooldowns ---
-----------------
		if useCDs() and getDistance("target") < 8 and isInCombat("player") then
	-- Feral Spirit		
			if castSpell("player",_FeralSpirit,true) then return; end	
	-- Elemental Mastery
			if castSpell("player",_ElementalMastery,true) then return; end
	-- Ancestral Swiftness
			if castSpell("player",_AncestralSwiftness,true) then return; end
	-- Ascendance
			if castSpell("player",_Ascendance,true) then return; end
		end

-------------
--- Pause ---
-------------
		if pause() then
			return true
		end

-----------------------------
--- Multi-Target Rotation ---
-----------------------------
		if getNumEnnemies("player",8) >= 3 and getDistance("target")<8 and useAoE() and isEnnemy("target") and isAlive("target") then
	-- Lava Lash
			if getDebuffRemain("target",_FlameShock)>0 then
				if castSpell("target",_LavaLash,false) then return; end
			end
	-- Fire Nova
			if getDebuffRemain("target",_FireNova)>0 then
				if castSpell("target",_FireNova,true) then return; end
			end
	-- Chain Lightning - 5 Maelstrom Weapon Stacks
			if getHP("player")>=50 and shouldBolt() then
				if castSpell("target",_ChainLightning,false) then return; end
			end
	-- Unleash Elements
			if castSpell("target",_UnleashElements,true) then return; end
	-- Flame Shock
			if getNumEnnemies("player",8) >= 3 then
				for i = 1, GetTotalObjects(TYPE_UNIT) do
					local Guid = IGetObjectListEntry(i)
					ISetAsUnitID(Guid,"thisUnit");
					if getFacing("player","thisUnit") == true
						and getDebuffRemain("thisUnit",_FlameShock) < 3
						and getTimeToDie("thisUnit") >= 15
					then
						if castSpell("thisUnit",_FlameShock,false) then return; end								
					end
				end
			end
	-- Stormblast
			if castSpell("target",_Stormblast,false) then return; end
			if UnitLevel("player") >= 26 then
	-- Stormstrike
				if castSpell("target",_Stormstrike,false) then return; end
			else
	-- Primal Strike
				if castSpell("target",_PrimalStrike,false) then return; end
			end
	-- Lightning Bolt
			--if getMWC() == 5 and getSpellCD(_ChainLightning) >= 2 then
			--	if castSpell("target",_LightningBolt,false) then return; end
			--end
	-- Chain Lightning
			--if getMWC() > 1 then
			--	if castSpell("target",_ChainLightning,false) then return; end
			--end
	-- Lightning Bolt
			--if getMWC() > 1 and getBuffRemain(_AscendanceBuff)==0 then
			--	if castSpell("target",_LightningBolt,false) then return; end
			--end 
		end --Multi-Target Rotation End

------------------------------
--- Single Target Rotation ---
------------------------------
		if getNumEnnemies("player",8) < 3 and getDistance("target")<8 and not useAoE() and isEnnemy("target") and isAlive("target") then
		
	-- Elemental Blast
			if getMWC()>=1 then
				if castSpell("target",_ElementalBlast,false) then return; end
			end
	-- Lightning Bolt
			if shouldBolt() and getHP("player")>=50 then
				if castSpell("target",_LightningBolt,false) then return; end
			end
			if UnitLevel("player") >= 26 then
				if getBuffRemain("player",_AscendanceBuff)>0 then
	-- Stormblast
					if castSpell("target",_Stormblast,false) then return; end
				else
	-- Stormstrike
					if castSpell("target",_Stormstrike,false,false,false,true) then return; end
				end
			else
	-- Primal Strike
				if castSpell("target",_PrimalStrike,false) then return; end
			end
	-- Flame Shock
			if getDebuffRemain("target",_FlameShock)<=3 then
				if castSpell("target",_FlameShock,false) then return; end 
			end
	-- Lava Lash
			if castSpell("target",_LavaLash,false) then return; end
	-- Flame Shock
			if getBuffRemain("player",_UnleashFlame)>0 and getDebuffRemain("target",_FlameShock)<10 then
				if castSpell("target",_FlameShock,false) then return; end 
			end
	-- Unleash Elements
			if castSpell("target",_UnleashElements,true) then return; end
	-- Frost Shock
			if hasGlyph(_FrostShockGlyph) then
				if castSpell("target",_FrostShock,false) then return; end
			end
	-- Lightning Bolt
			--if getMWC()>=3 and getBuffRemain("player",_AscendanceBuff)==0 then
			--	if castSpell("target",_LightningBolt,false) then return; end
			--end
	-- Earth Shock
			if not hasGlyph(_FrostShockGlyph) then
				if castSpell("target",_EarthShock,false) then return; end
			end
	-- Spiritwalker's Grace
			if isMoving("player") then
				if castSpell("player",_SpiritwalkersGrace,true) then return; end
			end
	-- Lightning Bolt
			--if getMWC()>1 and getBuffRemain("player",_AscendanceBuff)==0 then
			--	if castSpell("target",_LightningBolt,false) then return; end
			--end
		end --Single Target Rotation End
		if getDistance("target")<8 and isEnnemy("target") then
			StartAttack()
		end
	end --Class Function End
end --Final End