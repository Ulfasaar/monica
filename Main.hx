

// // consider doing a golang like thing for join tables
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

    // static function chat(){
    //     var question_response_mapping = {};
    //     // maps questions to responses for fun chats eg: how are you etc
    // }

    // static function query_db(){
    //     // query db multiple times with one connection
    //     // use config files to store the connection details
    //     // command would be query blah connection
    //     // use the word close to close the connection to return to the main prompt
    //     // append the db connection prompt to show still connected
    // }

    // static function fill_template(){
    //     // read a JSON config file 
    //     // read in a template file 
    //     // fill the values 
    //     // spit out the result
    // }

    // static function hide(){
    //     // encrypt the thing using existing pkey or create new ones each time?
    //     // used for managing secrets
    // }

    // todo add stuff for managing shared libraries and meta repos

    // todo unit tests!!!! BDD etc
    // to do integration tests decouple from command inputs

    // static function show(){
    //     // unencrypt
    // }

    // static function find(){
    //     // finds text in a folder using silver searcher or whatever
    //     // if it finds something and its encrypted and it has the primary key decrypt it
    // }

    static function generate_random_json_blobs(){
        // generates a n list of json blobs with different keys
        // configurable fields num fields etc
        return "{'cat': 'dog', 'pet': 'true'}, {'cat': 'mouse', 'pet': 'true'},  {'cat': 'moose', 'pet': 'false'}";
    }

    static function read(path: String): String{

        // todo handle other file types eg: docx etc
        return sys.io.File.getContent(path);
    }


    static function write(path: String, data: String){
        sys.io.File.saveContent(path, data);
    }

    static function remember(content: String){

        // ! Bug it should store stuff with keys so that it can remember multiple things
        // only writes to memory once for now
        var memory = read('memory.txt');

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

        var content:String = read('banner.txt');

        // keep this way for now so that when she talks she doesn't blurt out special characters
        Sys.println(content);
    }

    static function speak(message: String){
        Sys.println(message);


        // todo on setup install espeak find a way to make it work for windows etc
        // todo fix speech so that it doesn't talk over itself and actually says good bye
        // todo fix it so that it doesn't print trash to terminal
        // todo make the voice sound nicer and less like a low quality Steven Hawking, preferrably female voice

        // to fix talking over self just lock execution somehow until first speech done
        // maybe process has a way to handle it????

        // espeak-ng provides more osses so might be a good cross platform way still sounds really robotic though
        // new sys.io.Process('espeak "$message"');
        // FREE TTS isn't much better not sure about Googles option maybe use Google if there is internet else fall back to local
    }

    static function run(command: String){
        Sys.command(command);
    }

    static function farewell(){
        speak('Good bye! :)');
    }

    static public function main() {

        print_header();

        var memory = read('memory.txt');

        if(memory == ''){
            speak("Hello I am Monica your personal digital assistant!\n");
            var name = ask('What is your name?');
            remember(name);
        } else{
            speak('Hello $memory!');
        }

        var answer = ask('How may I help you today? ');

        while(answer != 'bye'){

            // todo make the app folder configurable


            // todo setup autocomplete for commands and argument values eg app image names

            // todo find a way to create the memory file on startup if not present

            // todo path expansion

            // todo environment setup based on config and versions

            // todo make a Github need to decide if public or private might make public to show off



            // support pip packages global npm packages maybe profiles common tools etc
            // multiple os es

            if(answer.substring(0,4) == 'open'){
                
                // ! bug: Currently for rambox if it isnt already open monica freezes after it is opened
                var path = '/home/ryan/apps/' + answer.substr(5) + '.AppImage';
                speak('opening ' + path);

                // run the app and continue prompting
                run(path);
            }

            if(answer == 'generate random'){
                speak('Heres your pile of random dicts.');
                Sys.println(generate_random_json_blobs());
            }

            if(answer == 'thank you'){
                speak('No worries.');
            }
            if(answer == 'muscles'){
                var muscles = read('muscles.txt').split('\n');
                
                var columns = [
                    // 'Origin',
                    // 'Insertion',
                    'Main Action',
                    'Thenar or Hyperthenar?'
                ];

                var res = [];

                for(column in columns){
                    for(muscle in muscles){
                        res.push('$column: $muscle, $column: ');
                    }
                }
                
                speak("Here is your filled out template. :)");
                Sys.println(res.join('\n'));
            
            }

            if(answer == 'join sql'){
                // in future just record what tables are being joined?
                var tables_string = read('join_tables/tables.json');
                var template = read('join_tables/create_joins_template.sql');
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
                write('join_tables/output.sql', res);


            }

                // "columns": [
            //     "process text",
            //     "processing_type text"
            // ],
            // "table": "distribution",
            // "table_schema": "asset",
            // "columns_horizontal": [
            //     "mining_techniques", "mining_type"
            // ],
            // "table_original": "asset.metadata",
            // "table_original_id_column": "asset_id",
            // "granular_column": "mining_techniques",
            // "new_granular_column": "process"
            // }

            answer = prompt();

        }

        farewell();
    }
}