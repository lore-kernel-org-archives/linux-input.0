From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 3/3] psmouse: Add support for detecting FocalTech PS/2 touchpads
Date: Fri, 12 Sep 2014 11:08:32 +0200
Message-ID: <1410512912-11609-4-git-send-email-hdegoede@redhat.com>
References: <1410512912-11609-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47390 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbaILJIl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Sep 2014 05:08:41 -0400
In-Reply-To: <1410512912-11609-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The Asus X450 and X550 laptops use a PS/2 touchpad from a new manufacturer
called FocalTech:

https://bugzilla.kernel.org/show_bug.cgi?id=77391
https://bugzilla.redhat.com/show_bug.cgi?id=1110011

The protocol for these devices is not known at this time, but even without
knowing the protocol they need some special handling. They get upset by some
of our other PS/2 device probing, and once upset generate random mouse events
making things unusable even with an external mouse.

This patch adds detection of these devices based on their pnp ids, and when
they are detected, treats them as a bare ps/2 mouse. Doing things this way
they at least work in their ps/2 mouse emulation mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/Makefile       |  2 +-
 drivers/input/mouse/focaltech.c    | 52 ++++++++++++++++++++++++++++++++++++++
 drivers/input/mouse/focaltech.h    | 22 ++++++++++++++++
 drivers/input/mouse/psmouse-base.c | 10 ++++++++
 4 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 drivers/input/mouse/focaltech.c
 create mode 100644 drivers/input/mouse/focaltech.h

diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index c25efdb..dda507f 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_MOUSE_SYNAPTICS_I2C)	+= synaptics_i2c.o
 obj-$(CONFIG_MOUSE_SYNAPTICS_USB)	+= synaptics_usb.o
 obj-$(CONFIG_MOUSE_VSXXXAA)		+= vsxxxaa.o
 
-psmouse-objs := psmouse-base.o synaptics.o
+psmouse-objs := psmouse-base.o synaptics.o focaltech.o
 
 psmouse-$(CONFIG_MOUSE_PS2_ALPS)	+= alps.o
 psmouse-$(CONFIG_MOUSE_PS2_ELANTECH)	+= elantech.o
diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
new file mode 100644
index 0000000..f4d657e
--- /dev/null
+++ b/drivers/input/mouse/focaltech.c
@@ -0,0 +1,52 @@
+/*
+ * Focaltech TouchPad PS/2 mouse driver
+ *
+ * Copyright (c) 2014 Red Hat Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Red Hat authors:
+ *
+ * Hans de Goede <hdegoede@redhat.com>
+ */
+
+/*
+ * The Focaltech PS/2 touchpad protocol is unknown. This drivers deals with
+ * detection only, to avoid further detection attempts confusing the touchpad
+ * this way it at least works in PS/2 mouse compatibility mode.
+ */
+
+#include <linux/device.h>
+#include <linux/libps2.h>
+#include "psmouse.h"
+
+static const char * const focaltech_pnp_ids[] = {
+	"FLT0101",
+	"FLT0102",
+	"FLT0103",
+	NULL
+};
+
+int focaltech_detect(struct psmouse *psmouse, bool set_properties)
+{
+	if (!psmouse_matches_pnp_id(psmouse, focaltech_pnp_ids))
+		return -ENODEV;
+
+	if (set_properties) {
+		psmouse->vendor = "FocalTech";
+		psmouse->name = "FocalTech Touchpad in mouse emulation mode";
+	}
+
+	return 0;
+}
+
+int focaltech_init(struct psmouse *psmouse)
+{
+	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
+	psmouse_reset(psmouse);
+
+	return 0;
+}
diff --git a/drivers/input/mouse/focaltech.h b/drivers/input/mouse/focaltech.h
new file mode 100644
index 0000000..498650c
--- /dev/null
+++ b/drivers/input/mouse/focaltech.h
@@ -0,0 +1,22 @@
+/*
+ * Focaltech TouchPad PS/2 mouse driver
+ *
+ * Copyright (c) 2014 Red Hat Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Red Hat authors:
+ *
+ * Hans de Goede <hdegoede@redhat.com>
+ */
+
+#ifndef _FOCALTECH_H
+#define _FOCALTECH_H
+
+int focaltech_detect(struct psmouse *psmouse, bool set_properties);
+int focaltech_init(struct psmouse *psmouse);
+
+#endif
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 02e68c3..ae1e76b 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -35,6 +35,7 @@
 #include "elantech.h"
 #include "sentelic.h"
 #include "cypress_ps2.h"
+#include "focaltech.h"
 
 #define DRIVER_DESC	"PS/2 mouse driver"
 
@@ -722,6 +723,15 @@ static int psmouse_extensions(struct psmouse *psmouse,
 {
 	bool synaptics_hardware = false;
 
+/* Always check for focaltech, this is safe as it uses pnp-id matching */
+	if (psmouse_do_detect(focaltech_detect, psmouse, set_properties) == 0) {
+		if (!set_properties || focaltech_init(psmouse) == 0) {
+			/* Not supported yet, use bare protocol */
+			psmouse_max_proto = PSMOUSE_PS2;
+			return PSMOUSE_PS2;
+		}
+	}
+
 /*
  * We always check for lifebook because it does not disturb mouse
  * (it only checks DMI information).
-- 
2.1.0

