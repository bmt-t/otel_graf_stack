$body = @{
  resourceLogs = @(@{
    resource = @{
      attributes = @(@{
        key = "service.name"
        value = @{ stringValue = "log-tester" }
      })
    }
    scopeLogs = @(@{
      scope = @{ name = "test-logger" }
      logRecords = @(@{
        timeUnixNano = ([string]([DateTimeOffset]::Now.ToUnixTimeSeconds() * 1000000000))
        severityNumber = 9
        severityText = "INFO"
        body = @{ stringValue = "Test log from PowerShell via OTLP" }
        attributes = @(
          @{ key = "env"; value = @{ stringValue = "dev" } },
          @{ key = "team"; value = @{ stringValue = "ops" } }
        )
      })
    })
  })
} | ConvertTo-Json -Depth 10

Invoke-RestMethod -Uri "http://localhost:4318/v1/logs" -Method POST -ContentType "application/json" -Body $body
