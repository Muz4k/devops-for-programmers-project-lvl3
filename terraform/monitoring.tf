resource "datadog_monitor" "healthcheck" {
  name    = "Alert ! {{ host.name }}"
  type    = "service check"
  message = " @muz4k.oo@gmail.com"

  query = "\"http.can_connect\".over(\"instance:app_health_check\",\"url:http://localhost:1337\").by(\"host\",\"instance\",\"url\").last(2).count_by_status()"
}
