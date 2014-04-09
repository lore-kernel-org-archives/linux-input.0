From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/4] input/serio/8042_pnp: set serio->pnp_id for pnp instantiated 8042 ports
Date: Wed,  9 Apr 2014 16:03:00 +0200
Message-ID: <1397052181-22768-3-git-send-email-hdegoede@redhat.com>
References: <1397052181-22768-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32914 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932847AbaDIODK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Apr 2014 10:03:10 -0400
In-Reply-To: <1397052181-22768-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 4 ++++
 drivers/input/serio/i8042.c           | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 2416c74..1d2e13f 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -725,6 +725,8 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	if (pnp_irq_valid(dev,0))
 		i8042_pnp_kbd_irq = pnp_irq(dev, 0);
 
+	i8042_kbd_pnp_id = dev->id;
+
 	strlcpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
 	if (strlen(pnp_dev_name(dev))) {
 		strlcat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
@@ -751,6 +753,8 @@ static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	if (pnp_irq_valid(dev, 0))
 		i8042_pnp_aux_irq = pnp_irq(dev, 0);
 
+	i8042_aux_pnp_id = dev->id;
+
 	strlcpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
 	if (strlen(pnp_dev_name(dev))) {
 		strlcat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 3807c3e..4a3fdf4 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -89,6 +89,8 @@ MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
 static bool i8042_bypass_aux_irq_test;
 static char i8042_kbd_firmware_id[128];
 static char i8042_aux_firmware_id[128];
+static struct pnp_id *i8042_kbd_pnp_id;
+static struct pnp_id *i8042_aux_pnp_id;
 
 #include "i8042.h"
 
@@ -1217,6 +1219,7 @@ static int __init i8042_create_kbd_port(void)
 	serio->stop		= i8042_stop;
 	serio->close		= i8042_port_close;
 	serio->port_data	= port;
+	serio->pnp_id		= i8042_kbd_pnp_id;
 	serio->dev.parent	= &i8042_platform_device->dev;
 	strlcpy(serio->name, "i8042 KBD port", sizeof(serio->name));
 	strlcpy(serio->phys, I8042_KBD_PHYS_DESC, sizeof(serio->phys));
@@ -1246,6 +1249,7 @@ static int __init i8042_create_aux_port(int idx)
 	serio->port_data	= port;
 	serio->dev.parent	= &i8042_platform_device->dev;
 	if (idx < 0) {
+		serio->pnp_id = i8042_aux_pnp_id;
 		strlcpy(serio->name, "i8042 AUX port", sizeof(serio->name));
 		strlcpy(serio->phys, I8042_AUX_PHYS_DESC, sizeof(serio->phys));
 		strlcpy(serio->firmware_id, i8042_aux_firmware_id,
-- 
1.9.0

