
class MyTestCase extends haxe.unit.TestCase {
    public function testBasic() {
        
        assertEquals("A", "A");
    }
}


class Tests{
    public static function main(){
        var r = new haxe.unit.TestRunner();
        r.add(new MyTestCase());
        // add other TestCases here

        // finally, run the tests
        r.run();
    }
}