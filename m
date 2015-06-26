From: cpaul@redhat.com
Subject: [PATCH v2] i8042: Add debug_kbd option
Date: Fri, 26 Jun 2015 15:28:20 -0400
Message-ID: <1435346900-32367-1-git-send-email-cpaul@redhat.com>
References: <1435260310-10074-1-git-send-email-cpaul@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435260310-10074-1-git-send-email-cpaul@redhat.com>
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
* Moved declaration of str_dbg() (now filter_dbg()) to i8042.h with the
  rest of the debugging functions
* Make note of the dependency on i8042.debug=1 in the documentation and in the
  kernel option description
* Use a bus notifier so that we only filter interrupts coming from the
  keyboard once an input driver has been bound to a device on the port

 Documentation/kernel-parameters.txt |  3 ++
 drivers/input/serio/i8042.c         | 60 +++++++++++++++++++++++++++++++++----
 drivers/input/serio/i8042.h         | 13 ++++++++
 3 files changed, 70 insertions(+), 6 deletions(-)

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
index cb5ece7..97e5c93 100644
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
@@ -116,6 +120,9 @@ struct i8042_port {
 	struct serio *serio;
 	int irq;
 	bool exists;
+#ifdef DEBUG
+	bool filter_dbg;
+#endif
 	signed char mux;
 };
 
@@ -133,6 +140,9 @@ static bool i8042_kbd_irq_registered;
 static bool i8042_aux_irq_registered;
 static unsigned char i8042_suppress_kbd_ack;
 static struct platform_device *i8042_platform_device;
+#ifdef DEBUG
+static struct notifier_block i8042_kbd_bind_notifier_block;
+#endif
 
 static irqreturn_t i8042_interrupt(int irq, void *dev_id);
 static bool (*i8042_platform_filter)(unsigned char data, unsigned char str,
@@ -528,10 +538,10 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	port = &i8042_ports[port_no];
 	serio = port->exists ? port->serio : NULL;
 
-	dbg("%02x <- i8042 (interrupt, %d, %d%s%s)\n",
-	    data, port_no, irq,
-	    dfl & SERIO_PARITY ? ", bad parity" : "",
-	    dfl & SERIO_TIMEOUT ? ", timeout" : "");
+	filter_dbg(port->filter_dbg, data, "<- i8042 (interrupt, %d, %d%s%s)\n",
+		   port_no, irq,
+		   dfl & SERIO_PARITY ? ", bad parity" : "",
+		   dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
 	filtered = i8042_filter(data, str, serio);
 
@@ -1329,6 +1339,13 @@ static void __init i8042_register_ports(void)
 				i8042_ports[i].irq);
 			serio_register_port(serio);
 			device_set_wakeup_capable(&serio->dev, true);
+#ifdef DEBUG
+			if (i8042_ports[i].irq == I8042_KBD_IRQ) {
+				bus_register_notifier(
+					serio->dev.bus,
+					&i8042_kbd_bind_notifier_block);
+			}
+#endif
 		}
 	}
 }
@@ -1338,8 +1355,17 @@ static void i8042_unregister_ports(void)
 	int i;
 
 	for (i = 0; i < I8042_NUM_PORTS; i++) {
-		if (i8042_ports[i].serio) {
-			serio_unregister_port(i8042_ports[i].serio);
+		struct serio *serio = i8042_ports[i].serio;
+
+		if (serio) {
+#ifdef DEBUG
+			if (i8042_ports[i].irq == I8042_KBD_IRQ) {
+				bus_unregister_notifier(
+					serio->dev.bus,
+					&i8042_kbd_bind_notifier_block);
+			}
+#endif
+			serio_unregister_port(serio);
 			i8042_ports[i].serio = NULL;
 		}
 	}
@@ -1438,6 +1464,22 @@ static int __init i8042_setup_kbd(void)
 	return error;
 }
 
+#ifdef DEBUG
+static int i8042_kbd_bind_notifier(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct i8042_port *port = to_serio_port(dev)->port_data;
+
+	if (action == BUS_NOTIFY_BOUND_DRIVER)
+		port->filter_dbg = true;
+	else if (action == BUS_NOTIFY_UNBOUND_DRIVER)
+		port->filter_dbg = false;
+
+	return 0;
+}
+#endif
+
 static int __init i8042_probe(struct platform_device *dev)
 {
 	int error;
@@ -1507,6 +1549,12 @@ static struct platform_driver i8042_driver = {
 	.shutdown	= i8042_shutdown,
 };
 
+#ifdef DEBUG
+static struct notifier_block i8042_kbd_bind_notifier_block = {
+	.notifier_call = i8042_kbd_bind_notifier,
+};
+#endif
+
 static int __init i8042_init(void)
 {
 	struct platform_device *pdev;
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
-- 
2.4.3
