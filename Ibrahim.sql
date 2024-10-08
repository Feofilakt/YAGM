-- INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId) VALUES
-- 	('MM', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER', Null);
-- INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
-- 	('MM', 'YieldType' , 'YIELD_SCIENCE'),
-- 	('MM', 'Amount' , -99);
-- INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
-- 	('GOVERNOR_PROMOTION_PASHA', 'MM');


UPDATE ModifierArguments SET Value=25 WHERE ModifierId='PASHA_BONUS_UNIT_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value=7 WHERE ModifierId='HEAD_FALCONER_ADJUST_CITY_COMBAT_BONUS' AND Name='Amount';

UPDATE GovernorPromotions SET Column = 1 WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_HEAD_FALCONER';
UPDATE GovernorPromotions SET Column = 3 WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_SERASKER';
UPDATE GovernorPromotions SET Column = 2 WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_GRAND_VISIER';

DELETE FROM GovernorPromotionModifiers WHERE GovernorPromotionType='GOVERNOR_PROMOTION_CAPOU_AGHA';
DELETE FROM GovernorPromotionPrereqs WHERE GovernorPromotionType='GOVERNOR_PROMOTION_CAPOU_AGHA' or PrereqGovernorPromotion = 'GOVERNOR_PROMOTION_CAPOU_AGHA';
UPDATE GovernorPromotions SET Level = 3, Column = 4 WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_CAPOU_AGHA';

UPDATE GovernorPromotions SET Column = 2 WHERE GovernorPromotionType = 'GOVERNOR_PROMOTION_KHASS_ODA_BASHI';
INSERT OR IGNORE INTO GovernorPromotionPrereqs ( GovernorPromotionType, PrereqGovernorPromotion ) VALUES
	( 'GOVERNOR_PROMOTION_KHASS_ODA_BASHI', 'GOVERNOR_PROMOTION_SERASKER' );
INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
	('GOVERNOR_PROMOTION_KHASS_ODA_BASHI', 'CAPOU_AGHA_ADJUST_GRIEVANCES');

INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('UNIT_IS_MILITARY', 'REQUIREMENTSET_TEST_ANY');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('UNIT_IS_MILITARY', 'REQUIREMENT_UNIT_IS_MELEE'),
	('UNIT_IS_MILITARY', 'REQUIREMENT_UNIT_IS_RANGED'),
	('UNIT_IS_MILITARY', 'REQUIREMENT_UNIT_IS_SIEGE'),
	('UNIT_IS_MILITARY', 'REQUIREMENT_UNIT_IS_ANTI_CAV'),
	('UNIT_IS_MILITARY', 'UNIT_IS_NAVAL_REQUIREMENT'),
	('UNIT_IS_MILITARY', 'UNIT_IS_HEAVY_CAVALRY'),
	('UNIT_IS_MILITARY', 'RECON_UNITS'),
	('UNIT_IS_MILITARY', 'UNIT_IS_LIGHT_CAVALRY');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, Permanent, SubjectRequirementSetId) VALUES
	('GOVERNOR_UNITS_CONTROL_ATTACH', 'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER', 0, Null),
	('GOVERNOR_UNITS_CONTROL', 'MODIFIER_SINGLE_CITY_TRAINED_UNITS_ADJUST_MOVEMENT', 1, 'UNIT_IS_MILITARY');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('GOVERNOR_UNITS_CONTROL_ATTACH' , 'ModifierId' , 'GOVERNOR_UNITS_CONTROL'),
	('GOVERNOR_UNITS_CONTROL_ATTACH' , 'Amount' , 0);

INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('GOVERNOR_PROMOTION_BEYLERBEYI', 'KIND_GOVERNOR_PROMOTION');
INSERT OR IGNORE INTO GovernorPromotions (GovernorPromotionType, Name, Description, Level, Column, BaseAbility)
	VALUES ('GOVERNOR_PROMOTION_BEYLERBEYI', 'LOC_GOVERNOR_PROMOTION_BEYLERBEYI_NAME', 'LOC_GOVERNOR_PROMOTION_BEYLERBEYI_DESCRIPTION', 3, 0, 0);
INSERT OR IGNORE INTO GovernorPromotionSets (GovernorType, GovernorPromotion)
	VALUES ('GOVERNOR_IBRAHIM', 'GOVERNOR_PROMOTION_BEYLERBEYI');
INSERT OR IGNORE INTO GovernorPromotionPrereqs ( GovernorPromotionType, PrereqGovernorPromotion ) VALUES
	( 'GOVERNOR_PROMOTION_BEYLERBEYI', 'GOVERNOR_PROMOTION_KHASS_ODA_BASHI' );
INSERT OR IGNORE INTO GovernorPromotionModifiers (GovernorPromotionType, ModifierId) VALUES
	('GOVERNOR_PROMOTION_BEYLERBEYI', 'GOVERNOR_UNITS_CONTROL_ATTACH');
