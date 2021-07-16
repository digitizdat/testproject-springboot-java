# Spring Boot REST tutorial example
This code came from [this tutorial](https://spring.io/guides/tutorials/rest/).

To run this code, you need to have Java and Maven installed. Then run the Maven
wrapper in the root directory like so:

    ./mvnw clean spring-boot:run

To package this code as a JAR for use in a container, use `mvnw` like so:

    ./mvnw package

This will create a file called `target/payroll-0.0.1-SNAPSHOT.jar`.


# Getting Started

### Reference Documentation
For further reference, please consider the following sections:

* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)
* [Spring Boot Maven Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/2.5.2/maven-plugin/reference/html/)
* [Create an OCI image](https://docs.spring.io/spring-boot/docs/2.5.2/maven-plugin/reference/html/#build-image)
* [Spring Web](https://docs.spring.io/spring-boot/docs/2.5.2/reference/htmlsingle/#boot-features-developing-web-applications)
* [Spring Data JPA](https://docs.spring.io/spring-boot/docs/2.5.2/reference/htmlsingle/#boot-features-jpa-and-spring-data)

### Guides
The following guides illustrate how to use some features concretely:

* [Building a RESTful Web Service](https://spring.io/guides/gs/rest-service/)
* [Serving Web Content with Spring MVC](https://spring.io/guides/gs/serving-web-content/)
* [Building REST services with Spring](https://spring.io/guides/tutorials/bookmarks/)
* [Accessing Data with JPA](https://spring.io/guides/gs/accessing-data-jpa/)


# Complete implementation
I later found that Spring actually maintains a repo full of the code for this tutorial with all the trimmings [here](https://github.com/spring-guides/tut-rest).
