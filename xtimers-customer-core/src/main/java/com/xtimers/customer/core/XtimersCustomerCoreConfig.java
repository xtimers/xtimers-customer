package com.xtimers.customer.core;

import com.xtimers.customer.persistence.XtimersCustomerPersistenceConfig;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@Import({
//        CustomerVendorClientConfig.class,
        XtimersCustomerPersistenceConfig.class,
})
@ComponentScan
public class XtimersCustomerCoreConfig {


}