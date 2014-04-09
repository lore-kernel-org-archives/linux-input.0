From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend 2/2] input/serio/8042: Add firmware_id support
Date: Wed,  9 Apr 2014 10:47:50 +0200
Message-ID: <1397033270-29597-3-git-send-email-hdegoede@redhat.com>
References: <1397033270-29597-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49891 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbaDIIsB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Apr 2014 04:48:01 -0400
In-Reply-To: <1397033270-29597-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Fill in the new serio firmware_id sysfs attribute for pnp instantiated
8042 serio ports.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/input/serio/i8042-x86ia64io.h | 26 ++++++++++++++++++++++++++
 drivers/input/serio/i8042.c           |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 0ec9abb..3f9da83 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -704,6 +704,8 @@ static char i8042_pnp_aux_name[32];
 
 static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
 {
+	struct pnp_id *id = dev->id;
+
 	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
 		i8042_pnp_data_reg = pnp_port_start(dev,0);
 
@@ -719,6 +721,17 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *
 		strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
 	}
 
+	if (id) {
+		strlcpy(i8042_kbd_firmware_id, id->id,
+			sizeof(i8042_kbd_firmware_id));
+		for (id = id->next; id; id = id->next) {
+			strlcat(i8042_kbd_firmware_id, " ",
+				sizeof(i8042_kbd_firmware_id));
+			strlcat(i8042_kbd_firmware_id, id->id,
+				sizeof(i8042_kbd_firmware_id));
+		}
+	}
+
 	/* Keyboard ports are always supposed to be wakeup-enabled */
 	device_set_wakeup_enable(&dev->dev, true);
 
@@ -728,6 +741,8 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *
 
 static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
 {
+	struct pnp_id *id = dev->id;
+
 	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
 		i8042_pnp_data_reg = pnp_port_start(dev,0);
 
@@ -743,6 +758,17 @@ static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *
 		strlcat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
 	}
 
+	if (id) {
+		strlcpy(i8042_aux_firmware_id, id->id,
+			sizeof(i8042_aux_firmware_id));
+		for (id = id->next; id; id = id->next) {
+			strlcat(i8042_aux_firmware_id, " ",
+				sizeof(i8042_aux_firmware_id));
+			strlcat(i8042_aux_firmware_id, id->id,
+				sizeof(i8042_aux_firmware_id));
+		}
+	}
+
 	i8042_pnp_aux_devices++;
 	return 0;
 }
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 020053f..3807c3e 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -87,6 +87,8 @@ MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
 #endif
 
 static bool i8042_bypass_aux_irq_test;
+static char i8042_kbd_firmware_id[128];
+static char i8042_aux_firmware_id[128];
 
 #include "i8042.h"
 
@@ -1218,6 +1220,8 @@ static int __init i8042_create_kbd_port(void)
 	serio->dev.parent	= &i8042_platform_device->dev;
 	strlcpy(serio->name, "i8042 KBD port", sizeof(serio->name));
 	strlcpy(serio->phys, I8042_KBD_PHYS_DESC, sizeof(serio->phys));
+	strlcpy(serio->firmware_id, i8042_kbd_firmware_id,
+		sizeof(serio->firmware_id));
 
 	port->serio = serio;
 	port->irq = I8042_KBD_IRQ;
@@ -1244,6 +1248,8 @@ static int __init i8042_create_aux_port(int idx)
 	if (idx < 0) {
 		strlcpy(serio->name, "i8042 AUX port", sizeof(serio->name));
 		strlcpy(serio->phys, I8042_AUX_PHYS_DESC, sizeof(serio->phys));
+		strlcpy(serio->firmware_id, i8042_aux_firmware_id,
+			sizeof(serio->firmware_id));
 		serio->close = i8042_port_close;
 	} else {
 		snprintf(serio->name, sizeof(serio->name), "i8042 AUX%d port", idx);
-- 
1.9.0

