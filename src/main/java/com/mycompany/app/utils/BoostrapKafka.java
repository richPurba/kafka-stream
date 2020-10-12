package com.mycompany.app.utils;

import org.apache.kafka.clients.consumer.ConsumerConfig;


import java.util.Properties;

import org.apache.kafka.streams.StreamsConfig;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;

public class BoostrapKafka {
    private static final Logger log = LoggerFactory.getLogger(BoostrapKafka.class);
    public static final String DEFAULT_BOOTSTRAP_SERVERS = "localhost:9092";
    public static final String DEFAULT_SCHEMA_REGISTRY_URL = "http://localhost:8081";

    public static Properties baseStreamsConfig(final String bootStrapServers,
                                              final String stateDir,
                                              final String appId,
                                              final Properties defaultConfig){
        return baseStreamsConfig(bootStrapServers, stateDir, appId, false, defaultConfig);
    }

    public static Properties baseStreamsConfig(final String bootStrapServers,
                                               final String stateDir,
                                               final String appId,
                                               final boolean enableEOS,
                                               final Properties defaultConfig){
        final Properties config = new Properties();
        config.putAll(defaultConfig);
        config.put(StreamsConfig.APPLICATION_ID_CONFIG, appId);
        config.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, bootStrapServers);
        config.put(StreamsConfig.STATE_DIR_CONFIG, stateDir);
        config.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest"); // TODO. See this config
        config.put(StreamsConfig.COMMIT_INTERVAL_MS_CONFIG, 1); // in ms
        config.put(StreamsConfig.consumerPrefix(ConsumerConfig.SESSION_TIMEOUT_MS_CONFIG), 30000);

        return config;
    }
}
