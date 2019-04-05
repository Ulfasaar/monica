// typedef Values = {

// }



// typedef ListValue = {
//     var name: String;
//     var values: Array<String>;
//     var alterations: Alterations;
// }


// class TemplateTest extends haxe.unit.TestCase {
//     public function testBasic() {
        

//         // the below would be ideal for now just make some test files in the directory ugh
//         // var test_template = "all the ${object_type} ${objects}, ${objects[altered]}";

//         // var template = new Template(test_template);

//         // var values = '
//         //     "values": [
//         //         {
//         //             "object_type": {

//         //             }
//         //         }
//         //     ]
//         // ';
//         // template should be the template string itself with a function that can create a template from a txt file



//         // var template = new Template("test_pets");
//         // var expected = "all the pets Thom, Jerry, Pat, Neo-Thom, Neo-Jerry, Neo-Pat";
//         // // var actual = template.get_filled();
//         // template.get_filled();

//         // var actual = Libs.read('template_filler/outputs/test_pets');

//         // assertEquals(expected, actual);


//         // var pet_vals: Map<String, > = Libs.get_json_file("template_filler/values/test_pets.json");
//         // Sys.println(pet_vals.keys());

//         // var vals: Map<String, Dynamic> = [
//         //     "thing" => "other",
//         //     "hey" => [
//         //         "thing" => "thing",
//         //         "I" => "want",
//         //         // this might be why the JSON is broken?????
//         //         // "something" => [
//         //         //     "else" => "to get me through this semi charmed kind of life baby!"
//         //         // ]
//         //     ]
//         // ];

//         // var vals: Map<String, Dynamic> = [
//         //     "objects" => [
//         //         "type" => "list",
//         //         "values" => [
//         //             "Thom",
//         //             "Jerry",
//         //             "Pat",
//         //             "Thom"
//         //         ],
//         //         "alterations" => [
//         //             "prefix" => "Neo-"
//         //         ]
//         //     ]
//         // ];


//         var vals: Map


//             {
//                 "strings":[
//                     {
//                         "name": "",
//                         "value": ""
//                     },
//                 ],
//                 "lists":[
//                     {
//                         "name": "",
//                         "values": [

//                         ]
//                     }
//                 ]
//             }

//         Sys.println(vals.keys());

//         var test = [
//             "val" => ["hehe" => "another"]
//         ];

//         var test2 = [
//             "val" => ["hehe" => "another"]
//         ];

//         assertEquals(test["val"]["hehe"], test2["val"]["hehe"]); 
//     }
// }


// class Tests{
//     public static function main(){
//         var r = new haxe.unit.TestRunner();
//         r.add(new TemplateTest());
//         // add other TestCases here

//         // finally, run the tests
//         r.run();
//     }
// }