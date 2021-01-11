package com.xtimers.customer.persistence.config;

import com.zaxxer.hikari.HikariDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.orm.jpa.vendor.Database;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

/**
 * @author Payment Gateway Archetype
 */
@Configuration
@ConditionalOnProperty(name = "db", havingValue = "mysql")

public class CustomerPersistenceMySQLConfig {

    private static final Logger logger = LoggerFactory.getLogger(CustomerPersistenceMySQLConfig.class);

    private final Environment env;

    @Autowired
    public CustomerPersistenceMySQLConfig(Environment env) {
        this.env = env;
    }


    @Bean
    public HikariDataSource customerDS() {
        HikariDataSource hikariDataSource = new HikariDataSource();

        hikariDataSource.setPoolName("xtimere-customer-mysql");
        logger.info("Configuring Customer Persistence with a MySQL database");
        hikariDataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        hikariDataSource.setJdbcUrl(env.getRequiredProperty("xtimers-customer.db.mysql.url"));
        hikariDataSource.setUsername(env.getRequiredProperty("xtimers-customer.db.mysql.user"));
        hikariDataSource.setPassword(env.getRequiredProperty("xtimers-customer.db.mysql.password"));
        if (env.containsProperty("xtimers-customer.db.mysql.pool.maximumPoolSize")) {
            hikariDataSource.setMaximumPoolSize(env.getProperty("xtimers-customer.db.mysql.pool.maximumPoolSize", Integer.class));
        }
        if (env.containsProperty("xtimers-customer.db.mysql.pool.connectionTimeout")) {
            hikariDataSource.setConnectionTimeout(env.getProperty("xtimers-customer.db.mysql.pool.connectionTimeout", Long.class));
        }
        if (env.containsProperty("xtimers-customer.db.mysql.pool.maxLifetime")) {
            hikariDataSource.setMaxLifetime(env.getProperty("xtimers-customer.db.mysql.pool.maxLifetime", Long.class));
        }
        if (env.containsProperty("xtimers-customer.db.mysql.pool.idleTimeout")) {
            hikariDataSource.setIdleTimeout(env.getProperty("xtimers-customer.db.mysql.pool.idleTimeout", Long.class));
        }
        return hikariDataSource;
    }

    @Bean
    public HibernateJpaVendorAdapter customerVA() {
        HibernateJpaVendorAdapter vendorAdapter = new HibernateJpaVendorAdapter();
        vendorAdapter.setDatabase(Database.MYSQL);
        // TODO: make switchable
//        vendorAdapter.setShowSql(Switches.showSql.isEnabled());
        return vendorAdapter;
    }

}
