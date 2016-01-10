From: Oreste Salerno <oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 0/3] Add device tree support to the cyttsp driver
Date: Sun, 10 Jan 2016 18:36:06 +0100
Message-ID: <cover.1452447124.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fery-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org
List-Id: linux-input@vger.kernel.org

This set of patches adds support to the cyttsp touchscreen driver
to retrieve platform-specific details from the device tree.
Additionally, they define a default init function that performs a hard
reset of the chip on boot.

---
Changes in v3:
  - Rework binding names and descriptions
Changes in v2:
  - Fix err_cast.cocci warning in patch 2/3

Oreste Salerno (3):
  Input: cyttsp - remove unused irq_gpio from platform_data
  Input: cyttsp - add device tree bindings
  Input: cyttsp - add default init function

 .../bindings/input/touchscreen/cyttsp.txt          |  82 ++++++++++++
 drivers/input/touchscreen/cyttsp_core.c            | 146 ++++++++++++++++++++-
 include/linux/input/cyttsp.h                       |   4 +-
 3 files changed, 224 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
