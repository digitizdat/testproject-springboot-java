package org.mcgreal.payroll;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
class HealthCheckController {

  @GetMapping("/health")
  public String healthCheck() {
    return "OK";
  }
}
