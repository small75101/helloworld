package com.small.helloworld;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

@SpringBootApplication
@RestController
public class HelloworldApplication extends SpringBootServletInitializer {

    public static void main(String[] args) throws IOException {
        Properties properties = new Properties();
        InputStream in = HelloworldApplication.class.getClassLoader().getResourceAsStream("application.properties");
        properties.load(in);
        SpringApplication app = new SpringApplication(HelloworldApplication.class);
        app.setDefaultProperties(properties);
        app.run(args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        // TODO Auto-generated method stub
        builder.sources(this.getClass());
        return super.configure(builder);
    }

    @GetMapping("/hello")
    public Object say(String who) {
        return "hello " + (StringUtils.isEmpty(who) ? "world" : who);
    }

}
