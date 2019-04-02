-- Start of join tables 


CREATE TABLE asset.distribution(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
	process text,
	processing_type text
);

-- create join table
CREATE TABLE asset.metadata_distribution(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
	asset_id UUID REFERENCES asset.metadata(asset_id) NOT NULL,
	distribution_id UUID REFERENCES asset.distribution(id) NOT NULL
);

--test the select first
select distinct mining, mining_type
FROM asset.metadata;

-- insert the distinct values being broken off
INSERT into asset.distribution (process, processing_type)
select distinct mining, mining_type
FROM asset.metadata;


-- insert mapping rows into join table
INSERT INTO asset.metadata_distribution(asset_id, distribution_id)
SELECT distinct asset.metadata.asset_id, asset.distribution.id
FROM asset.metadata JOIN asset.distribution on asset.metadata.mining = asset.distribution.process;


-- check table values
select * from asset.distribution;

-- drop off split off columns from original
ALTER TABLE asset.metadata
DROP COLUMN mining,
DROP COLUMN mining_type;

CREATE TABLE asset.hashing_algorithm(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
	"name" text,
	"group" text
);

-- create join table
CREATE TABLE asset.metadata_hashing_algorithm(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
	asset_id UUID REFERENCES asset.metadata(asset_id) NOT NULL,
	hashing_algorithm_id UUID REFERENCES asset.hashing_algorithm(id) NOT NULL
);

--test the select first
select distinct hashing_algorithm, hashing_algorithm_group
FROM asset.metadata;

-- insert the distinct values being broken off
INSERT into asset.hashing_algorithm ("name", "group")
select distinct hashing_algorithm, hashing_algorithm_group
FROM asset.metadata;


-- insert mapping rows into join table
INSERT INTO asset.metadata_hashing_algorithm(asset_id, hashing_algorithm_id)
SELECT distinct asset.metadata.asset_id, asset.hashing_algorithm.id
FROM asset.metadata JOIN asset.hashing_algorithm on asset.metadata.hashing_algorithm = asset.hashing_algorithm."name";


-- check table values
select * from asset.hashing_algorithm;

-- drop off split off columns from original
ALTER TABLE asset.metadata
DROP COLUMN hashing_algorithm,
DROP COLUMN hashing_algorithm_group;

CREATE TABLE asset.scripting_language(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
	"name" text
);

-- create join table
CREATE TABLE asset.metadata_scripting_language(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
	asset_id UUID REFERENCES asset.metadata(asset_id) NOT NULL,
	scripting_language_id UUID REFERENCES asset.scripting_language(id) NOT NULL
);

--test the select first
select distinct scripting_language
FROM asset.metadata;

-- insert the distinct values being broken off
INSERT into asset.scripting_language ("name")
select distinct scripting_language
FROM asset.metadata;


-- insert mapping rows into join table
INSERT INTO asset.metadata_scripting_language(asset_id, scripting_language_id)
SELECT distinct asset.metadata.asset_id, asset.scripting_language.id
FROM asset.metadata JOIN asset.scripting_language on asset.metadata.scripting_language = asset.scripting_language."name";


-- check table values
select * from asset.scripting_language;

-- drop off split off columns from original
ALTER TABLE asset.metadata
DROP COLUMN scripting_language;
