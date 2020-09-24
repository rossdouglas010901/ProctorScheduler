package com.oultoncollege.e2e;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

/**
 * Initially generated by Selenium IDE, see: 
 *   /src/test/resources/Selenium/ProctorScheduler.side
 *   
 * @since 2020-01-08
 * @author JooHyung
 * @author bcopeland
 */
public class ProctorSchedulingTest {
    
  private WebDriver driver;
  JavascriptExecutor js;
  private final String BASE_URL = "http://localhost:8080/ProctorScheduler";
  private final String LOGIN_PAGE = "/login.jsp";
  
//@BeforeEach
  @Before
  public void setUp() {
//    System.setProperty("webdriver.chrome.driver", "C:\\APPS\\TestAutomation\\Selenium\\WebDrivers\\chromedriver_win32\\chromedriver.exe");
//    driver = new ChromeDriver();
      System.setProperty("webdriver.gecko.driver", "C:\\APPS\\TestAutomation\\Selenium\\WebDrivers\\FireFox\\geckodriver-v0.26.0-win64\\geckodriver.exe");
      driver = new FirefoxDriver();
      js = (JavascriptExecutor) driver;
  }
  
  @After
  public void tearDown() {
    driver.quit();
  }
  
  @Test
  @Ignore
  public void loginTest() {
    driver.get(BASE_URL+LOGIN_PAGE);
    driver.manage().window().setSize(new Dimension(1550, 838));
    driver.findElement(By.name("email")).sendKeys(Keys.DOWN);
    driver.findElement(By.name("email")).sendKeys("test@example.com");
    driver.findElement(By.name("password")).click();
    driver.findElement(By.name("password")).sendKeys("Test123");
    driver.findElement(By.cssSelector(".submit")).click();
  }
}
