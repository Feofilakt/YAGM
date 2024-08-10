local function printTable(t)
	for x, y in pairs(t) do
		print(x .. " = " .. y);
	end
end

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- function getPlayerForCiv(name)

-- end

function GetModifierId(name)
	for _,modifierID in ipairs(GameEffects.GetModifiers()) do
		local modifier:table = GameEffects.GetModifierDefinition(modifierID);
		if modifier.Id == name then
			return modifierID;
		end
	end

	return nil;
end

function PlayerHasModifier(playerID, name :string)
	for _,instID in ipairs(GameEffects.GetModifiers()) do
		local instdef :table = GameEffects.GetModifierDefinition(instID);
		for key,value in pairs(instdef) do
			if (key == "Id" and value == name) then
				local tSubjects :table = GameEffects.GetModifierSubjects(instID);
				for _,subjectId in pairs(tSubjects) do
					if GameEffects.GetObjectType(subjectId) == "LOC_MODIFIER_OBJECT_PLAYER" then
						local sSubjectString = GameEffects.GetObjectString(subjectId);
						local subjectPlayerId = tonumber( string.match(sSubjectString, "Player: (%d+)") );			
						if (subjectPlayerId == playerID) then
							return true;
						end
					end
				end
			end
		end
	end
	return false;
end

-- as owner or subject
local function CityHasModifier(city :object, name :string)
	local cityName :string = city:GetName();
	for _,instID in ipairs(GameEffects.GetModifiers()) do
		local instdef :table = GameEffects.GetModifierDefinition(instID);
		for key,value in pairs(instdef) do
			if (key == "Id" and value == name) then
				local ownerId = GameEffects.GetModifierOwner(instID);
				local ownerName :string = GameEffects.GetObjectName(ownerId);
				if (ownerName == cityName) then
					return true;
				end

				local tSubjects :table = GameEffects.GetModifierSubjects(instID);
				for _,subjectId in pairs(tSubjects) do
					local sSubjectName :string = GameEffects.GetObjectName(subjectId);
					if (sSubjectName == cityName) then
						return true;
					end
				end
			end
		end
	end
	return false;
end

local function UnitHasModifier(unit :object, name :string)
	local unitId = unit:GetID();
	-- print(unitId);

	for _,instID in ipairs(GameEffects.GetModifiers()) do
		local instdef :table = GameEffects.GetModifierDefinition(instID);
		for key,value in pairs(instdef) do
			if (key == "Id" and value == name) then
				local tSubjects :table = GameEffects.GetModifierSubjects(instID);
				if (tSubjects == nil) then
					return false;
				end

				for _,subjectId in pairs(tSubjects) do
					-- print(subjectId);
					-- print(GameEffects.GetObjectString(subjectId));
					local subjectUnitId = tonumber( string.match(GameEffects.GetObjectString(subjectId), "Unit: (%d+)") );			
					-- print(subjectUnitId);
					
					if (unitId == subjectUnitId) then
						return true;
					end
				end
			end
		end
	end
	return false;
end


-- function IncreaseUnitBaseMoves(unit :object, value :number)
	-- if (unit == nil) then
		-- return;
	-- end
-- end

local function GetTableIndex(sTable:string, sType:string)
	return GameInfo[sTable][sType] and GameInfo[sTable][sType].Index or -1;
end


function OnPillage(iUnitPlayerID :number, iUnitID :number, eImprovement :number, eBuilding :number, eDistrict :number, iPlotIndex :number)	
	local pUnit :object = UnitManager.GetUnit(iUnitPlayerID, iUnitID);
	if (pUnit == nil) then
		return;
	end

	local pCity = Cities.GetPlotPurchaseCity(iPlotIndex);
	if (pCity == nil) then
		return;
	end
	
	if (CityHasModifier(pCity, "CITY_DEFENDER_ADJUST_ATTACKS_PER_TURN")) then
		UnitManager.ChangeMovesRemaining(pUnit, -2);
	end
end
GameEvents.OnPillage.Add(OnPillage);


local CARDINAL_DIVINE_ARCHITECT_BUILDING: number = GetTableIndex("Buildings", "PLAYER_HAS_GOVERNOR_PROMOTION_CARDINAL_DIVINE_ARCHITECT_B");

-- local INDUSTRIALIST_SPECIALIST_PRODUCTION_HOLY_SITE_BUILDING = GetTableIndex("Buildings", "GOVERNOR_INDUSTRIALIST_SPECIALIST_PRODUCTION_HOLY_SITE");
-- local INDUSTRIALIST_SPECIALIST_PRODUCTION_ENCAMPMENT_BUILDING = GetTableIndex("Buildings", "GOVERNOR_INDUSTRIALIST_SPECIALIST_PRODUCTION_ENCAMPMENT");
-- local INDUSTRIALIST_SPECIALIST_PRODUCTION_CAMPUS_BUILDING = GetTableIndex("Buildings", "GOVERNOR_INDUSTRIALIST_SPECIALIST_PRODUCTION_CAMPUS");
-- local INDUSTRIALIST_SPECIALIST_PRODUCTION_HARBOR_BUILDING = GetTableIndex("Buildings", "GOVERNOR_INDUSTRIALIST_SPECIALIST_PRODUCTION_HARBOR");
-- local INDUSTRIALIST_SPECIALIST_PRODUCTION_COMMERCIAL_HUB_BUILDING = GetTableIndex("Buildings", "GOVERNOR_INDUSTRIALIST_SPECIALIST_PRODUCTION_COMMERCIAL_HUB");
-- local INDUSTRIALIST_SPECIALIST_PRODUCTION_THEATER_BUILDING = GetTableIndex("Buildings", "GOVERNOR_INDUSTRIALIST_SPECIALIST_PRODUCTION_THEATER");
-- local INDUSTRIALIST_SPECIALIST_PRODUCTION_INDUSTRIAL_ZONE_BUILDING = GetTableIndex("Buildings", "GOVERNOR_INDUSTRIALIST_SPECIALIST_PRODUCTION_INDUSTRIAL_ZONE");

-- local DISTRICT_HOLY_SITE = GetTableIndex("Districts", "DISTRICT_HOLY_SITE");
-- local DISTRICT_ENCAMPMENT = GetTableIndex("Districts", "DISTRICT_ENCAMPMENT");
-- local DISTRICT_CAMPUS = GetTableIndex("Districts", "DISTRICT_CAMPUS");
-- local DISTRICT_HARBOR = GetTableIndex("Districts", "DISTRICT_HARBOR");
-- local DISTRICT_COMMERCIAL_HUB = GetTableIndex("Districts", "DISTRICT_COMMERCIAL_HUB");
-- local DISTRICT_THEATER = GetTableIndex("Districts", "DISTRICT_THEATER");
-- local DISTRICT_INDUSTRIAL_ZONE = GetTableIndex("Districts", "DISTRICT_INDUSTRIAL_ZONE");

-- local INDUSTRIALIST_SPECIALIST_PRODUCTION_BUILDINGS = {INDUSTRIALIST_SPECIALIST_PRODUCTION_HOLY_SITE_BUILDING, INDUSTRIALIST_SPECIALIST_PRODUCTION_ENCAMPMENT_BUILDING, INDUSTRIALIST_SPECIALIST_PRODUCTION_CAMPUS_BUILDING, INDUSTRIALIST_SPECIALIST_PRODUCTION_HARBOR_BUILDING, INDUSTRIALIST_SPECIALIST_PRODUCTION_COMMERCIAL_HUB_BUILDING, INDUSTRIALIST_SPECIALIST_PRODUCTION_THEATER_BUILDING, INDUSTRIALIST_SPECIALIST_PRODUCTION_INDUSTRIAL_ZONE_BUILDING};
--local INDUSTRIALIST_SPECIALIST_PRODUCTION_DISTRICTS = {DISTRICT_HOLY_SITE, DISTRICT_ENCAMPMENT, DISTRICT_CAMPUS, DISTRICT_HARBOR, DISTRICT_COMMERCIAL_HUB, DISTRICT_THEATER, DISTRICT_INDUSTRIAL_ZONE};

function addDummyBuildings(city)
	local pCityBuildings: table = city:GetBuildings();

	if CityHasModifier(city, "CARDINAL_FAITH_PURCHASE_DISTRICT") then
		if not pCityBuildings:HasBuilding(CARDINAL_DIVINE_ARCHITECT_BUILDING) then
			city:GetBuildQueue():CreateBuilding(CARDINAL_DIVINE_ARCHITECT_BUILDING);
		end
	end
	
	-- if CityHasModifier(city, "GOVERNOR_INDUSTRIALIST_MODIFIER") then
	-- 	-- for _, building in ipairs(INDUSTRIALIST_SPECIALIST_PRODUCTION_BUILDINGS) do
	-- 		if not pCityBuildings:HasBuilding(INDUSTRIALIST_SPECIALIST_PRODUCTION_INDUSTRIAL_ZONE_BUILDING) then
	-- 			city:GetBuildQueue():CreateBuilding(INDUSTRIALIST_SPECIALIST_PRODUCTION_INDUSTRIAL_ZONE_BUILDING);
	-- 		end
	-- 	-- end
	-- end
end


function removeDummyBuildings(city)
	local cityBuildings: table = city:GetBuildings();
	
	if cityBuildings:HasBuilding(CARDINAL_DIVINE_ARCHITECT_BUILDING) and not CityHasModifier(city, "CARDINAL_FAITH_PURCHASE_DISTRICT") then
		cityBuildings:RemoveBuilding(CARDINAL_DIVINE_ARCHITECT_BUILDING);
	end

	-- if not CityHasModifier(city, "GOVERNOR_INDUSTRIALIST_MODIFIER") then
	-- 	-- for _, building in ipairs(INDUSTRIALIST_SPECIALIST_PRODUCTION_BUILDINGS) do
	-- 		local buildingInfo:table = GameInfo.Buildings[INDUSTRIALIST_SPECIALIST_PRODUCTION_INDUSTRIAL_ZONE_BUILDING];
	-- 		-- print(buildingInfo.PrereqDistrict); --'DISTRICT_INDUSTRIAL_ZONE'
	-- 		if cityBuildings:HasBuilding(INDUSTRIALIST_SPECIALIST_PRODUCTION_INDUSTRIAL_ZONE_BUILDING) then
	-- 			cityBuildings:RemoveBuilding(INDUSTRIALIST_SPECIALIST_PRODUCTION_INDUSTRIAL_ZONE_BUILDING);
	-- 		end
	-- 	-- end
	-- end
end


function OnGovernorEstablished(cityOwner, cityID, governorOwner, governorType)
	print('GovernorEstablished');

	local pCity = CityManager.GetCity(cityOwner, cityID);
	if (pCity == nil) then
		return;
	end
	addDummyBuildings(pCity);
end
Events.GovernorEstablished.Add(OnGovernorEstablished);


function OnGovernorChanged(playerID, governorID)
	print('GovernorChanged');
	local player :object = PlayerManager.GetPlayer(playerID);
	for _,city in player:GetCities():Members() do
		removeDummyBuildings(city);
	end
	
	local cityStates :table = PlayerManager.GetAliveMinors();
	for _, cityState in ipairs( cityStates ) do
		for _,city in cityState:GetCities():Members() do
			removeDummyBuildings(city);
		end
	end
end
Events.GovernorChanged.Add(OnGovernorChanged);


function OnGovernorPromoted(playerID, governorID, promotionID)
	print('GovernorPromoted');
	local promotion:table = GameInfo.GovernorPromotions[promotionID];
	local player :object = PlayerManager.GetPlayer(playerID);

	-- if promotion.GovernorPromotionType == "GOVERNOR_PROMOTION_AMBASSADOR_SATELLITE" then
	-- 	local AMBASSADOR_SATELLITE_BUILDING: number = GetTableIndex("Buildings", "PLAYER_HAS_GOVERNOR_PROMOTION_AMBASSADOR_SATELLITE_B");
	-- 	local capital = player:GetCities():GetCapitalCity();
	-- 	local pCityBuildings: table = capital:GetBuildings();
	-- 	if not pCityBuildings:HasBuilding(AMBASSADOR_SATELLITE_BUILDING) then
	-- 		city:GetBuildQueue():CreateBuilding(AMBASSADOR_SATELLITE_BUILDING);
	-- 	end
	-- end

	for _,pCity in player:GetCities():Members() do
		addDummyBuildings(pCity);
	end
	
	local cityStates :table = PlayerManager.GetAliveMinors();
	for _, cityState in ipairs( cityStates ) do
		for _,city in cityState:GetCities():Members() do
			addDummyBuildings(city);
		end
	end
end
Events.GovernorPromoted.Add(OnGovernorPromoted);


function OnCityTransfered(playerID, cityID)
	print('CityTransfered');
	local player :object = PlayerManager.GetPlayer(playerID);
	for _,city in player:GetCities():Members() do
		--removeDummyBuildings(city);
	end
end
Events.CityTransfered.Add(OnCityTransfered);


function OnDistrictConstructedHandler(playerID, districtID)
	print('OnDistrictConstructed');
	local player :object = PlayerManager.GetPlayer(playerID);
	for _,pCity in player:GetCities():Members() do
		addDummyBuildings(pCity);
	end
end
GameEvents.OnDistrictConstructed.Add(OnDistrictConstructedHandler);


-- function OnDistrictAddedToMap(playerID, districtID, cityID)
	-- print('DistrictAddedToMap');
	-- local pCity = CityManager.GetCity(playerID, cityID);	
	-- addDummyBuildings(pCity);
-- end
-- Events.DistrictAddedToMap.Add(OnDistrictAddedToMap);


function OnDistrictPillaged(owner, districtID, cityID)
	print('DistrictPillaged');
	local city = CityManager.GetCity(owner, cityID);
	local district = city:GetDistricts():GetDistrictByID(districtID);
	local districtType = GameInfo.Districts[district:GetType()].DistrictType;
	if not district:IsPillaged() then
		return;
	end
		
	-- local cityBuildings: table = city:GetBuildings();
	-- -- for _, building in ipairs(INDUSTRIALIST_SPECIALIST_PRODUCTION_BUILDINGS) do
	-- 	local buildingInfo:table = GameInfo.Buildings[INDUSTRIALIST_SPECIALIST_PRODUCTION_INDUSTRIAL_ZONE_BUILDING];
	-- 	if cityBuildings:HasBuilding(INDUSTRIALIST_SPECIALIST_PRODUCTION_INDUSTRIAL_ZONE_BUILDING) and buildingInfo.PrereqDistrict == districtType then
	-- 		cityBuildings:RemoveBuilding(INDUSTRIALIST_SPECIALIST_PRODUCTION_INDUSTRIAL_ZONE_BUILDING);
	-- 	end
	-- -- end
end
Events.DistrictPillaged.Add(OnDistrictPillaged);


-- function OnBuildingPillageStateChanged(playerID, cityID, buildingID, bPillageState)
	-- if not bPillageState then
		-- return;
	-- end

	-- print('BuildingPillageStateChanged');
	-- print(playerID);
	-- print(cityID);
	-- print(buildingID);
	-- print(bPillageState);
	
	-- local city = CityManager.GetCity(playerID, cityID);
	-- local cityBuildings: table = city:GetBuildings();
	-- for _, building in ipairs(INDUSTRIALIST_SPECIALIST_PRODUCTION_BUILDINGS) do
		-- if cityBuildings:HasBuilding(building) then
			-- --cityBuildings:RemoveBuilding(building);
		-- end

		-- --local buildingInfo:table = GameInfo.Buildings[building];
		-- -- if cityBuildings:HasBuilding(building) and buildingInfo.PrereqDistrict == districtType then
			-- -- cityBuildings:RemoveBuilding(building);
		-- -- end
	-- end
-- end
-- GameEvents.BuildingPillageStateChanged.Add(OnBuildingPillageStateChanged);


function OnUnitAddedToMap(playerID :number, unitID :number)
	local unit :object = UnitManager.GetUnit(playerID, unitID);
	if (unit == nil) then
		return;
	end

	local unitsWithPromotion = {
		'UNIT_CREE_OKIHTCITAW',
		'UNIT_MACEDONIAN_HETAIROI',
		'UNIT_SULEIMAN_JANISSARY',
		'UNIT_PORTUGUESE_NAU'
	}
	local unitType = GameInfo.Units[unit:GetType()].UnitType;
	if (not has_value(unitsWithPromotion, unitType)) then
		return;
	end

	local plotIndex = Map.GetPlotIndex( unit:GetX(), unit:GetY() );
	local city = Cities.GetPlotPurchaseCity(plotIndex);
	if (city == nil or not CityHasModifier(city, "CITY_DEFENDER_FREE_PROMOTIONS")) then
		return;
	end
	
	local unitExp = unit:GetExperience();
	if (unitExp:CanPromote()) then
		unitExp:ChangeStoredPromotions(1);
	end
end
Events.UnitAddedToMap.Add(OnUnitAddedToMap);


-- function OnCityProductionCompleted(playerID, cityID, iConstructionType, unitID, bCancelled)
-- 	print('blabla1');
-- 	print(unitID);
-- end
-- Events.CityProductionCompleted.Add(OnCityProductionCompleted);

-- function OnUnitAddedToMap2(playerID :number, unitID :number)
-- 	print('blabla2');
-- 	print(unitID);
-- end
-- Events.UnitAddedToMap.Add(OnUnitAddedToMap2);

function OnUnitAddedToMap2(playerID :number, unitID :number)
	local unit :object = UnitManager.GetUnit(playerID, unitID);
	if (unit == nil or playerID ~= unit:GetOriginalOwner()) then
		return;
	end

	local oTTomanId = nil;
	for i = 0, PlayerManager.GetAliveMajorsCount() - 1 do
		if (PlayerConfigurations[i]:GetCivilizationTypeName() == "CIVILIZATION_OTTOMAN") then
			oTTomanId = i;
		end
		-- PlayerConfigurations[playerID]:GetCivilizationTypeName() == "CIVILIZATION_GRAN_COLOMBIA"
		-- player:GetGovernors():HasGovernor()
	-- local pPlayer = Players[playerID];
	-- pPlayer:GetGovernors():ChangeGovernorPoints(pNewGP);
	end

	if (oTTomanId == nil) then
		return;
	end

	if (not UnitHasModifier(unit, "GOVERNOR_UNITS_CONTROL")) then
		return;
	end
	print('blabla');
	print(unitID);

	-- local newUnit = nil;
	local pUnit = UnitManager.GetUnit( playerID, unitId ); 
	local plot = Map.GetPlot(unit:GetX(), unit:GetY());
	local unitType = unit:GetType();

	print(unitType);
	UnitManager.Kill(unit);
	newUnit = UnitManager.InitUnitValidAdjacentHex(oTTomanId, unitType, plot:GetX(), plot:GetY(), 1);
end
Events.UnitAddedToMap.Add(OnUnitAddedToMap2);


function removeBuildings(city, buildings)
	local cityBuildings: table = city:GetBuildings();

	for _, building in ipairs(buildings) do
		if cityBuildings:HasBuilding(building) then
			cityBuildings:RemoveBuilding(building);
		end
	end
end