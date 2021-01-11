package com.xtimers.customer.server;

import com.xtimers.customer.core.XtimersCustomerCoreConfig;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.liquibase.LiquibaseAutoConfiguration;
import org.springframework.context.annotation.Import;

@SpringBootApplication(exclude = { LiquibaseAutoConfiguration.class })
@Import({
        XtimersCustomerCoreConfig.class,
})
public class XtimersCustomerServerConfig {

}
