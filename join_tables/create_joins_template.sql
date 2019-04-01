CREATE TABLE ${table_schema}.${table}(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
	${columns}
);

-- create join table
CREATE TABLE ${table_original}_${table}(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
	${table_original}_id REFERENCES ${table_original}(id) NOT NULL,
	${table}_id REFERENCES ${table}(id) NOT NULL
);

--test the select first
select distinct ${columns_horizontal}
FROM ${table_original};

-- insert the distinct values being broken off
INSERT into ${table_schema}.${table} (${columns_no_types})
select distinct ${columns_horizontal}
FROM ${table_original};


-- insert mapping rows into join table
INSERT INTO ${table_original}_${table}(${columns_no_types})
SELECT distinct ${table_original}.${table_original_id_column}, ${table_schema}.${table}.id
FROM ${table_original} JOIN ${table_schema}.${table} on ${table_original}.${granular_column} = ${table_schema}.${table}.${new_granular_column};


-- check table values
select * from ${table_schema}.${table};

-- drop off split off columns from original
ALTER TABLE ${table_original}
${drop_columns};