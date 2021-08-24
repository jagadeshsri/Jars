SET 'pipeline.name' = 'SqlJob-KafkaToUpsertKafka';

CREATE TABLE rawdata(
        `META_Key` STRING,`Value` INT,`Timestamp` BIGINT)
        WITH(
        'connector' = 'kafka',
        'topic' = '4b77b1f3bb3842d7a909458c3f006f6d',
        'properties.bootstrap.servers' = '192.168.1.70:9092',
        'properties.group.id' = 'test-1',
        'scan.startup.mode' = 'earliest-offset',
        'format' = 'json');

CREATE TABLE sink(
        `META_Key` STRING,`Sum` INT,PRIMARY KEY(`META_Key`) NOT ENFORCED)
        WITH
        (
        'connector' = 'upsert-kafka',
        'topic' = 'test-1',
        'properties.bootstrap.servers' = '192.168.1.70:9092',
        'properties.group.id' = 'testProduce1',
        'value.format' = 'json',
        'key.format' = 'json'
        );

CREATE TABLE sinkdata(
        `META_Key` STRING,`Sum` INT,PRIMARY KEY(`META_Key`) NOT ENFORCED)
        WITH(
        'connector' = 'jdbc',
        'url' = 'jdbc:postgresql://192.168.1.70:5432/postgres?user=postgres&password=postgres',
        'table-name' = 'Test');

INSERT INTO sinkdata
        SELECT `META_Key`,sum(`Value`)
        FROM rawdata
        GROUP BY `META_Key`;

SET 'pipeline.name' = 'SqlJob-KafkaToJdbc';

INSERT INTO sink
        SELECT `META_Key`,sum(`Value`)
        FROM rawdata
        GROUP BY `META_Key`;
