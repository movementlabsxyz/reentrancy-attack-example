// Import necessary libraries
import "forge-std/Test.sol";
import "../src/Points.sol";
import "../src/Attacker.sol";

// Define the test contract
contract ReentrancyTest is Test {
    Points public points;
    Attacker public attacker;

    // Deploy the contracts before running the tests
   /* function setUp() public {
        points = new Points();
        attacker = new Attacker(address(points));
    }

    // Test the reentrancy attack
    function testReentrancyAttack() public {
        // Initial balance of the attacker
        uint initialBalance = points.balances(address(attacker));

        // Trigger the reentrancy attack
        attacker.attack();

        // Final balance of the attacker after the attack
        uint finalBalance = points.balances(address(attacker));

       // Verify that the attacker's balance increased
        assert(finalBalance > initialBalance);

        // Verify that the Points contract balance is zero
        assert(points.balances(address(points)) == 0);

    }*/
}
