package seleniumTests;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.util.concurrent.TimeUnit;

/**
 * Created by sbogdanschi on 17/05/2017.
 */
public class UserTest {

    private WebDriver driver;

    @BeforeClass
    private void setUp(){
        System.setProperty("webdriver.chrome.driver", UserTest.class.getResource("/chromedriver.exe").getFile());
        driver = new ChromeDriver();
    }

    @AfterClass
    private void tearDown(){
        driver.quit();
    }

    @BeforeMethod
    public void openHomePage(){
        driver.get("http://localhost:8080/");
    }

    @Test
    public void test() throws InterruptedException {
        driver.manage().timeouts().implicitlyWait(5,TimeUnit.SECONDS);
        driver.findElement(By.id("btnRegistrationPage")).click(); // -> registration page
        driver.findElement(By.id("firstName")).sendKeys("SeleniumJohn");// enter first name
        driver.findElement(By.id("lastName")).sendKeys("SeleniumSmith");// enter last name
        driver.findElement(By.id("username")).sendKeys("SeleniumTestUser");// enter username name
        driver.findElement(By.id("password")).sendKeys("11111111");// enter password
        driver.findElement(By.id("confirmPassword")).sendKeys("11111111");// confirm password
        driver.findElement(By.id("email")).sendKeys("selenium.user@test.com");// enter email

        Thread.sleep(2000);

        driver.findElement(By.id("submitRegisterOperation")).click();// chick on submit button
        driver.manage().timeouts().pageLoadTimeout(20, TimeUnit.SECONDS);
        driver.findElement(By.id("username")).sendKeys("SeleniumTestUser");//enter username
        driver.findElement(By.id("password")).sendKeys("11111111");//enter password

        Thread.sleep(2000);

        driver.findElement(By.id("loginButton")).click();//click on submit button
        driver.manage().timeouts().pageLoadTimeout(20, TimeUnit.SECONDS);
        if(driver.manage().window().getSize().getWidth() < 768) { // if size of window < 768
            driver.findElement(By.id("dropDownMenu")).click();
            driver.findElement(By.id("navBarDropDownMenu")).click();
            System.out.println("IN IF");
        } else {
            Thread.sleep(1000);
            driver.findElement(By.id("navBarDropDownMenu")).click();// click on nav bar dropdown
            System.out.println("IN ELSE");
        }
        driver.findElement(By.id("globalSearchPage")).click(); //go to global search page
        driver.manage().timeouts().pageLoadTimeout(20, TimeUnit.SECONDS);
        driver.findElement(By.id("username")).sendKeys("SeleniumTestUser");// enter username in search field
        Thread.sleep(2000);
        driver.findElement(By.id("submitSearchButton")).click();// click submit button

        // TWEET CREATION TEST
        driver.findElement(By.id("homePageNavBar")).click(); //go to home page
        driver.findElement(By.id("content")).sendKeys("This is selenium test tweet. " +
                "Make sure that it will be created."); // enter tweet
        Thread.sleep(2000);
        driver.findElement(By.id("tweetActionButton")).click(); // create new tweet
        Thread.sleep(2000);
        driver.findElement(By.id("tweetArea")).click(); //click on tweet
        Thread.sleep(2000);
        driver.findElement(By.cssSelector("a#deleteTweetLink")).click(); // delete tweet
        driver.manage().timeouts().pageLoadTimeout(10, TimeUnit.SECONDS);
        driver.findElement(By.id("homePageNavBar")).click(); // click to user profile page
        Thread.sleep(2000);
        driver.findElement(By.id("deleteProfile")).click(); // delete user
    }
}
