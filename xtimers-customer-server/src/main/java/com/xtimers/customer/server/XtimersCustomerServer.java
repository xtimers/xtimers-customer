package com.xtimers.customer.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.PropertiesPropertySource;

import java.util.*;

public class XtimersCustomerServer {

    static {
        if (System.getProperty("logging.config") == null) {
            System.setProperty("logging.config", "classpath:xtimers-customer-server-logback.xml");
        }
    }

    private static final String SPRING_CONFIG_NAME = "spring.config.name";
    private static final String SPRING_APPLICATION_NAME = "spring.application.name";
    private static final String SPRING_JMX_DEFAULT = "spring.jmx.default";
    private static final String SPRING_JMX_ENABLED = "spring.jmx.enabled";
    private static final String APPLICATION_NAME = "xtimers-customer-server";

    private final SpringApplication springApplication;
    private final Properties overrides = new Properties();
    private ConfigurableApplicationContext context;
    private final List<String> arguments = new ArrayList<>();
    private boolean disableJmx = false;

    public XtimersCustomerServer() {
        this.springApplication = new SpringApplication(XtimersCustomerServerConfig.class);
        springApplication.addInitializers(applicationContext -> applicationContext
                .getEnvironment()
                .getPropertySources()
                .addFirst(new PropertiesPropertySource("overrides", overrides)));
    }

    public XtimersCustomerServer start() {
        initializeSystemProperties();
        String[] args = new String[arguments.size()];
        args = arguments.toArray(args);
        this.context = springApplication.run(args);
        clearSystemProperties();
        return this;
    }

    public XtimersCustomerServer stop() {
        context.close();
        return this;
    }

    private void initializeSystemProperties() {
        System.setProperty(SPRING_CONFIG_NAME, APPLICATION_NAME);
        System.setProperty(SPRING_APPLICATION_NAME, APPLICATION_NAME);
        System.setProperty(SPRING_JMX_DEFAULT, APPLICATION_NAME);
        if (disableJmx) {
            System.setProperty(SPRING_JMX_ENABLED, "false");
        }
    }

    private void clearSystemProperties() {
        System.clearProperty(SPRING_CONFIG_NAME);
        System.clearProperty(SPRING_APPLICATION_NAME);
        System.clearProperty(SPRING_JMX_DEFAULT);
        if (disableJmx) {
            System.clearProperty(SPRING_JMX_ENABLED);
        }
    }

    public XtimersCustomerServer disableJmx() {
        this.disableJmx = true;
        return this;
    }

    public XtimersCustomerServer withArguments(String... args) {
        arguments.addAll(Arrays.asList(args));
        return this;
    }

    public XtimersCustomerServer withProperty(String key, String value) {
        this.overrides.setProperty(key, value);
        return this;
    }

    public XtimersCustomerServer withRandomPort() {
        return withProperty("server.port", "0");
    }

    public Optional<ApplicationContext> getContext() {
        return Optional.ofNullable(context);
    }

    public static void main(String[] args) {
        new XtimersCustomerServer().withArguments(args).start();
    }

    public int getServerPort() {
        Integer serverPort = context.getEnvironment().getProperty("local.server.port", Integer.class);
        if (serverPort == null) {
            throw new RuntimeException("Server not started!");
        }
        return serverPort;
    }
}
