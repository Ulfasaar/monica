typedef Table = {
    var columns: Array<String>;
    var columns_horizontal: Array<String>;
    var table: String;
    var table_original: String;
    var schema: String;
    var table_original_id_column: String;
    var granular_column: String;
    var new_granular_column: String;
}


typedef TableData = {
    var tables: Array<Table>;
}


class Main {

   
    static function generate_random_json_blobs(){
        // generates a n list of json blobs with different keys
        // configurable fields num fields etc
        return "{'cat': 'dog', 'pet': 'true'}, {'cat': 'mouse', 'pet': 'true'},  {'cat': 'moose', 'pet': 'false'}";
    }

   
    static function remember(content: String){

        // ! Bug it should store stuff with keys so that it can remember multiple things
        // only writes to memory once for now
        var memory = Libs.read('memory.txt');

        if(memory.indexOf(content) == -1){
            var output = sys.io.File.append('memory.txt', false);
            output.writeString(content);

            // todo try file.Write so that a file gets created???
        }
    }

    static function ask(message: String): String{
        // ask for input 
        speak(message);
        return prompt();
    }

    static function prompt(): String{
        Sys.print('=> ');
        return Sys.stdin().readLine();
    }

    static function print_header(){

        var content:String = Libs.read('banner.txt');

        // keep this way for now so that when she talks she doesn't blurt out special characters
        Sys.println(content);
    }

    static function speak(message: String){
        Sys.println(message);
    }

    static function run(command: String){
        Sys.command(command);
    }

    static function farewell(){
        speak('Good bye! :)');
    }

    static public function main() {

        print_header();

        var memory = Libs.read('memory.txt');

        if(memory == ''){
            speak("Hello I am Monica your personal digital assistant!\n");
            var name = ask('What is your name?');
            remember(name);
        } else{
            speak('Hello $memory!');
        }

        var answer = ask('How may I help you today? ');

        while(answer != 'bye'){


            if(answer.substring(0,4) == 'open'){
                
                // ! bug: Currently for rambox if it isnt already open monica freezes after it is opened
                var path = '/home/ryan/apps/' + answer.substr(5) + '.AppImage';
                speak('opening ' + path);

                // run the app and continue prompting
                run(path);
            }

            if(answer == 'fill templates'){
                // var file_name = answer.substring(14);

                // todo change to use for loop over filenames in folder 
                // todo change so that output file doesn't have to already exist

                var template = new Template('get_table.go');

                speak('Filled in your templates :)');
                // Sys.println('\n' + template.get_filled());
            }

            if(answer == 'generate random'){
                speak('Heres your pile of random dicts.');
                Sys.println(generate_random_json_blobs());
            }

            if(answer == 'thank you' || answer == 'thanks'){
                speak('No worries.');
            }
            if(answer == 'muscles'){
                var sections = Libs.read('muscles.txt').split('\n\nOrigins');
                var muscles = sections[0].split('\n');
                var sections2 = sections[1].split('\nInsertions');
                var origins = sections2[0].split('\n').slice(1);
                var sections3 = sections2[1].split('\nInnervation');
                var insertions = sections3[0].split('\n').slice(1);
                var section4 = sections3[1].split('\nAction');
                var innervations = section4[0].split('\n').slice(1);
                var actions = section4[1].split('\n');

                // var sections3 = sections

                var columns = [
                    'Origin'=> origins,
                    'Insertion'=> insertions,
                    'Innervation'=> innervations,
                    'Main Action'=> actions
                    // 'Rotator cuff muscle yes or no?'
                    // 'Thenar or Hyperthenar?'
                ];

                var res = [];

                for(column in columns.keys()){

                    var i = 0;
                    for(muscle in muscles){
                        var value = columns[column][i];
                        res.push('$column: $muscle, $column: $value');
                        i++;
                    }
                }
                
                speak("Here is your filled out template. :)");
                Libs.write('output.txt', res.join('\n'));
                // Sys.println(res.join('\n'));
            
            }

            if(answer == 'join sql'){
                // in future just record what tables are being joined?
                var tables_string = Libs.read('join_tables/tables.json');
                var template = Libs.read('join_tables/create_joins_template.sql');
                var data: TableData = haxe.Json.parse(tables_string);
                
                // var res = [];

                //todo replace with Haxes template system??

                var res = "";

                for(table in data.tables){
                    var filled = StringTools.replace(template, "${columns}", table.columns.join(',\n\t'));

                    // make this dynamic somehow at some point

                    filled = StringTools.replace(filled, "${table}", table.table);
                    filled = StringTools.replace(filled, "${table_schema}", table.schema);
                    filled = StringTools.replace(filled, "${table_original}", table.table_original);
                    filled = StringTools.replace(filled, "${table_original_id_column}", table.table_original_id_column);
                    filled = StringTools.replace(filled, "${granular_column}", table.granular_column);
                    filled = StringTools.replace(filled, "${new_granular_column}", table.new_granular_column);
                    filled = StringTools.replace(filled, "${columns_horizontal}", table.columns_horizontal.join(', '));


                    var columns_no_types = [];
                    for(column in table.columns){
                        columns_no_types.push(column.split(" ")[0]);
                    }

                    filled = StringTools.replace(filled, "${columns_no_types}", columns_no_types.join(', '));

                    var drop_columns = [];
                    for(column in table.columns_horizontal){
                        drop_columns.push('DROP COLUMN $column');
                    }

                    filled = StringTools.replace(filled, "${drop_columns}", drop_columns.join(',\n') + ';');
    
                    res = res + "\n" + filled;
                    
                }

                speak("Created SQL queries :)");
                Libs.write('join_tables/output.sql', "-- Start of join tables \n\n" + res);


            }


            answer = prompt();

        }

        farewell();
    }
}