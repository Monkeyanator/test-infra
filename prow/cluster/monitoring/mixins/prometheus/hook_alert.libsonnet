{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'abnormal webhook behaviors',
        rules: [
          {
            alert: 'no-webhook-calls',
            // Monday-Friday 9:00-17:00 PDT = (7 hours different) 16:00-24:00  (in UTC)
            expr: |||
              (sum(increase(prow_webhook_counter[1m])) == 0 or absent(prow_webhook_counter))
              and ((day_of_week() > 0) and (day_of_week() < 6) and (hour() >= 16))
            |||,
            'for': '30m',
            labels: {
              severity: 'slack',
            },
            annotations: {
              message: 'There have been no webhook calls on working hours for 30 minutes',
            },
          },
        ],
      },
    ],
  },
}
