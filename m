From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 2/2] input/serio/8042: Add firmware_id support
Date: Mon, 14 Apr 2014 12:34:26 +0200
Message-ID: <1397471666-31327-1-git-send-email-hdegoede@redhat.com>
References: <1397471419-31224-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754382AbaDNKe3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2014 06:34:29 -0400
In-Reply-To: <1397471419-31224-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Fill in the new serio firmware_id sysfs attribute for pnp instantiated
8042 serio ports.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/input/serio/i8042-x86ia64io.h | 15 +++++++++++++++
 drivers/input/serio/i8042.c           |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 0ec9abb..381b20d 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -702,6 +702,17 @@ static int i8042_pnp_aux_irq;
 static char i8042_pnp_kbd_name[32];
 static char i8042_pnp_aux_name[32];
 
+static void i8042_pnp_id_to_string(struct pnp_id *id, char *dst, int dst_size)
+{
+	strlcpy(dst, "PNP:", dst_size);
+
+	while (id) {
+		strlcat(dst, " ", dst_size);
+		strlcat(dst, id->id, dst_size);
+		id = id->next;
+	}
+}
+
 static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
 {
 	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
@@ -718,6 +729,8 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *
 		strlcat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
 		strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
 	}
+	i8042_pnp_id_to_string(dev->id, i8042_kbd_firmware_id,
+			       sizeof(i8042_kbd_firmware_id));
 
 	/* Keyboard ports are always supposed to be wakeup-enabled */
 	device_set_wakeup_enable(&dev->dev, true);
@@ -742,6 +755,8 @@ static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *
 		strlcat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
 		strlcat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
 	}
+	i8042_pnp_id_to_string(dev->id, i8042_aux_firmware_id,
+			       sizeof(i8042_aux_firmware_id));
 
 	i8042_pnp_aux_devices++;
 	return 0;
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

