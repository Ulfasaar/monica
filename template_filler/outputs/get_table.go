func (db DB) Get${table_name} ([]${struct_name}){
    rows, err := db.Connection.Query("SELECT id,id_currency,name,currency_url,supply_url,active FROM ${schema}.${table_name}")

	if err != nil {
		fmt.Println(err)
	}

	tokens := make([]MDToken, 0)

	for rows.Next() {
		var token MDToken
		err = rows.Scan(&token.AssetID, &token.TickerSymbol, &token.AssetName, &token.HomeURL, &token.Explorer, &token.Active)
		tokens = append(tokens, token)
	}

	if err != nil {
		fmt.Println(err)
	}

	return tokens, err
}

func (db DB) Get${table_name} ([]${struct_name}){
    rows, err := db.Connection.Query("SELECT id,id_currency,name,currency_url,supply_url,active FROM ${schema}.${table_name}")

	if err != nil {
		fmt.Println(err)
	}

	tokens := make([]MDToken, 0)

	for rows.Next() {
		var token MDToken
		err = rows.Scan(&token.AssetID, &token.TickerSymbol, &token.AssetName, &token.HomeURL, &token.Explorer, &token.Active)
		tokens = append(tokens, token)
	}

	if err != nil {
		fmt.Println(err)
	}

	return tokens, err
}