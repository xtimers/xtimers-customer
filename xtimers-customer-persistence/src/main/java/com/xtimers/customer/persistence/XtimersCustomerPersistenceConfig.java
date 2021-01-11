package com.xtimers.customer.persistence;

import liquibase.integration.spring.SpringLiquibase;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.JpaVendorAdapter;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(
        basePackages = {
                "com.xtimers.customer.persistence.repositories"
        },
        entityManagerFactoryRef = "customerEMF",
        transactionManagerRef = "customerTM")
@ComponentScan
public class XtimersCustomerPersistenceConfig {

    private static final Logger logger = LoggerFactory.getLogger(XtimersCustomerPersistenceConfig.class);

    private final Environment env;

    @Autowired
    public XtimersCustomerPersistenceConfig(Environment env) {
        this.env = env;
    }

    @Bean(name = "customerTM")
    @Qualifier("customer")
    public JpaTransactionManager customerTM(
            @Qualifier("customerDS") final DataSource dataSource,
            @Qualifier("customerEMF") final EntityManagerFactory emf) {
        JpaTransactionManager transactionManager = new JpaTransactionManager();
        transactionManager.setDataSource(dataSource);
        transactionManager.setEntityManagerFactory(emf);
        return transactionManager;
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean customerEMF(
            @Qualifier("customerDS") final DataSource dataSource,
            @Qualifier("customerVA") final JpaVendorAdapter vendorAdapter) {
        LocalContainerEntityManagerFactoryBean factory = new LocalContainerEntityManagerFactoryBean();
        factory.setDataSource(dataSource);
        factory.setJpaVendorAdapter(vendorAdapter);
        factory.setPersistenceUnitName("customerPU");
        factory.setPackagesToScan(
                "com.xtimers.customer.persistence.entities"
        );
        return factory;
    }

    @Bean
    @Qualifier("customer")
    public JdbcTemplate customerJdbcTemplate(@Qualifier("customerDS") final DataSource dataSource) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate();
        jdbcTemplate.setDataSource(dataSource);
        return jdbcTemplate;
    }

    @Bean
    @ConditionalOnProperty(name = "liquibase", havingValue = "true", matchIfMissing = true)
    public SpringLiquibase customerLiquibase(@Qualifier("customerDS") final DataSource dataSource) {
        logger.info("Applying Liquibase");
        SpringLiquibase liquibase = new SpringLiquibase();
        // liquibase.setContexts(RuntimeMode.current().name());
        liquibase.setDataSource(dataSource);
        logger.info("env.containsProperty(initdb):{}", env.containsProperty("initdb"));
        if (env.containsProperty("initdb")) {
            liquibase.setDropFirst(true);
        }
        liquibase.setChangeLog("classpath:db/customer/changelog-master.xml");
        return liquibase;
    }

}
