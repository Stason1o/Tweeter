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
    public void test(){
        driver.manage().timeouts().implicitlyWait(5,TimeUnit.SECONDS);
        driver.findElement(By.id("btnRegistrationPage")).click(); // -> registration page
        driver.findElement(By.id("firstName")).sendKeys("SeleniumJohn");

        driver.findElement(By.id("lastName")).sendKeys("SeleniumSmith");
        driver.findElement(By.id("username")).sendKeys("SeleniumTestUser");
        driver.findElement(By.id("password")).sendKeys("11111111");
        driver.findElement(By.id("confirmPassword")).sendKeys("11111111");
        driver.findElement(By.id("email")).sendKeys("selenium.user@test.com");
        driver.findElement(By.id("submitRegisterOperation")).click();
        driver.manage().timeouts().pageLoadTimeout(20, TimeUnit.SECONDS);
        driver.findElement(By.id("username")).sendKeys("SeleniumTestUser");
        driver.findElement(By.id("password")).sendKeys("11111111");
        driver.findElement(By.id("loginButton")).click();
        driver.manage().timeouts().pageLoadTimeout(20, TimeUnit.SECONDS);
        if(driver.manage().window().getSize().getWidth() < 768) {
            driver.findElement(By.id("dropDownMenu")).click();
            driver.findElement(By.id("navBarDropDownMenu")).click();
            System.out.println("IN IF");
        } else {
            driver.findElement(By.id("navBarDropDownMenu")).click();
            System.out.println("IN ELSE");
        }
        driver.findElement(By.id("globalSearchPage")).click();
        driver.manage().timeouts().pageLoadTimeout(20, TimeUnit.SECONDS);
        driver.findElement(By.id("username")).sendKeys("SeleniumTestUser");
        driver.findElement(By.id("submitSearchButton")).click();
    }
}
