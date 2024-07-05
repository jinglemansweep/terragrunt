include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules//cloudflare/access/application"
}

dependency "zone_net_ptre" {
  config_path = "../../dns/net_ptre"
}

inputs = {
  zone = dependency.zone_net_ptre.outputs.zone
  tunnel_cname = "8035b44e-f19a-45c9-80d8-58013b329718.cfargotunnel.com"
  applications = [
    {
      name = "Home Assistant",
      subdomain = "hass"
      tags = ["homeassistant", "hass", "iot"]
      logo_url = "https://upload.wikimedia.org/wikipedia/commons/6/6e/Home_Assistant_Logo.svg"
    },
    {
      name = "VuDuo",
      subdomain = "vuduo"
      tags = ["vuduo", "freesat", "satellite"]
      logo_url = null
    },
    {
      name = "Proxmox VM Server 1",
      subdomain = "pvm1"
      tags = ["proxmox", "vm"]
      logo_url = "https://www.svgrepo.com/show/342139/proxmox.svg"
    },
    {
      name = "Proxmox VM Server 2",
      subdomain = "pvm2"
      tags = ["proxmox", "vm"]
      logo_url = "https://www.svgrepo.com/show/342139/proxmox.svg"
    },
    {
      name = "Proxmox VM Server 3",
      subdomain = "pvm3"
      tags = ["proxmox", "vm"]
      logo_url = "https://www.svgrepo.com/show/342139/proxmox.svg"
    },
    {
      name = "Proxmox Backup Server",
      subdomain = "pbs"
      tags = ["proxmox", "backup"]
      logo_url = "https://www.svgrepo.com/show/342139/proxmox.svg"
    },
    {
      name = "Rundeck",
      subdomain = "rundeck"
      tags = ["rundeck", "schedule"]
      logo_url = "https://www.vectorlogo.zone/logos/rundeck/rundeck-icon.svg"
    },
    {
      name = "DS920+ (NAS)",
      subdomain = "ds920p"
      tags = ["synology", "nas"]
      logo_url = "https://upload.wikimedia.org/wikipedia/commons/4/48/Synology_Logo.svg"
    },
    {
      name = "Coder",
      subdomain = "coder"
      tags = ["vscode", "ide"]
      logo_url = "https://www.svgrepo.com/show/514081/code.svg"
    },
  ]
}
