FROM openjdk:16-jdk-slim
RUN addgroup --system spring && adduser --system spring --ingroup spring
USER spring:spring
ARG DEPENDENCY=target/dependency
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","org.mcgreal.payroll.PayrollApplication"]
