package project2;

import org.junit.platform.suite.api.SelectClasses;
import org.junit.platform.suite.api.Suite;
import org.junit.platform.suite.api.IncludeTags;

@Suite
@SelectClasses({EvenCheckerTest.class, SimpleMathTest.class})
//You can also select tests by tags (the modern equivalent of categories)
//@IncludeTags("fast") 
public class AllTests {
 // This class remains empty.
 // The annotations on the class define the suite.
}