#!/bin/bash
#
# The reason this script exists is to build the JAR file and then explode it
# into different layers before packaging it into a Docker image with the
# Dockerfile.

#./mvnw package

# We should now have a JAR file called target/payroll-0.0.1-SNAPSHOT.jar.
mkdir -p target/dependency
(cd target/dependency && jar -xf ../payroll-0.0.1-SNAPSHOT.jar)


