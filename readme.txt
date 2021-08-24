To add built custom flink-connector-jdbc jar to jdbc sink project, 
    Run => mvn install:install-file -Dfile=flink-connector-jdbc-machdatum-1.0.jar -DgroupId=com.machdatum -DartifactId=flink-connector-jdbc -Dversion=1.0 -Dpackaging=jar
    
Then add dependecy in pom.xml as follows,
    <dependency>
            <groupId>com.machdatum</groupId>
            <artifactId>flink-connector-jdbc</artifactId>
            <version>1.0</version>
        </dependency>
    
