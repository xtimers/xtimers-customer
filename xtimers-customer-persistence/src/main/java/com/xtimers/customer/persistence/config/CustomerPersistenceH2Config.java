package com.xtimers.customer.persistence.config;

import com.zaxxer.hikari.HikariDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseBuilder;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseType;
import org.springframework.orm.jpa.vendor.Database;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

import javax.sql.DataSource;

/**
 * @author Payment Gateway Archetype
 */
@Configuration
@ConditionalOnProperty(name = "db", havingValue = "h2", matchIfMissing = true)
public class CustomerPersistenceH2Config {

    private static final Logger logger = LoggerFactory.getLogger(CustomerPersistenceH2Config.class);

    @Bean
    public DataSource customerDS() {
        logger.info("Configuring Customer Persistence with an H2 database");
        HikariDataSource dataSource = new HikariDataSource();
        dataSource.setPoolName("xtimere-customer-h2");
        dataSource.setDataSource(new EmbeddedDatabaseBuilder()
                .generateUniqueName(true)
                .setType(EmbeddedDatabaseType.H2)
                .addScript("db/h2-mysql-init.sql")
                .build());
        return dataSource;

    }

    @Bean
    public HibernateJpaVendorAdapter customerVA() {
        HibernateJpaVendorAdapter vendorAdapter = new HibernateJpaVendorAdapter();
        vendorAdapter.setDatabase(Database.H2);
        // TODO: make switchable
//        vendorAdapter.setShowSql(Switches.showSql.isEnabled());
        return vendorAdapter;
    }


}
