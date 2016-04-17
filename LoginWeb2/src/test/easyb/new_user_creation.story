import ohtu.*
import ohtu.authentication.*
import org.openqa.selenium.*
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

description """A new user account can be created 
              if a proper unused username 
              and a proper password are given"""

scenario "creation successfully with correct username and password", {
    given 'command new user is selected', {
        driver = new FirefoxDriver();
        driver.get("http://localhost:8090");
        element = driver.findElement(By.linkText("register new user"));       
        element.click(); 
    }
 
    when 'a valid username and password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("kuha123");
        element = driver.findElement(By.name("password"));
        element.sendKeys("nakki123");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("nakki123");
        element = driver.findElement(By.name("add"));
        element.submit();
    }

    then 'new user is registered to system', {
        driver.getPageSource().contains("Welcome to Ohtu App!").shouldBe true
    }
}

scenario "can login with successfully generated account", {
    given 'command new user is selected', {
        driver = new FirefoxDriver();
        driver.get("http://localhost:8090");
        element = driver.findElement(By.linkText("register new user"));       
        element.click(); 
    }
 
    when 'a valid username and password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("kuha321");
        element = driver.findElement(By.name("password"));
        element.sendKeys("nakki123");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("nakki123");
        element = driver.findElement(By.name("add"));
        element.submit();
        
        element = driver.findElement(By.linkText("continue to application mainpage"));
        element.click();
        element = driver.findElement(By.linkText("logout"));
        element.click();
        
    }

    then  'new credentials allow logging in to system', {
        element = driver.findElement(By.linkText("login"));
        element.click();
        
        element = driver.findElement(By.name("username"));
        element.sendKeys("kuha321");
        element = driver.findElement(By.name("password"));
        element.sendKeys("nakki123");
        element = driver.findElement(By.name("login"));
        element.submit();
        driver.getPageSource().contains("Welcome to Ohtu Application!").shouldBe true
    }
}

scenario "creation fails with correct username and too short password", {
    given 'command new user is selected', {
        driver = new FirefoxDriver();
        driver.get("http://localhost:8090");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();
    }
    when 'a valid username and too short password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("kuha234");
        element = driver.findElement(By.name("password"));
        element.sendKeys("nakki1");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("nakki1");
        element = driver.findElement(By.name("add"));
        element.submit();
    }
    then 'new user is not be registered to system', {
        driver.getPageSource().contains("Create username and give password").shouldBe true
        driver.getPageSource().contains("length greater or equal to 8").shouldBe true
        driver.getPageSource().contains("Welcome to Ohtu App").shouldBe false
    }
}

scenario "creation fails with correct username and pasword consisting of letters", {
    given 'command new user is selected', {
        driver = new FirefoxDriver();
        driver.get("http://localhost:8090");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();
    }
    when 'a valid username and password consisting of letters are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("kuha345");
        element = driver.findElement(By.name("password"));
        element.sendKeys("nakkikuha");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("nakkikuha");
        element = driver.findElement(By.name("add"));
        element.submit();
    }
    then 'new user is not be registered to system', {
        driver.getPageSource().contains("Create username and give password").shouldBe true
        driver.getPageSource().contains("must contain one character that is not a letter").shouldBe true
        driver.getPageSource().contains("Welcome to Ohtu App").shouldBe false
    }
}

scenario "creation fails with too short username and valid pasword", {
    given 'command new user is selected', {
        driver = new FirefoxDriver();
        driver.get("http://localhost:8090");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();
    }
    when 'a too sort username and valid password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("kuha");
        element = driver.findElement(By.name("password"));
        element.sendKeys("nakki123");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("nakki123");
        element = driver.findElement(By.name("add"));
        element.submit();
    }
    then 'new user is not be registered to system', {
        driver.getPageSource().contains("Create username and give password").shouldBe true
        driver.getPageSource().contains("length 5-10").shouldBe true
        driver.getPageSource().contains("Welcome to Ohtu App").shouldBe false
    }
}

scenario "creation fails with already taken username and valid password", {
    given 'command new user is selected', {
        driver = new FirefoxDriver();
        driver.get("http://localhost:8090");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();
    }
    when 'a already taken username and valid password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("kuha123");
        element = driver.findElement(By.name("password"));
        element.sendKeys("nakki123");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("nakki123");
        element = driver.findElement(By.name("add"));
        element.submit();
    }
    then 'new user is not be registered to system', {
        driver.getPageSource().contains("Create username and give password").shouldBe true
        driver.getPageSource().contains("username or password invalid").shouldBe true
        driver.getPageSource().contains("Welcome to Ohtu App").shouldBe false
    }
}

scenario "can not login with account that is not successfully created", {
    given 'command new user is selected', {
        driver = new FirefoxDriver();
        driver.get("http://localhost:8090");
        element = driver.findElement(By.linkText("register new user"));       
        element.click();
    }
    when 'a invalid username/password are entered', {
        element = driver.findElement(By.name("username"));
        element.sendKeys("kuha");
        element = driver.findElement(By.name("password"));
        element.sendKeys("nakki");
        element = driver.findElement(By.name("passwordConfirmation"));
        element.sendKeys("nakki");
        element = driver.findElement(By.name("add"));
        element.submit();
        
        element = driver.findElement(By.linkText("back to home"));       
        element.click();
        
    }
    then  'new credentials do not allow logging in to system', {
        element = driver.findElement(By.linkText("login"));       
        element.click();
        
        element = driver.findElement(By.name("username"));
        element.sendKeys("kuha");
        element = driver.findElement(By.name("password"));
        element.sendKeys("nakki");
        element = driver.findElement(By.name("login"));
        element.submit();

        driver.getPageSource().contains("wrong username or password").shouldBe true
    }
}