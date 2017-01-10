From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 04/10] Input: psmouse - allow to deactivate a driver from the serio handle
Date: Tue, 10 Jan 2017 17:11:22 +0100
Message-ID: <20170110161128.7441-5-benjamin.tissoires@redhat.com>
References: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Andrew Duggan <aduggan@synaptics.com>
Cc: Adrian Alves <aalves@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The RMI4 over SMBus and PS/2 implementation of Synaptics touchpads are
mutually exclusive. We need a way to deactivate the touchpad from the PS/2
node and prevent it to not rebind itself during resume.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/psmouse-base.c | 31 +++++++++++++++++++++++++++++++
 drivers/input/mouse/psmouse.h      |  3 +++
 drivers/input/mouse/synaptics.c    | 15 +++++++++++++++
 include/linux/serio.h              | 14 ++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index c822d73..7fe6f4e 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -936,6 +936,8 @@ static void psmouse_apply_defaults(struct psmouse *psmouse)
 	psmouse->reconnect = NULL;
 	psmouse->disconnect = NULL;
 	psmouse->cleanup = NULL;
+	psmouse->activate = NULL;
+	psmouse->deactivate = NULL;
 	psmouse->pt_activate = NULL;
 	psmouse->pt_deactivate = NULL;
 }
@@ -1603,6 +1605,9 @@ static int psmouse_reconnect(struct serio *serio)
 	unsigned char type;
 	int rc = -1;
 
+	if (psmouse->ignore_reconnect)
+		return 0;
+
 	mutex_lock(&psmouse_mutex);
 
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
@@ -1649,6 +1654,30 @@ static int psmouse_reconnect(struct serio *serio)
 	return rc;
 }
 
+static void psmouse_deactivate_cb(struct serio *serio)
+{
+	struct psmouse *psmouse = serio_get_drvdata(serio);
+
+	psmouse->ignore_reconnect = true;
+
+	if (psmouse->deactivate)
+		psmouse->deactivate(psmouse);
+
+	psmouse_deactivate(psmouse);
+}
+
+static void psmouse_activate_cb(struct serio *serio)
+{
+	struct psmouse *psmouse = serio_get_drvdata(serio);
+
+	psmouse->ignore_reconnect = false;
+
+	psmouse_activate(psmouse);
+
+	if (psmouse->activate)
+		psmouse->activate(psmouse);
+}
+
 static struct serio_device_id psmouse_serio_ids[] = {
 	{
 		.type	= SERIO_8042,
@@ -1678,6 +1707,8 @@ static struct serio_driver psmouse_drv = {
 	.reconnect	= psmouse_reconnect,
 	.disconnect	= psmouse_disconnect,
 	.cleanup	= psmouse_cleanup,
+	.deactivate	= psmouse_deactivate_cb,
+	.activate	= psmouse_activate_cb,
 };
 
 ssize_t psmouse_attr_show_helper(struct device *dev, struct device_attribute *devattr,
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index e0ca6cd..61d6277 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -78,9 +78,12 @@ struct psmouse {
 	void (*disconnect)(struct psmouse *psmouse);
 	void (*cleanup)(struct psmouse *psmouse);
 	int (*poll)(struct psmouse *psmouse);
+	void (*deactivate)(struct psmouse *psmouse);
+	void (*activate)(struct psmouse *psmouse);
 
 	void (*pt_activate)(struct psmouse *psmouse);
 	void (*pt_deactivate)(struct psmouse *psmouse);
+	bool ignore_reconnect;
 };
 
 enum psmouse_type {
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 8781e23..e977ab0 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -657,6 +657,19 @@ static void synaptics_pt_create(struct psmouse *psmouse)
 	serio_register_port(serio);
 }
 
+void synaptics_deactivate(struct psmouse *psmouse)
+{
+	serio_unregister_child_port(psmouse->ps2dev.serio);
+}
+
+void synaptics_activate(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+
+	if (SYN_CAP_PASS_THROUGH(priv->capabilities))
+		synaptics_pt_create(psmouse);
+}
+
 /*****************************************************************************
  *	Functions to interpret the absolute mode packets
  ****************************************************************************/
@@ -1518,6 +1531,8 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
 	psmouse->cleanup = synaptics_reset;
+	psmouse->activate = synaptics_activate;
+	psmouse->activate = synaptics_deactivate;
 	/* Synaptics can usually stay in sync without extra help */
 	psmouse->resync_time = 0;
 
diff --git a/include/linux/serio.h b/include/linux/serio.h
index f3b75c8..f07d663 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -87,6 +87,8 @@ struct serio_driver {
 	int  (*reconnect)(struct serio *);
 	void (*disconnect)(struct serio *);
 	void (*cleanup)(struct serio *);
+	void (*deactivate)(struct serio *);
+	void (*activate)(struct serio *);
 
 	struct device_driver driver;
 };
@@ -171,4 +173,16 @@ static inline void serio_continue_rx(struct serio *serio)
 	spin_unlock_irq(&serio->lock);
 }
 
+static inline void serio_activate(struct serio *serio)
+{
+	if (serio && serio->drv && serio->drv->activate)
+		serio->drv->activate(serio);
+}
+
+static inline void serio_deactivate(struct serio *serio)
+{
+	if (serio && serio->drv && serio->drv->deactivate)
+		serio->drv->deactivate(serio);
+}
+
 #endif
-- 
2.9.3
