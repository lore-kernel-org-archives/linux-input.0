From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 1/3] input: serio - allow others to specify a driver for a serio device
Date: Wed,  8 Mar 2017 16:24:43 +0100
Message-ID: <20170308152445.12082-2-benjamin.tissoires@redhat.com>
References: <20170308152445.12082-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170308152445.12082-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Lenovo Thinkpads use RMI4 over SMBus in addition to PS/2 for their
trackpad. The problem is that the device doesn't enumerate itself besides
some registers in PS/2.

Once the initial PS/2 initialization has been made, we need a way to unbind
psmouse from the touchpad and use a different (dummy) serio driver to
not interfere with SMBus.

This patch adds the mechanisms to unbind psmouse and use a different serio
driver, driver which can be marked as manual_bind to not be picked up
by inadvertence.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

new in v2
---
 drivers/input/serio/serio.c | 20 ++++++++++++++++++++
 include/linux/serio.h       |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 1ca7f55..14cc383 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -704,6 +704,23 @@ void serio_reconnect(struct serio *serio)
 }
 EXPORT_SYMBOL(serio_reconnect);
 
+void serio_bind_manual_driver(struct serio *serio, struct serio_driver *drv)
+{
+	mutex_lock(&serio_mutex);
+	serio->manual_bind = true;
+	serio->manual_drv = &drv->driver;
+	mutex_unlock(&serio_mutex);
+	serio_rescan(serio);
+}
+EXPORT_SYMBOL(serio_bind_manual_driver);
+
+void serio_clear_manual_driver(struct serio *serio)
+{
+	serio->manual_bind = false;
+	serio->manual_drv = NULL;
+}
+EXPORT_SYMBOL(serio_clear_manual_driver);
+
 /*
  * Submits register request to kseriod for subsequent execution.
  * Note that port registration is always asynchronous.
@@ -902,6 +919,9 @@ static int serio_bus_match(struct device *dev, struct device_driver *drv)
 	struct serio *serio = to_serio_port(dev);
 	struct serio_driver *serio_drv = to_serio_driver(drv);
 
+	if (serio->manual_drv && serio->manual_drv == drv)
+		return serio_match_port(serio_drv->id_table, serio);
+
 	if (serio->manual_bind || serio_drv->manual_bind)
 		return 0;
 
diff --git a/include/linux/serio.h b/include/linux/serio.h
index c733cff..1a6f4db 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -64,6 +64,9 @@ struct serio {
 	 * may get indigestion when exposed to concurrent access (i8042).
 	 */
 	struct mutex *ps2_cmd_mutex;
+
+	/* Used when forcing a driver instead of the default one. */
+	struct device_driver *manual_drv;
 };
 #define to_serio_port(d)	container_of(d, struct serio, dev)
 
@@ -88,6 +91,8 @@ int serio_open(struct serio *serio, struct serio_driver *drv);
 void serio_close(struct serio *serio);
 void serio_rescan(struct serio *serio);
 void serio_reconnect(struct serio *serio);
+void serio_bind_manual_driver(struct serio *serio, struct serio_driver *drv);
+void serio_clear_manual_driver(struct serio *serio);
 irqreturn_t serio_interrupt(struct serio *serio, unsigned char data, unsigned int flags);
 
 void __serio_register_port(struct serio *serio, struct module *owner);
-- 
2.9.3
