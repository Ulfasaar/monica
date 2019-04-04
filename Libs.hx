class Libs{
    public static function read(path: String): String{

        // todo handle other file types eg: docx etc
        return sys.io.File.getContent(path);
    }


    public static function write(path: String, data: String){
        sys.io.File.saveContent(path, data);
    }

    public static function get_json_file(path: String): Dynamic{
        return haxe.Json.parse(read(path));
    }

    public static function contains(to_search: String, value: String): Bool{
        return to_search.indexOf(to_search) != -1;
    }

}