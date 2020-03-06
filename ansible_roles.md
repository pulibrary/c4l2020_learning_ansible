## Ansible Roles

* Roles are Reusable groups of tasks
* Design specific roles to be reusable

  * commonly used build sofware
  * commonly used webservers
  * commonly used applications

* Design application specific roles
  
  * that depend on common roles
  * that tie everything together at the end 
  * configure final drupal implementation

### Roles

* must contain tasks
* may have handlers, templates, files
* Role structure

```bash
.
├── README.md
├── defaults
│   └── main.yml
├── files
│   ├── get_staff_updates.sh
│   ├── id_rsa
│   └── id_rsa.pub
├── handlers
│   └── main.yml
├── tasks
│   └── main.yml
├── templates
│   ├── aliases_drushrc_php.j2
│   ├── discoveryutils_app_config.j2
│   ├── env.local.j2
│   ├── proxy_pass_rules.j2
│   ├── settings.php.j2
│   ├── special_collections_settings.php.j2
│   └── update.sql.j2
└── vars
    └── main.yml
```


### Roles | Templates

* the contain {{ variables_like_this }}
* the have control blocks
  
  {% if expr %}

    ...

   {% endif %}


### Role Exercise

* Create a simple role that will update/upgrade all your Ubuntu and Centos VMs.
* Extra Credit (add zypper, dnf, pacman, apk)
* Extra Extra Credit create a role that installs HAProxy



For very atomic things 

Handlers are used for implementing functionality that needs to be triggered

