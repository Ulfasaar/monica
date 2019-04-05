
typedef ValuesValues = Array<Map<String, Map<String, Dynamic>>>;

typedef Values = {
    // var values: Array<Dynamic>;
    var values: ValuesValues;
}

typedef ListValue = {
    var type: String;
    var seperator: String;
    var values: Array<String>;
    @:optional var alterations: ListValueAlteration;
}

/**
 * Contains the changes to be made to each element
 */
typedef ListValueAlteration = {
    @:optional var prefix: String;
    @:optional var suffix: String;
}

typedef StringValue = {
    var type: String;
    var value: String;
}


class Template{
    private var template: String;
    private var values: Values;
    private var folder = "template_filler";
    private var file_name: String;

    public function new(file_name: String){
        // json file append .json to end of the file for data
        // currently data is always in format of {"values": [{},{}]}
        // each json blob should contain the same keys for that file to fill in values
        this.template = Libs.read('$folder/templates/$file_name[tmp]');
        this.values = Libs.get_json_file('$folder/values/$file_name.json');
        this.file_name = file_name;

    }
    
    public function fill_val(template: String, field: String, val: Any): String{
        return StringTools.replace(template, "${" + field + "}", val);
    }

    // this is the actual funct
    public function _get_filled(template: String, values: ValuesValues ): String{

        var res = [];

           // fill the values in and return filled out template

        // for each result that will be outputted
        for(template_values in values){
            var unfilled = new String(template);

            // for each field in the json blob
            for(field in template_values.keys()){
                
                var field_value = template_values.get(field);

                Sys.println(field_value);
                var val_type = field_value["type"];

                var field_res: Dynamic;
                var field_altered: Dynamic = null;

                if(val_type == 'list'){
                    var val = template_values[field];

                    var parsed_vals: Array<String>= val.get("values");
                    var seperator: String = val.get("seperator");

                    // if the alterations are provided and it is requested in the template process it
                    if(val.get("alterations") != null && Libs.contains(template, '$field[altered]')){

                        var altered_items: Array<String>= [];

                        for(item in parsed_vals){
                            var altered_text = '';

                            var prefix: String = val.get("alterations").get("prefix");

                            if( prefix != null){
                                altered_text = prefix;
                            }

                            altered_text = altered_text + item;

                            var suffix: String = val.get("alterations").get("suffix");

                            if(suffix != null){
                                altered_text = altered_text + suffix;
                            }

                            altered_items.push(altered_text);
                        }

                        field_altered = altered_items.join(seperator);
                        
                    }
                    
                    field_res = parsed_vals.join(seperator);

                }
                else if(val_type == 'string'){
                    var val = template_values.get(field);
                    field_res = val.get("value");
                }
                else{
                    field_res = template_values.get(field).get("value");
                }

                unfilled = this.fill_val(unfilled, field, field_res);

                if(field_altered != null){
                    unfilled = this.fill_val(unfilled, '$field[altered]', field_altered);
                    field_altered = null;
                }
            }

            // do special handling for list types

            res.push(unfilled);
        }
        
        return res.join("\n\n");
    }

    // this is the easy to use seam, still need to refine for OO based langs like Haxe
    public function get_filled(){

        Libs.write('$folder/outputs/$file_name', this._get_filled(this.template, this.values.values));
    }
}