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
public class TweetTest {
    private WebDriver driver;

    //"C://Users//sbogdanschi//IdeaProjects//HelloWorldSpring//src//main//
    @BeforeClass
    private void setUp(){
        System.setProperty("webdriver.chrome.driver", TweetTest.class.getResource("/chromedriver.exe").getFile());
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
        driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);

        driver.manage().timeouts().pageLoadTimeout(20, TimeUnit.SECONDS);
        driver.findElement(By.id("username")).sendKeys("SeleniumTestUser");
        driver.findElement(By.id("password")).sendKeys("11111111");
        driver.findElement(By.id("loginButton")).click();
        driver.manage().timeouts().pageLoadTimeout(20, TimeUnit.SECONDS);
        driver.findElement(By.id("homePageNavBar")).click();
        driver.findElement(By.id("content")).sendKeys("This is selenium test tweet. " +
                "Make sure that it will be created.");
        driver.findElement(By.id("tweetActionButton")).click();
        driver.findElement(By.id("tweetArea")).click();
        driver.findElement(By.cssSelector("a#deleteTweetLink")).click();
        driver.manage().timeouts().pageLoadTimeout(10, TimeUnit.SECONDS);
        driver.findElement(By.id("homePageNavBar")).click();
        driver.findElement(By.id("deleteProfile")).click();
    }
}
