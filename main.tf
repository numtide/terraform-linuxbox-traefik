resource "linuxbox_docker_container" "traefik" {

  ssh_key      = var.ssh_key
  host_address = var.ssh_host_address

  image_id = var.traefik_image
  ports = [
    "80:80",
    "443:443",
  ]

  volumes = [
    "/var/run/docker.sock:/var/run/docker.sock",
    "${var.certs_directory}:/certs",
  ]

  restart = "always"

  network = var.docker_network

  labels = var.labels

  args = concat([
    "--accesslog=true",
    "--entrypoints.web.address=:80",
    "--entrypoints.websecure.address=:443",
    "--certificatesresolvers.tlsresolver.acme.email=${var.cert_email}",
    "--certificatesresolvers.tlsresolver.acme.storage=/certs/acme.json",
    "--certificatesresolvers.tlsresolver.acme.httpchallenge.entrypoint=web",

    # use docker contaner labels to configure routers and middlewares
    "--providers.docker",
    "--providers.docker.watch",
    "--providers.docker.exposedbydefault=false",

    # enable prometheus metrics
    "--metrics.prometheus=true",
    ],
    var.redirect_http_to_https ? [
      "--entrypoints.web.http.redirections.entryPoint.to=websecure",
      "--entrypoints.web.http.redirections.entryPoint.scheme=https",
    ] : [],
  )


  name = var.container_name

  log_driver = var.log_driver
  log_opts   = var.log_opts

  memory = var.memory
}
