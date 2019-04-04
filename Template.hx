typedef Values = {
    var values: Array<Dynamic>;
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


        // make it like cloud formation specifying type value and stuff?
        // if type is list then a seperator should be specified????

    }
    
    public function fill_val(template: String, field: String, val: Any): String{
        return StringTools.replace(template, "${" + field + "}", val);
    }

    // this is the actual funct
    public function _get_filled(template: String, values: Array<Dynamic> ): String{

        var res = [];

           // fill the values in and return filled out template
        for(template_values in this.values.values){
            var unfilled = new String(template);

            for(field in Reflect.fields(template_values)){
                unfilled = fill_val(unfilled, field, template_values.get(field));
            }

            res.push(unfilled);
        }
        
        return res.join("\n\n");
    }

    // this is the easy to use seam, still need to refine for OO based langs like Haxe
    public function get_filled(){

        Libs.write('$folder/outputs/$file_name', _get_filled(this.template, this.values.values));
    }
}