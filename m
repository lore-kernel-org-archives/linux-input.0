From: cpaul@redhat.com
Subject: [PATCH v4] i8042: Add debug_kbd option
Date: Fri, 26 Jun 2015 20:24:38 -0400
Message-ID: <1435364678-22826-1-git-send-email-cpaul@redhat.com>
References: <20150626230500.GA22932@dtor-ws>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150626230500.GA22932@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Stephen Chandler Paul <cpaul@redhat.com>

A big problem with the current i8042 debugging option is that it outputs
data going to and from the keyboard by default. As a result, many dmesg
logs uploaded by users will unintentionally contain sensitive information
such as their password, as such it's probably a good idea not to output
data coming from the keyboard unless specifically enabled by the user.

Signed-off-by: Stephen Chandler Paul <cpaul@redhat.com>
---
				    Changes
* Remove #ifdefs around notifier code
* Rename i8042_port.filter_dbg to i8042.driver_bound
* Instead of checking the parent of the current device, compare serio against
  i8042_ports[I8042_KBD_PORT_NO].serio
* Use a switch case instead of an if-else when checking the action in the bus
  notifier
* Export serio_bus into serio.h, register the bus notifiers at module load time
  as opposed to port registration time

 Documentation/kernel-parameters.txt |  3 +++
 drivers/input/serio/i8042.c         | 43 +++++++++++++++++++++++++++++++++----
 drivers/input/serio/i8042.h         | 13 +++++++++++
 drivers/input/serio/serio.c         |  4 +---
 include/linux/serio.h               |  2 ++
 5 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index ae44749..a9d2b19 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1304,6 +1304,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			     <bus_id>,<clkrate>
 
 	i8042.debug	[HW] Toggle i8042 debug mode
+	i8042.debug_kbd [HW] Enable printing of interrupt data from the KBD port
+			     (disabled by default, requires that i8042.debug=1
+			     be enabled)
 	i8042.direct	[HW] Put keyboard port into non-translated mode
 	i8042.dumbkbd	[HW] Pretend that controller can only read data from
 			     keyboard and cannot control its state
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index cb5ece7..e29d6a4 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -88,6 +88,10 @@ MODULE_PARM_DESC(nopnp, "Do not use PNP to detect controller settings");
 static bool i8042_debug;
 module_param_named(debug, i8042_debug, bool, 0600);
 MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
+
+static bool i8042_debug_kbd;
+module_param_named(debug_kbd, i8042_debug_kbd, bool, 0600);
+MODULE_PARM_DESC(i8042_kbd, "Turn i8042 kbd debugging output on or off (requires i8042.debug=1)");
 #endif
 
 static bool i8042_bypass_aux_irq_test;
@@ -116,6 +120,7 @@ struct i8042_port {
 	struct serio *serio;
 	int irq;
 	bool exists;
+	bool driver_bound;
 	signed char mux;
 };
 
@@ -133,6 +138,7 @@ static bool i8042_kbd_irq_registered;
 static bool i8042_aux_irq_registered;
 static unsigned char i8042_suppress_kbd_ack;
 static struct platform_device *i8042_platform_device;
+static struct notifier_block i8042_kbd_bind_notifier_block;
 
 static irqreturn_t i8042_interrupt(int irq, void *dev_id);
 static bool (*i8042_platform_filter)(unsigned char data, unsigned char str,
@@ -528,10 +534,10 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	port = &i8042_ports[port_no];
 	serio = port->exists ? port->serio : NULL;
 
-	dbg("%02x <- i8042 (interrupt, %d, %d%s%s)\n",
-	    data, port_no, irq,
-	    dfl & SERIO_PARITY ? ", bad parity" : "",
-	    dfl & SERIO_TIMEOUT ? ", timeout" : "");
+	filter_dbg(port->driver_bound, data, "<- i8042 (interrupt, %d, %d%s%s)\n",
+		   port_no, irq,
+		   dfl & SERIO_PARITY ? ", bad parity" : "",
+		   dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
 	filtered = i8042_filter(data, str, serio);
 
@@ -1438,6 +1444,29 @@ static int __init i8042_setup_kbd(void)
 	return error;
 }
 
+static int i8042_kbd_bind_notifier(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct serio *serio = to_serio_port(dev);
+	struct i8042_port *port = serio->port_data;
+
+	if (serio != i8042_ports[I8042_KBD_PORT_NO].serio)
+		return 0;
+
+	switch (action) {
+	case BUS_NOTIFY_BOUND_DRIVER:
+		port->driver_bound = true;
+		break;
+
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		port->driver_bound = false;
+		break;
+	}
+
+	return 0;
+}
+
 static int __init i8042_probe(struct platform_device *dev)
 {
 	int error;
@@ -1507,6 +1536,10 @@ static struct platform_driver i8042_driver = {
 	.shutdown	= i8042_shutdown,
 };
 
+static struct notifier_block i8042_kbd_bind_notifier_block = {
+	.notifier_call = i8042_kbd_bind_notifier,
+};
+
 static int __init i8042_init(void)
 {
 	struct platform_device *pdev;
@@ -1528,6 +1561,7 @@ static int __init i8042_init(void)
 		goto err_platform_exit;
 	}
 
+	bus_register_notifier(&serio_bus, &i8042_kbd_bind_notifier_block);
 	panic_blink = i8042_panic_blink;
 
 	return 0;
@@ -1543,6 +1577,7 @@ static void __exit i8042_exit(void)
 	platform_driver_unregister(&i8042_driver);
 	i8042_platform_exit();
 
+	bus_unregister_notifier(&serio_bus, &i8042_kbd_bind_notifier_block);
 	panic_blink = NULL;
 }
 
diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index fc080be..a198f0d 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -73,6 +73,17 @@ static unsigned long i8042_start_time;
 			printk(KERN_DEBUG KBUILD_MODNAME ": [%d] " format,	\
 			       (int) (jiffies - i8042_start_time), ##arg);	\
 	} while (0)
+
+#define filter_dbg(filter, data, format, args...)		\
+	do {							\
+		if (!i8042_debug)				\
+			break;					\
+								\
+		if (!filter || i8042_debug_kbd)			\
+			dbg("%02x " format, data, ##args);	\
+		else						\
+			dbg("** " format, ##args);		\
+	} while (0)
 #else
 #define dbg_init() do { } while (0)
 #define dbg(format, arg...)							\
@@ -80,6 +91,8 @@ static unsigned long i8042_start_time;
 		if (0)								\
 			printk(KERN_DEBUG pr_fmt(format), ##arg);		\
 	} while (0)
+
+#define filter_dbg(filter, data, format, args...) do { } while (0)
 #endif
 
 #endif /* _I8042_H */
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index a05a517..63422d2 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -49,8 +49,6 @@ static DEFINE_MUTEX(serio_mutex);
 
 static LIST_HEAD(serio_list);
 
-static struct bus_type serio_bus;
-
 static void serio_add_port(struct serio *serio);
 static int serio_reconnect_port(struct serio *serio);
 static void serio_disconnect_port(struct serio *serio);
@@ -1017,7 +1015,7 @@ irqreturn_t serio_interrupt(struct serio *serio,
 }
 EXPORT_SYMBOL(serio_interrupt);
 
-static struct bus_type serio_bus = {
+struct bus_type serio_bus = {
 	.name		= "serio",
 	.drv_groups	= serio_driver_groups,
 	.match		= serio_bus_match,
diff --git a/include/linux/serio.h b/include/linux/serio.h
index 9f779c7..df4ab5d 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -18,6 +18,8 @@
 #include <linux/mod_devicetable.h>
 #include <uapi/linux/serio.h>
 
+extern struct bus_type serio_bus;
+
 struct serio {
 	void *port_data;
 
-- 
2.4.3
