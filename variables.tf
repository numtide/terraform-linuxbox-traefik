variable "ssh_host_address" {
  type        = string
  description = "Hostname (or IP address of a host) with a running Docker instance where the traefik container is going to be installed."
}

variable "ssh_username" {
  type        = string
  description = "Username used to log in to the ssh host and run Docker commands, defaults to root."
  default     = "root"
}

variable "ssh_key" {
  type        = string
  description = "Private key used to authenticate SSH connection."
}

variable "certs_directory" {
  type        = string
  description = "Directory on the host where the ACME cert information will be stored. This directory will be mounted as a volume in the traefik container."
}

variable "cert_email" {
  type        = string
  description = "Email address for the ACME TLS certificates."
}

variable "redirect_http_to_https" {
  type        = bool
  description = "When set to true (default), will automatically redirect all HTTP request to HTTPS"
  default     = true
}

variable "docker_network" {
  type        = string
  description = "Docker network to attach the container to."
  default     = "bridge"
}

variable "labels" {
  type        = map(string)
  description = "Labels for the Docker container"
  default     = {}
}

variable "container_name" {
  type        = string
  description = "Name of the created container"
  default     = "linuxbox-traefik"
}

variable "log-driver" {
  type        = string
  description = "Log driver to use for the Docker container."
  default     = null
}

variable "log-opts" {
  type        = map(string)
  description = "Log driver options for the Docker log driver."
  default     = null
}

variable "traefik_image" {
  type        = string
  description = "Docker image name/tag for the traefik container, you can use this value to install newer version of the image, or to run a custom image."
  default     = "traefik:v2.2.8"
}

variable "memory" {
  type        = number
  description = "Memory limit for the Docker container. Default is set to a sane value, but can be overriden."
  default     = 25 * 1024 * 1024
}