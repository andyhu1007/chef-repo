maintainer       "YOUR_COMPANY_NAME"
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "Installs/Configures nodejs"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
recipe           "nodejs", "Installs Node.JS from source"
recipe           "nodejs::npm", "Installs npm - a package manager for node"

depends          "build-essential"
