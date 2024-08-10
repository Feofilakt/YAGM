INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES
	('REQUIRES_CITY_HAS_GOVERNOR_PROMOTION_DEFENSE_LOGISTICS', 'REQUIREMENT_CITY_HAS_SPECIFIC_GOVERNOR_PROMOTION_TYPE');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES
	('REQUIRES_CITY_HAS_GOVERNOR_PROMOTION_DEFENSE_LOGISTICS', 'Established', 1),
	('REQUIRES_CITY_HAS_GOVERNOR_PROMOTION_DEFENSE_LOGISTICS', 'GovernorPromotionType', 'GOVERNOR_PROMOTION_DEFENSE_LOGISTICS');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
	('CITY_HAS_GOVERNOR_PROMOTION_DEFENSE_LOGISTICS', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('CITY_HAS_GOVERNOR_PROMOTION_DEFENSE_LOGISTICS', 'REQUIRES_CITY_HAS_GOVERNOR_PROMOTION_DEFENSE_LOGISTICS');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('DEFENSE_LOGISTICS_ANCIENT_WALLS_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION', 'CITY_HAS_GOVERNOR_PROMOTION_DEFENSE_LOGISTICS'),
	('DEFENSE_LOGISTICS_MEDIEVAL_WALLS_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION', 'CITY_HAS_GOVERNOR_PROMOTION_DEFENSE_LOGISTICS'),
	('DEFENSE_LOGISTICS_RENAISSANCE_WALLS_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION', 'CITY_HAS_GOVERNOR_PROMOTION_DEFENSE_LOGISTICS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('DEFENSE_LOGISTICS_ANCIENT_WALLS_PRODUCTION' , 'BuildingType' , 'BUILDING_WALLS'),
	('DEFENSE_LOGISTICS_ANCIENT_WALLS_PRODUCTION' , 'Amount' , 50),
	('DEFENSE_LOGISTICS_MEDIEVAL_WALLS_PRODUCTION' , 'BuildingType' , 'BUILDING_CASTLE'),
	('DEFENSE_LOGISTICS_MEDIEVAL_WALLS_PRODUCTION' , 'Amount' , 50),
	('DEFENSE_LOGISTICS_RENAISSANCE_WALLS_PRODUCTION' , 'BuildingType' , 'BUILDING_STAR_FORT'),
	('DEFENSE_LOGISTICS_RENAISSANCE_WALLS_PRODUCTION' , 'Amount' , 50);
INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
	('GOVERNOR_PROMOTION_DEFENSE_LOGISTICS', 'DEFENSE_LOGISTICS_ANCIENT_WALLS_PRODUCTION'),
	('GOVERNOR_PROMOTION_DEFENSE_LOGISTICS', 'DEFENSE_LOGISTICS_MEDIEVAL_WALLS_PRODUCTION'),
	('GOVERNOR_PROMOTION_DEFENSE_LOGISTICS', 'DEFENSE_LOGISTICS_RENAISSANCE_WALLS_PRODUCTION');

UPDATE GovernorPromotionModifiers SET GovernorPromotionType = 'GOVERNOR_PROMOTION_DEFENSE_LOGISTICS'
	WHERE ModifierId = 'CITY_DEFENDER_ADJUST_ATTACKS_PER_TURN';


INSERT OR IGNORE INTO Types (Type, Kind) VALUES
	('MODIFIER_CITY_DISTRICTS_ADJUST_ATTACK_RANGE', 'KIND_MODIFIER'),
	('MODIFIER_CITY_ADJUST_RANGED_STRIKE', 'KIND_MODIFIER');
INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES
	('MODIFIER_CITY_DISTRICTS_ADJUST_ATTACK_RANGE', 'COLLECTION_CITY_DISTRICTS', 'EFFECT_ADJUST_DISTRICT_ATTACK_RANGE'),
	('MODIFIER_CITY_ADJUST_RANGED_STRIKE', 'COLLECTION_OWNER', 'EFFECT_ADJUST_CITY_RANGED_STRIKE');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('EMBRASURE_CITY_ATTACK_RANGE', 'MODIFIER_CITY_DISTRICTS_ADJUST_ATTACK_RANGE', 'DISTRICT_IS_CITY_CENTER'),
	('EMBRASURE_CITY_ATTACK_STRENGTH', 'MODIFIER_CITY_ADJUST_RANGED_STRIKE', Null);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('EMBRASURE_CITY_ATTACK_RANGE' , 'Amount' , 1),
	('EMBRASURE_CITY_ATTACK_STRENGTH' , 'Amount' , 3);
INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
	('GOVERNOR_PROMOTION_EMBRASURE', 'EMBRASURE_CITY_ATTACK_RANGE'),
	('GOVERNOR_PROMOTION_EMBRASURE', 'EMBRASURE_CITY_ATTACK_STRENGTH');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('GOVERNOR_EMBRASURE_ANCIENT_WALLS_AMENITY', 'MODIFIER_CITY_DISTRICTS_ADJUST_DISTRICT_AMENITY', 'DISTRICT_IS_CITY_CENTER_ANCIENT'),
	('GOVERNOR_EMBRASURE_MEDIEVAL_WALLS_AMENITY', 'MODIFIER_CITY_DISTRICTS_ADJUST_DISTRICT_AMENITY', 'DISTRICT_IS_CITY_CENTER_MEDIEVAL'),
	('GOVERNOR_EMBRASURE_RENAISSANCE_WALLS_AMENITY', 'MODIFIER_CITY_DISTRICTS_ADJUST_DISTRICT_AMENITY', 'DISTRICT_IS_CITY_CENTER_RENAISSANCE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('GOVERNOR_EMBRASURE_ANCIENT_WALLS_AMENITY' , 'Amount' , 50),
	('GOVERNOR_EMBRASURE_MEDIEVAL_WALLS_AMENITY' , 'Amount' , 50),
	('GOVERNOR_EMBRASURE_RENAISSANCE_WALLS_AMENITY' , 'Amount' , 50);
INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
	('GOVERNOR_PROMOTION_EMBRASURE', 'GOVERNOR_EMBRASURE_ANCIENT_WALLS_AMENITY'),
	('GOVERNOR_PROMOTION_EMBRASURE', 'GOVERNOR_EMBRASURE_MEDIEVAL_WALLS_AMENITY'),
	('GOVERNOR_PROMOTION_EMBRASURE', 'GOVERNOR_EMBRASURE_RENAISSANCE_WALLS_AMENITY');

DELETE FROM GovernorPromotionPrereqs WHERE GovernorPromotionType='GOVERNOR_PROMOTION_EDUCATOR_ARMS_RACE_PROPONENT';
DELETE FROM GovernorPromotionPrereqs WHERE GovernorPromotionType='GOVERNOR_PROMOTION_EMBRASURE' AND PrereqGovernorPromotion = 'GOVERNOR_PROMOTION_GARRISON_COMMANDER';
DELETE FROM GovernorPromotionModifiers WHERE GovernorPromotionType='GOVERNOR_PROMOTION_EDUCATOR_ARMS_RACE_PROPONENT';
DELETE FROM GovernorPromotionModifiers WHERE ModifierId='DEFENSE_LOGISTICS_BONUS_STRATEGICS';
DELETE FROM GovernorPromotions WHERE GovernorPromotionType='GOVERNOR_PROMOTION_EDUCATOR_ARMS_RACE_PROPONENT';
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES', 'KIND_GOVERNOR_PROMOTION');
INSERT OR IGNORE INTO GovernorPromotions (GovernorPromotionType, Name, Description, Level, Column, BaseAbility)
	VALUES ('GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES', 'LOC_GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES_NAME', 'LOC_GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES_DESCRIPTION', 2, 0, 0);
INSERT OR IGNORE INTO GovernorPromotionSets (GovernorType, GovernorPromotion)
	VALUES ('GOVERNOR_THE_DEFENDER', 'GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES');
INSERT OR IGNORE INTO GovernorPromotionPrereqs ( GovernorPromotionType, PrereqGovernorPromotion ) VALUES
	( 'GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES', 'GOVERNOR_PROMOTION_GARRISON_COMMANDER' ),
	( 'GOVERNOR_PROMOTION_AIR_DEFENSE_INITIATIVE', 'GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES' );
UPDATE GovernorPromotionModifiers SET GovernorPromotionType = 'GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES'
	WHERE ModifierId = 'CITY_DEFENDER_FREE_PROMOTIONS';

-- UPDATE ModifierArguments SET Value=50 WHERE ModifierId='BLACK_MARKETEER_STRATEGIC_RESOURCE_COST_DISCOUNT' AND Name='Amount';
-- INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
-- 	('GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES', 'BLACK_MARKETEER_STRATEGIC_RESOURCE_COST_DISCOUNT');

INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
	('GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES', 'ADJUST_CITY_MOST_ADVANCED_STRATEGIC_RESOURCE_ACCUMULATION_ALUMINUM'),
	('GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES', 'ADJUST_CITY_MOST_ADVANCED_STRATEGIC_RESOURCE_ACCUMULATION_COAL'),
	('GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES', 'ADJUST_CITY_MOST_ADVANCED_STRATEGIC_RESOURCE_ACCUMULATION_HORSES'),
	('GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES', 'ADJUST_CITY_MOST_ADVANCED_STRATEGIC_RESOURCE_ACCUMULATION_IRON'),
	('GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES', 'ADJUST_CITY_MOST_ADVANCED_STRATEGIC_RESOURCE_ACCUMULATION_NITER'),
	('GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES', 'ADJUST_CITY_MOST_ADVANCED_STRATEGIC_RESOURCE_ACCUMULATION_OIL'),
	('GOVERNOR_PROMOTION_UNITPROMOS_AND_RESOURCES', 'ADJUST_CITY_MOST_ADVANCED_STRATEGIC_RESOURCE_ACCUMULATION_URANIUM');

-- INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, Permanent) VALUES
-- 	('GOVERNOR_IBRAHIM_STRATEGIC_PRODUCTION', 'MODIFIER_SINGLE_CITY_TRAINED_UNITS_ADJUST_MOVEMENT', 1),
-- 	('GOVERNOR_IBRAHIM_STRATEGIC_ACCUMULATION', 'MODIFIER_SINGLE_CITY_TRAINED_UNITS_ADJUST_MOVEMENT', 1);
-- INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
-- 	('GOVERNOR_UNITS_CONTROL_ATTACH' , 'ModifierId' , 'GOVERNOR_UNITS_CONTROL'),
-- 	('GOVERNOR_UNITS_CONTROL_ATTACH' , 'Amount' , 0);





UPDATE GovernorPromotions SET Column = 2 WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_AIR_DEFENSE_INITIATIVE';
UPDATE GovernorPromotions SET Column = 4 WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_EMBRASURE';
UPDATE GovernorPromotions SET Column = 1 WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_GARRISON_COMMANDER';
UPDATE GovernorPromotions SET Column = 3 WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_DEFENSE_LOGISTICS';
 

INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('GOVERNOR_PROMOTION_POLICE', 'KIND_GOVERNOR_PROMOTION');
INSERT OR IGNORE INTO GovernorPromotions (GovernorPromotionType, Name, Description, Level, Column, BaseAbility)
	VALUES ('GOVERNOR_PROMOTION_POLICE', 'LOC_GOVERNOR_PROMOTION_POLICE_NAME', 'LOC_GOVERNOR_PROMOTION_POLICE_DESCRIPTION', 2, 2, 0);
INSERT OR IGNORE INTO GovernorPromotionSets (GovernorType, GovernorPromotion)
	VALUES ('GOVERNOR_THE_DEFENDER', 'GOVERNOR_PROMOTION_POLICE');
INSERT OR IGNORE INTO GovernorPromotionPrereqs ( GovernorPromotionType, PrereqGovernorPromotion ) VALUES
	( 'GOVERNOR_PROMOTION_POLICE', 'GOVERNOR_PROMOTION_GARRISON_COMMANDER' ),
	( 'GOVERNOR_PROMOTION_POLICE', 'GOVERNOR_PROMOTION_DEFENSE_LOGISTICS' ),
	( 'GOVERNOR_PROMOTION_AIR_DEFENSE_INITIATIVE', 'GOVERNOR_PROMOTION_POLICE' );
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType) VALUES
	('GOVERNOR_POLICE_SPY_DEFENSE_BONUS_CITY', 'MODIFIER_CITY_ADJUST_SPY_BONUS'),
	('GOVERNOR_POLICE_SPY_DEFENSE_BONUS_ALL_CITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_SPY_BONUS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('GOVERNOR_POLICE_SPY_DEFENSE_BONUS_CITY' , 'Amount' , 1),
	('GOVERNOR_POLICE_SPY_DEFENSE_BONUS_ALL_CITIES' , 'Amount' , 1);
INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
	('GOVERNOR_PROMOTION_POLICE', 'GOVERNOR_POLICE_SPY_DEFENSE_BONUS_CITY'),
	('GOVERNOR_PROMOTION_POLICE', 'GOVERNOR_POLICE_SPY_DEFENSE_BONUS_ALL_CITIES');
