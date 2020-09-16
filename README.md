# Linuxbox Traefik Module

This module creates a [Traefik](https://docs.traefik.io/) ingress container.
Traefik is configured to pick up routing rules from the Docker container labels, and will infer the host names for the ACME TLS Certificate from those.


## Exposing a service using Traefik.
In order to create a service in Traefik, following labels must be present:

| Name | Value | Description |
|------|-------|-------------|
| `traefik.enable` | `true`| Tells Traefik to enable service to this container |
| `traefik.http.services.<service_name>.loadbalancer.server.port` | `80` | Container port to which the service will be routed |
| `traefik.http.routers.<service_name>.rule` | <code>Host(&grave;&lt;hostname&gt;&grave;) &amp;&amp; PathPrefix(&grave;/&grave;) </code> | Defines which hostname and path prefix will be routed to the service. NOTE: please read Traefic doc on precedence or rules |
| `traefik.http.routers.<service_name>.tls.certresolver` | `module.traefik.certificate_resolver_name` | Defines which certificate resolver should be used to provide a TLS certificate for the route. This module will return it's resolver name in the output `certificate_resolver_name`
