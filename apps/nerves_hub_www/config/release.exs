import Config

logger_level = System.get_env("LOG_LEVEL", "warn") |> String.to_atom()

config :logger, level: logger_level

host = System.fetch_env!("HOST")
port = System.get_env("PORT", "80") |> String.to_integer()

config :nerves_hub_web_core, NervesHubWeb.ClusterSupervisor,
  api_servers: [
    strategy: Cluster.Strategy.Kubernetes,
    config: [
      kubernetes_ip_lookup_mode: :pods,
      kubernetes_node_basename: "nerves_hub_api",
      kubernetes_selector: "app=nerves-hub-api",
      kubernetes_namespace: "nh",
      polling_interval: 10_000]
  ],
  device_servers: [
    strategy: Cluster.Strategy.Kubernetes,
    config: [
      kubernetes_ip_lookup_mode: :pods,
      kubernetes_node_basename: "nerves_hub_device",
      kubernetes_selector: "app=nerves-hub-device",
      kubernetes_namespace: "nh",
      polling_interval: 10_000]
  ]

if rollbar_access_token = System.get_env("ROLLBAR_ACCESS_TOKEN") do
  config :rollbax, access_token: rollbar_access_token
else
  config :rollbax, enabled: false
end

config :nerves_hub_web_core, NervesHubWebCore.Firmwares.Upload.S3,
  bucket: System.fetch_env!("S3_BUCKET_NAME")

config :nerves_hub_web_core, NervesHubWebCore.Workers.FirmwaresTransferS3Ingress,
  bucket: System.fetch_env!("S3_LOG_BUCKET_NAME")

config :ex_aws, region: System.fetch_env!("AWS_REGION")

if System.get_env("S3_SCHEME") != nil do
  config :ex_aws, :s3,
    scheme: System.fetch_env!("S3_SCHEME") <> "://",
    host: System.fetch_env!("S3_HOST"),
    port: System.fetch_env!("S3_PORT")
end

config :nerves_hub_www, NervesHubWWWWeb.Endpoint,
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE"),
  live_view: [signing_salt: System.fetch_env!("LIVE_VIEW_SIGNING_SALT")]

config :nerves_hub_web_core, NervesHubWebCore.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: System.fetch_env!("SES_SERVER"),
  port: System.fetch_env!("SES_PORT"),
  username: System.fetch_env!("SMTP_USERNAME"),
  password: System.fetch_env!("SMTP_PASSWORD")

config :nerves_hub_web_core,
  host: host,
  port: port,
  from_email: System.get_env("FROM_EMAIL", "no-reply@nerves-hub.org"),
  allow_signups?: System.get_env("ALLOW_SIGNUPS", "true") |> String.to_atom()

config :nerves_hub_www, NervesHubWWWWeb.Endpoint, url: [host: host, port: port]
