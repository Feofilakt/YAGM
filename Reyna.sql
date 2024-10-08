INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_CITY_HAS_GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION', 'REQUIREMENT_CITY_HAS_SPECIFIC_GOVERNOR_PROMOTION_TYPE');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES
	('REQUIRES_CITY_HAS_GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION', 'Established', 1),
	('REQUIRES_CITY_HAS_GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION', 'GovernorPromotionType', 'GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('CITY_HAS_GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('CITY_HAS_GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION', 'REQUIRES_CITY_HAS_GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION');
	
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('LAND_ACQUISITION_PLOTPURCHASECOST', 'MODIFIER_PLAYER_CITIES_ADJUST_PLOT_PURCHASE_COST', 'CITY_HAS_GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('LAND_ACQUISITION_PLOTPURCHASECOST' , 'Amount' , -20);
	
INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
	('GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION', 'LAND_ACQUISITION_PLOTPURCHASECOST');
UPDATE GovernorPromotionModifiers SET GovernorPromotionType = 'GOVERNOR_PROMOTION_MERCHANT_TAX_COLLECTOR'
	WHERE ModifierId = 'FOREIGN_EXCHANGE_GOLD_FROM_FOREIGN_TRADE_PASSING_THROUGH';
	
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('PLOT_HAS_ANY_TREES', 'REQUIREMENTSET_TEST_ANY');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('PLOT_HAS_ANY_TREES', 'REQUIRES_PLOT_HAS_JUNGLE'),
	('PLOT_HAS_ANY_TREES', 'PLOT_IS_FOREST_REQUIREMENT');
UPDATE Modifiers SET SubjectRequirementSetId = 'PLOT_HAS_ANY_TREES'
	WHERE ModifierId = 'FORESTRY_MANAGEMENT_FEATURE_NO_IMPROVEMENT_GOLD';
/* UPDATE Modifiers SET ModifierType = 'MODIFIER_PLAYER_CITIES_ADJUST_FEATURE_APPEAL_MODIFIER'
	WHERE ModifierId = 'FORESTRY_MANAGEMENT_FEATURE_NO_IMPROVEMENT_APPEAL';
 */
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType) VALUES
	('FORESTRY_MANAGEMENT_APPEAL_JUNGLE', 'MODIFIER_CITY_ADJUST_FEATURE_APPEAL_MODIFIER'),
	('FORESTRY_MANAGEMENT_APPEAL_OASIS', 'MODIFIER_CITY_ADJUST_FEATURE_APPEAL_MODIFIER'),
	('FORESTRY_MANAGEMENT_APPEAL_FOREST', 'MODIFIER_CITY_ADJUST_FEATURE_APPEAL_MODIFIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('FORESTRY_MANAGEMENT_APPEAL_JUNGLE', 'FeatureType' , 'FEATURE_JUNGLE'),
	('FORESTRY_MANAGEMENT_APPEAL_JUNGLE', 'Amount' , 1),
	('FORESTRY_MANAGEMENT_APPEAL_OASIS', 'FeatureType' , 'FEATURE_OASIS'),
	('FORESTRY_MANAGEMENT_APPEAL_OASIS', 'Amount' , 1),
	('FORESTRY_MANAGEMENT_APPEAL_FOREST', 'FeatureType' , 'FEATURE_FOREST'),
	('FORESTRY_MANAGEMENT_APPEAL_FOREST', 'Amount' , 1);
DELETE FROM GovernorPromotionModifiers WHERE ModifierId = 'FORESTRY_MANAGEMENT_FEATURE_NO_IMPROVEMENT_APPEAL';
INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
	('GOVERNOR_PROMOTION_MERCHANT_FORESTRY_MANAGEMENT', 'FORESTRY_MANAGEMENT_APPEAL_JUNGLE'),
	('GOVERNOR_PROMOTION_MERCHANT_FORESTRY_MANAGEMENT', 'FORESTRY_MANAGEMENT_APPEAL_OASIS'),
	('GOVERNOR_PROMOTION_MERCHANT_FORESTRY_MANAGEMENT', 'FORESTRY_MANAGEMENT_APPEAL_FOREST');

--UPDATE ModifierArguments SET Value = 3 WHERE ModifierId = 'TAX_COLLECTOR_ADJUST_CITIZEN_GPT';
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='FOREIGN_EXCHANGE_GOLD_FROM_FOREIGN_TRADE_PASSING_THROUGH' AND Name='Amount';

INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('PLOT_HAS_LUXURY_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('PLOT_HAS_LUXURY_REQUIREMENTS', 'REQUIRES_PLOT_HAS_LUXURY');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('GOVERNOR_MERCHANT_LUXURY_GOLD', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_LUXURY_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('GOVERNOR_MERCHANT_LUXURY_GOLD', 'YieldType' , 'YIELD_GOLD'),
	('GOVERNOR_MERCHANT_LUXURY_GOLD', 'Amount' , 2);
INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
	('GOVERNOR_PROMOTION_MERCHANT_HARBORMASTER', 'GOVERNOR_MERCHANT_LUXURY_GOLD');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId) VALUES
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_SCIENCE', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER', 'PLAYER_HAS_GOLDEN_AGE'),
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_CULTURE', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER', 'PLAYER_HAS_GOLDEN_AGE'),
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_PRODUCTION', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER', 'PLAYER_HAS_GOLDEN_AGE'),
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_GOLD', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER', 'PLAYER_HAS_GOLDEN_AGE'),
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_FAITH', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER', 'PLAYER_HAS_GOLDEN_AGE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_SCIENCE', 'YieldType' , 'YIELD_SCIENCE'),
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_SCIENCE', 'Amount' , 25),
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_CULTURE', 'YieldType' , 'YIELD_CULTURE'),
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_CULTURE', 'Amount' , 25),
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_PRODUCTION', 'YieldType' , 'YIELD_PRODUCTION'),
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_PRODUCTION', 'Amount' , 25),
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_GOLD', 'YieldType' , 'YIELD_GOLD'),
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_GOLD', 'Amount' , 25),
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_FAITH', 'YieldType' , 'YIELD_FAITH'),
	('GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_FAITH', 'Amount' , 25);
DELETE FROM GovernorPromotionModifiers WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_MERCHANT_RENEWABLE_ENERGY';
INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
	('GOVERNOR_PROMOTION_MERCHANT_RENEWABLE_ENERGY', 'GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_SCIENCE'),
	('GOVERNOR_PROMOTION_MERCHANT_RENEWABLE_ENERGY', 'GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_CULTURE'),
	('GOVERNOR_PROMOTION_MERCHANT_RENEWABLE_ENERGY', 'GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_PRODUCTION'),
	('GOVERNOR_PROMOTION_MERCHANT_RENEWABLE_ENERGY', 'GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_GOLD'),
	('GOVERNOR_PROMOTION_MERCHANT_RENEWABLE_ENERGY', 'GOVERNOR_MERCHANT_CITY_GOLDEN_AGE_FAITH');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('GOVERNOR_MERCHANT_COAST_LAKE_GOLD', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_COAST_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('GOVERNOR_MERCHANT_COAST_LAKE_GOLD', 'YieldType' , 'YIELD_GOLD'),
	('GOVERNOR_MERCHANT_COAST_LAKE_GOLD', 'Amount' , 2);
INSERT OR IGNORE INTO Types (Type, Kind) VALUES
	('GOVERNOR_PROMOTION_MERCHANT_COAST_LAKE_GOLD', 'KIND_GOVERNOR_PROMOTION');
INSERT OR IGNORE INTO GovernorPromotions (GovernorPromotionType, Name, Description, Level, Column, BaseAbility) VALUES
	('GOVERNOR_PROMOTION_MERCHANT_COAST_LAKE_GOLD', 'LOC_GOVERNOR_PROMOTION_MERCHANT_COAST_LAKE_GOLD_NAME', 'LOC_GOVERNOR_PROMOTION_MERCHANT_COAST_LAKE_GOLD_DESCRIPTION', 1, 4, 0);
INSERT OR IGNORE INTO GovernorPromotionSets (GovernorType, GovernorPromotion) VALUES
	('GOVERNOR_THE_MERCHANT', 'GOVERNOR_PROMOTION_MERCHANT_COAST_LAKE_GOLD');
INSERT OR IGNORE INTO GovernorPromotionPrereqs ( GovernorPromotionType, PrereqGovernorPromotion ) VALUES
	( 'GOVERNOR_PROMOTION_MERCHANT_COAST_LAKE_GOLD', 'GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION' ),
	( 'GOVERNOR_PROMOTION_MERCHANT_TAX_COLLECTOR', 'GOVERNOR_PROMOTION_MERCHANT_COAST_LAKE_GOLD' );
INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
	('GOVERNOR_PROMOTION_MERCHANT_COAST_LAKE_GOLD', 'GOVERNOR_MERCHANT_COAST_LAKE_GOLD');
	
UPDATE GovernorPromotions SET Column = 2 WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_MERCHANT_TAX_COLLECTOR';
UPDATE GovernorPromotions SET Column = 1 WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_MERCHANT_CONTRACTOR';
UPDATE GovernorPromotions SET Column = 3 WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_MERCHANT_RENEWABLE_ENERGY';


UPDATE DynamicModifiers SET CollectionType = 'COLLECTION_PLAYER_CITIES' WHERE ModifierType = 'MODIFIER_CITY_ADJUST_CAN_PURCHASE_DISTRICTS';
/* INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('CITY_CAN_PURCHASE_DISTRICTS_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ANY');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId) VALUES
	('CITY_CAN_PURCHASE_DISTRICTS_REQUIREMENTS' , 'REQUIRES_CITY_HAS_MARKET'),
	('CITY_CAN_PURCHASE_DISTRICTS_REQUIREMENTS' , 'REQUIRES_CITY_HAS_LIGHTHOUSE');
UPDATE Modifiers SET SubjectRequirementSetId = 'CITY_CAN_PURCHASE_DISTRICTS_REQUIREMENTS' WHERE ModifierId = 'CONTRACTOR_ENABLE_DISTRICT_PURCHASE';
 */