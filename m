From: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/7] instruction of cyapa gen6 and proximity patches
Date: Fri, 12 Jun 2015 14:56:31 +0800
Message-ID: <1434092198-13018-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org
Cc: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, jmmahler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

V0 patches mainly have following updates:
1) Add Gen6 trackpad device support;
2) Add report proximity data function support for Gen5 and Gen6 devices;
3) Fully support runtime suspend/resume power management;
4) Add of_match_table mechanism support.


This patch series is mainly amied to add new gen6 trackpad devices support,
and also new function to report proximity data/vent for Gen5 and Gen6 trackpad
devices.


Dudley Du (7):
  input: cyapa: change strings of gen5 to pip in the name when they are
    shared
  input: cyapa: add gen6 device module support in driver
  input: cyapa: add proximity function support for gen5 and gen6 modules
  input: cyapa: fully support runtime suspend power management
  input: cyapa: add proximity and interrupt sysfs interfaces support
  input: cyapa: add of match device support and description document
  input: cyapa: add CYAP0002 Gen6 device for ACPI configuration

 .../devicetree/bindings/input/cypress,cyapa.txt    |   44 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/input/mouse/Makefile                       |    2 +-
 drivers/input/mouse/cyapa.c                        |  254 +++-
 drivers/input/mouse/cyapa.h                        |  158 ++-
 drivers/input/mouse/cyapa_gen3.c                   |    9 +-
 drivers/input/mouse/cyapa_gen5.c                   | 1243 +++++++++++---------
 drivers/input/mouse/cyapa_gen6.c                   |  762 ++++++++++++
 8 files changed, 1844 insertions(+), 629 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.txt
 create mode 100644 drivers/input/mouse/cyapa_gen6.c

-- 
1.9.1


---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
