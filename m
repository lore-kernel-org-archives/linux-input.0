From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH v3] serio: add support for PS2Mult multiplexer protocol
Date: Thu, 23 Sep 2010 20:44:45 +0400
Message-ID: <1285260285-660-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35614 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab0IWQpC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Sep 2010 12:45:02 -0400
Received: by fxm3 with SMTP id 3so185570fxm.19
        for <linux-input@vger.kernel.org>; Thu, 23 Sep 2010 09:45:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

PS2Mult is a simple serial protocol used for multiplexing several PS/2 streams
into one serial data stream. It's used e.g. on TQM85xx serie of boards.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---

It actually depends on "serio: multiple children" patch. I'm not resending it
as you were the originator of the latest version of the patch.

 drivers/input/serio/Kconfig   |    8 +
 drivers/input/serio/Makefile  |    1 +
 drivers/input/serio/ps2mult.c |  283 +++++++++++++++++++++++++++++++++++++++++
 include/linux/serio.h         |    2 +
 4 files changed, 294 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/serio/ps2mult.c

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 3bfe8fa..63f4658 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -226,4 +226,12 @@ config SERIO_AMS_DELTA
 	  To compile this driver as a module, choose M here;
 	  the module will be called ams_delta_serio.
 
+config SERIO_PS2MULT
+	tristate "TQC PS/2 multiplexer"
+	help
+	  Say Y here if you have the PS/2 line multiplexer like present on TQC boads
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ps2mult.
+
 endif
diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
index 84c80bf..26714c5 100644
--- a/drivers/input/serio/Makefile
+++ b/drivers/input/serio/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_SERIO_RAW)		+= serio_raw.o
 obj-$(CONFIG_SERIO_AMS_DELTA)	+= ams_delta_serio.o
 obj-$(CONFIG_SERIO_XILINX_XPS_PS2)	+= xilinx_ps2.o
 obj-$(CONFIG_SERIO_ALTERA_PS2)	+= altera_ps2.o
+obj-$(CONFIG_SERIO_PS2MULT)	+= ps2mult.o
diff --git a/drivers/input/serio/ps2mult.c b/drivers/input/serio/ps2mult.c
new file mode 100644
index 0000000..bd45e76
--- /dev/null
+++ b/drivers/input/serio/ps2mult.c
@@ -0,0 +1,283 @@
+/*
+ * TQC PS/2 Multiplexer driver
+ *
+ * Copyright (C) 2010 Dmitry Eremin-Solenikov
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/serio.h>
+
+MODULE_AUTHOR("Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>");
+MODULE_DESCRIPTION("TQC PS/2 Multiplexer driver");
+MODULE_LICENSE("GPL");
+
+#define PS2MULT_KB_SELECTOR		0xA0
+#define PS2MULT_MS_SELECTOR		0xA1
+#define PS2MULT_ESCAPE			0x7D
+#define PS2MULT_BSYNC			0x7E
+#define PS2MULT_SESSION_START		0x55
+#define PS2MULT_SESSION_END		0x56
+
+struct ps2mult_port {
+	struct serio *serio;
+	unsigned char sel;
+};
+
+#define PS2MULT_NUM_PORTS	2
+
+struct ps2mult {
+	struct serio *serio;
+	struct ps2mult_port ports[PS2MULT_NUM_PORTS];
+
+	spinlock_t lock;
+	struct serio *in_serio;
+	struct serio *out_serio;
+	bool escape;
+};
+
+/* First MUST com PS2MULT_NUM_PORTS selectors */
+static unsigned char ps2mult_controls[] = {
+	PS2MULT_KB_SELECTOR, PS2MULT_MS_SELECTOR,
+	PS2MULT_ESCAPE, PS2MULT_BSYNC,
+	PS2MULT_SESSION_START, PS2MULT_SESSION_END,
+};
+
+static struct serio_device_id ps2mult_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_PS2MULT,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(serio, ps2mult_serio_ids);
+
+static int ps2mult_serio_write(struct serio *serio, unsigned char data)
+
+{
+	struct ps2mult *psm = serio_get_drvdata(serio->parent);
+	struct ps2mult_port *psmp = serio->port_data;
+	bool need_escape;
+	unsigned long flags;
+
+	spin_lock_irqsave(&psm->lock, flags);
+	if (psm->out_serio != serio) {
+		psm->serio->write(psm->serio, psmp->sel);
+		psm->out_serio = serio;
+		dev_dbg(&serio->dev, "switched to sel %02x\n", psmp->sel);
+	}
+
+	need_escape = memchr(ps2mult_controls, data, sizeof(ps2mult_controls));
+
+	dev_dbg(&serio->dev, "write: %s%02x\n",
+			need_escape ? "ESC " : "", data);
+
+	if (need_escape)
+		psm->serio->write(psm->serio, PS2MULT_ESCAPE);
+	psm->serio->write(psm->serio, data);
+
+	spin_unlock_irqrestore(&psm->lock, flags);
+
+	return 0;
+}
+
+static void ps2mult_serio_stop(struct serio *serio)
+{
+	struct ps2mult *psm = serio_get_drvdata(serio->parent);
+	struct ps2mult_port *psmp = serio->port_data;
+
+	unsigned long flags;
+
+	spin_lock_irqsave(&psm->lock, flags);
+
+	psmp->serio = NULL;
+	if (psm->in_serio == serio)
+		psm->in_serio = NULL;
+	if (psm->out_serio == serio)
+		psm->out_serio = NULL;
+
+	spin_unlock_irqrestore(&psm->lock, flags);
+
+}
+
+static int ps2mult_create_port(struct ps2mult *psm, int i)
+{
+	struct serio *serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!serio)
+		return -ENOMEM;
+
+	strlcpy(serio->name, "TQC PS/2 Multiplexer", sizeof(serio->name));
+	snprintf(serio->phys, sizeof(serio->phys),
+			"%s/port%d", psm->serio->phys, i);
+	serio->id.type = SERIO_8042;
+	serio->id.proto = SERIO_PS2MULT;
+	serio->write = ps2mult_serio_write;
+	serio->stop = ps2mult_serio_stop;
+	serio->parent = psm->serio;
+
+	serio->port_data = &psm->ports[i];
+
+	psm->ports[i].serio = serio;
+	psm->ports[i].sel = ps2mult_controls[i];
+
+	serio_register_port(serio);
+	dev_info(&serio->dev, "%s port at %s\n", serio->name, psm->serio->phys);
+
+	return 0;
+}
+
+static int ps2mult_reconnect(struct serio *serio)
+{
+	struct ps2mult *psm = serio_get_drvdata(serio);
+	unsigned long flags;
+
+	serio->write(serio, PS2MULT_SESSION_END);
+	serio->write(serio, PS2MULT_SESSION_START);
+
+	spin_lock_irqsave(&psm->lock, flags);
+	psm->out_serio = psm->ports[0].serio;
+	serio->write(serio, psm->ports[0].sel);
+	spin_unlock_irqrestore(&psm->lock, flags);
+
+	return 0;
+}
+
+static void ps2mult_disconnect(struct serio *serio)
+{
+	struct ps2mult *psm = serio_get_drvdata(serio);
+
+	serio->write(serio, PS2MULT_SESSION_END);
+
+	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
+
+	kfree(psm);
+}
+
+static int ps2mult_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct ps2mult *psm;
+	int i;
+	int rc;
+
+	if (!serio->write)
+		return -EINVAL;
+
+	psm = kzalloc(sizeof(*psm), GFP_KERNEL);
+	if (!psm)
+		return -ENOMEM;
+
+	spin_lock_init(&psm->lock);
+	psm->serio = serio;
+
+	serio_set_drvdata(serio, psm);
+
+	for (i = 0; i <  PS2MULT_NUM_PORTS; i++) {
+		rc = ps2mult_create_port(psm, i);
+		if (rc)
+			goto err_out;
+	}
+
+	serio_open(serio, drv);
+
+	rc = ps2mult_reconnect(serio);
+	if (rc)
+		goto err_out;
+
+	return 0;
+
+err_out:
+	ps2mult_disconnect(serio);
+
+	return rc;
+}
+
+static irqreturn_t ps2mult_interrupt(struct serio *serio, unsigned char data,
+		unsigned int flags)
+{
+	struct ps2mult *psm = serio_get_drvdata(serio);
+
+	dev_dbg(&serio->dev, "Received %02x flags %02x\n", data, flags);
+	if (psm->escape) {
+		spin_lock(&psm->lock);
+		if (psm->in_serio)
+			serio_interrupt(psm->in_serio, data, flags);
+		spin_unlock(&psm->lock);
+
+		psm->escape = 0;
+	} else
+		switch (data) {
+		case PS2MULT_ESCAPE:
+			dev_dbg(&serio->dev, "ESCAPE\n");
+			psm->escape = 1;
+			break;
+		case PS2MULT_BSYNC:
+			dev_dbg(&serio->dev, "BSYNC\n");
+			spin_lock(&psm->lock);
+			psm->in_serio = psm->out_serio;
+			spin_unlock(&psm->lock);
+			break;
+		case PS2MULT_SESSION_START:
+			dev_dbg(&serio->dev, "SS\n");
+			break;
+		case PS2MULT_SESSION_END:
+			dev_dbg(&serio->dev, "SE\n");
+			break;
+		case PS2MULT_KB_SELECTOR:
+			dev_dbg(&serio->dev, "KB\n");
+
+			spin_lock(&psm->lock);
+			psm->in_serio = psm->ports[0].serio;
+			spin_unlock(&psm->lock);
+
+			break;
+		case PS2MULT_MS_SELECTOR:
+			dev_dbg(&serio->dev, "MS\n");
+
+			spin_lock(&psm->lock);
+			psm->in_serio = psm->ports[1].serio;
+			spin_unlock(&psm->lock);
+
+			break;
+		default:
+			spin_lock(&psm->lock);
+			if (psm->in_serio)
+				serio_interrupt(psm->in_serio, data, flags);
+			spin_unlock(&psm->lock);
+		}
+	return IRQ_HANDLED;
+}
+
+static struct serio_driver ps2mult_drv = {
+	.driver		= {
+		.name	= "ps2mult",
+	},
+	.description	= "TQC PS/2 Multiplexer driver",
+	.id_table	= ps2mult_serio_ids,
+	.interrupt	= ps2mult_interrupt,
+	.connect	= ps2mult_connect,
+	.disconnect	= ps2mult_disconnect,
+	.reconnect	= ps2mult_reconnect,
+};
+
+static int __init ps2mult_init(void)
+{
+	return serio_register_driver(&ps2mult_drv);
+}
+
+static void __exit ps2mult_exit(void)
+{
+	serio_unregister_driver(&ps2mult_drv);
+}
+
+module_init(ps2mult_init);
+module_exit(ps2mult_exit);
diff --git a/include/linux/serio.h b/include/linux/serio.h
index 8e495ba..136863c 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -155,6 +155,7 @@ static inline void serio_continue_rx(struct serio *serio)
 #define SERIO_HIL_MLC	0x03
 #define SERIO_PS_PSTHRU	0x05
 #define SERIO_8042_XL	0x06
+#define SERIO_PS2MULT_T	0x07
 
 /*
  * Serio protocols
@@ -199,5 +200,6 @@ static inline void serio_continue_rx(struct serio *serio)
 #define SERIO_W8001	0x39
 #define SERIO_DYNAPRO	0x3a
 #define SERIO_HAMPSHIRE	0x3b
+#define SERIO_PS2MULT	0x3c
 
 #endif
-- 
1.7.1

