From: Mark Laws <mdl@60hz.org>
Subject: [PATCH] Input: i8042 - Fix console keyboard support on Gen2 Hyper-V VMs
Date: Tue, 14 Jun 2016 05:45:51 +0900
Message-ID: <20160613204551.1746-2-mdl@60hz.org>
References: <20160613143841.531-2-mdl@60hz.org>
 <20160613204551.1746-1-mdl@60hz.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34649 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422893AbcFMUqR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2016 16:46:17 -0400
Received: by mail-pa0-f65.google.com with SMTP id ug1so11103138pab.1
        for <linux-input@vger.kernel.org>; Mon, 13 Jun 2016 13:46:17 -0700 (PDT)
In-Reply-To: <20160613204551.1746-1-mdl@60hz.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mark Laws <mdl@60hz.org>, kys@microsoft.com, dmitry.torokhov@gmail.com, arjan.van.de.ven@intel.com

As explained in 1407814240-4275-1-git-send-email-decui@microsoft.com:

> hyperv_keyboard invokes serio_interrupt(), which needs a valid serio
> driver like atkbd.c.  atkbd.c depends on libps2.c because it invokes
> ps2_command().  libps2.c depends on i8042.c because it invokes
> i8042_check_port_owner().  As a result, hyperv_keyboard actually
> depends on i8042.c.
>
> For a Generation 2 Hyper-V VM (meaning no i8042 device emulated), if a
> Linux VM (like Arch Linux) happens to configure CONFIG_SERIO_I8042=m
> rather than =y, atkbd.ko can't load because i8042.ko can't load(due to
> no i8042 device emulated) and finally hyperv_keyboard can't work and
> the user can't input: https://bugs.archlinux.org/task/39820
> (Ubuntu/RHEL/SUSE aren't affected since they use CONFIG_SERIO_I8042=y)

This eliminates the transitive dependency on i8042.c by moving the
symbols libps2.c depends on to a new module, libi8042.c.

Signed-off-by: Mark Laws <mdl@60hz.org>
---
 drivers/input/keyboard/Kconfig |  2 +-
 drivers/input/serio/Kconfig    |  7 ++++-
 drivers/input/serio/Makefile   |  1 +
 drivers/input/serio/i8042.c    | 48 ---------------------------------
 drivers/input/serio/i8042.h    |  7 -----
 drivers/input/serio/libi8042.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 drivers/input/serio/libps2.c   |  2 +-
 include/linux/i8042.h          | 17 +-----------
 include/linux/libi8042.h       | 55 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 125 insertions(+), 74 deletions(-)
 create mode 100644 drivers/input/serio/libi8042.c
 create mode 100644 include/linux/libi8042.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 509608c..98c5425 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -71,7 +71,7 @@ config KEYBOARD_ATKBD
 	default y
 	select SERIO
 	select SERIO_LIBPS2
-	select SERIO_I8042 if ARCH_MIGHT_HAVE_PC_SERIO
+	select SERIO_LIBI8042 if ARCH_MIGHT_HAVE_PC_SERIO
 	select SERIO_GSCPS2 if GSC
 	help
 	  Say Y here if you want to use a standard AT or PS/2 keyboard. Usually
diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index c3d05b4..a8ca89c 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -25,10 +25,15 @@ config ARCH_MIGHT_HAVE_PC_SERIO
 
 if SERIO
 
+config SERIO_LIBI8042
+	tristate "i8042 driver library"
+	default y
+
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller"
 	default y
 	depends on ARCH_MIGHT_HAVE_PC_SERIO
+	select SERIO_LIBI8042
 	help
 	  i8042 is the chip over which the standard AT keyboard and PS/2
 	  mouse are connected to the computer. If you use these devices,
@@ -176,7 +181,7 @@ config SERIO_MACEPS2
 
 config SERIO_LIBPS2
 	tristate "PS/2 driver library"
-	depends on SERIO_I8042 || SERIO_I8042=n
+	depends on SERIO_LIBI8042 || SERIO_LIBI8042=n
 	help
 	  Say Y here if you are using a driver for device connected
 	  to a PS/2 port, such as PS/2 mouse or standard AT keyboard.
diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
index 2374ef9..b3a806f 100644
--- a/drivers/input/serio/Makefile
+++ b/drivers/input/serio/Makefile
@@ -5,6 +5,7 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_SERIO)		+= serio.o
+obj-$(CONFIG_SERIO_LIBI8042)	+= libi8042.o
 obj-$(CONFIG_SERIO_I8042)	+= i8042.o
 obj-$(CONFIG_SERIO_PARKBD)	+= parkbd.o
 obj-$(CONFIG_SERIO_SERPORT)	+= serport.o
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 4541957..707bb19 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -107,30 +107,9 @@ static char i8042_aux_firmware_id[128];
  */
 static DEFINE_SPINLOCK(i8042_lock);
 
-/*
- * Writers to AUX and KBD ports as well as users issuing i8042_command
- * directly should acquire i8042_mutex (by means of calling
- * i8042_lock_chip() and i8042_unlock_ship() helpers) to ensure that
- * they do not disturb each other (unfortunately in many i8042
- * implementations write to one of the ports will immediately abort
- * command that is being processed by another port).
- */
-static DEFINE_MUTEX(i8042_mutex);
-
-struct i8042_port {
-	struct serio *serio;
-	int irq;
-	bool exists;
-	bool driver_bound;
-	signed char mux;
-};
-
 #define I8042_KBD_PORT_NO	0
 #define I8042_AUX_PORT_NO	1
 #define I8042_MUX_PORT_NO	2
-#define I8042_NUM_PORTS		(I8042_NUM_MUX_PORTS + 2)
-
-static struct i8042_port i8042_ports[I8042_NUM_PORTS];
 
 static unsigned char i8042_initial_ctr;
 static unsigned char i8042_ctr;
@@ -145,18 +124,6 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id);
 static bool (*i8042_platform_filter)(unsigned char data, unsigned char str,
 				     struct serio *serio);
 
-void i8042_lock_chip(void)
-{
-	mutex_lock(&i8042_mutex);
-}
-EXPORT_SYMBOL(i8042_lock_chip);
-
-void i8042_unlock_chip(void)
-{
-	mutex_unlock(&i8042_mutex);
-}
-EXPORT_SYMBOL(i8042_unlock_chip);
-
 int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
 					struct serio *serio))
 {
@@ -1373,21 +1340,6 @@ static void i8042_unregister_ports(void)
 	}
 }
 
-/*
- * Checks whether port belongs to i8042 controller.
- */
-bool i8042_check_port_owner(const struct serio *port)
-{
-	int i;
-
-	for (i = 0; i < I8042_NUM_PORTS; i++)
-		if (i8042_ports[i].serio == port)
-			return true;
-
-	return false;
-}
-EXPORT_SYMBOL(i8042_check_port_owner);
-
 static void i8042_free_irqs(void)
 {
 	if (i8042_aux_irq_registered)
diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index 1db0a40..7de98ac 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -54,13 +54,6 @@
 #define I8042_BUFFER_SIZE	16
 
 /*
- * Number of AUX ports on controllers supporting active multiplexing
- * specification
- */
-
-#define I8042_NUM_MUX_PORTS	4
-
-/*
  * Debug.
  */
 
diff --git a/drivers/input/serio/libi8042.c b/drivers/input/serio/libi8042.c
new file mode 100644
index 0000000..4505bac
--- /dev/null
+++ b/drivers/input/serio/libi8042.c
@@ -0,0 +1,60 @@
+/*
+ *  i8042 driver shared dependencies
+ *
+ *  Copyright (c) 1999-2004 Vojtech Pavlik
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/libi8042.h>
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
+MODULE_DESCRIPTION("i8042 driver shared dependencies");
+MODULE_LICENSE("GPL");
+
+/*
+ * Writers to AUX and KBD ports as well as users issuing i8042_command
+ * directly should acquire i8042_mutex (by means of calling
+ * i8042_lock_chip() and i8042_unlock_ship() helpers) to ensure that
+ * they do not disturb each other (unfortunately in many i8042
+ * implementations write to one of the ports will immediately abort
+ * command that is being processed by another port).
+ */
+static DEFINE_MUTEX(i8042_mutex);
+
+struct i8042_port i8042_ports[I8042_NUM_PORTS];
+EXPORT_SYMBOL(i8042_ports);
+
+void i8042_lock_chip(void)
+{
+	mutex_lock(&i8042_mutex);
+}
+EXPORT_SYMBOL(i8042_lock_chip);
+
+void i8042_unlock_chip(void)
+{
+	mutex_unlock(&i8042_mutex);
+}
+EXPORT_SYMBOL(i8042_unlock_chip);
+
+/*
+ * Checks whether port belongs to i8042 controller.
+ */
+bool i8042_check_port_owner(const struct serio *port)
+{
+	int i;
+
+	for (i = 0; i < I8042_NUM_PORTS; i++)
+		if (i8042_ports[i].serio == port)
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL(i8042_check_port_owner);
diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 316f2c8..62c0059 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -17,7 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/serio.h>
-#include <linux/i8042.h>
+#include <linux/libi8042.h>
 #include <linux/libps2.h>
 
 #define DRIVER_DESC	"PS/2 driver library"
diff --git a/include/linux/i8042.h b/include/linux/i8042.h
index 0f9bafa..77aed40 100644
--- a/include/linux/i8042.h
+++ b/include/linux/i8042.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/libi8042.h>
 
 /*
  * Standard commands.
@@ -59,10 +60,7 @@ struct serio;
 
 #if defined(CONFIG_SERIO_I8042) || defined(CONFIG_SERIO_I8042_MODULE)
 
-void i8042_lock_chip(void);
-void i8042_unlock_chip(void);
 int i8042_command(unsigned char *param, int command);
-bool i8042_check_port_owner(const struct serio *);
 int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
 					struct serio *serio));
 int i8042_remove_filter(bool (*filter)(unsigned char data, unsigned char str,
@@ -70,24 +68,11 @@ int i8042_remove_filter(bool (*filter)(unsigned char data, unsigned char str,
 
 #else
 
-static inline void i8042_lock_chip(void)
-{
-}
-
-static inline void i8042_unlock_chip(void)
-{
-}
-
 static inline int i8042_command(unsigned char *param, int command)
 {
 	return -ENODEV;
 }
 
-static inline bool i8042_check_port_owner(const struct serio *serio)
-{
-	return false;
-}
-
 static inline int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
 					struct serio *serio))
 {
diff --git a/include/linux/libi8042.h b/include/linux/libi8042.h
new file mode 100644
index 0000000..5a730f0
--- /dev/null
+++ b/include/linux/libi8042.h
@@ -0,0 +1,55 @@
+#ifndef _LINUX_LIBI8042_H
+#define _LINUX_LIBI8042_H
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/types.h>
+
+/*
+ * Number of AUX ports on controllers supporting active multiplexing
+ * specification
+ */
+
+#define I8042_NUM_MUX_PORTS	4
+#define I8042_NUM_PORTS		(I8042_NUM_MUX_PORTS + 2)
+
+struct serio;
+
+struct i8042_port {
+	struct serio *serio;
+	int irq;
+	bool exists;
+	bool driver_bound;
+	signed char mux;
+};
+
+#if defined(CONFIG_SERIO_I8042) || defined(CONFIG_SERIO_I8042_MODULE)
+
+extern struct i8042_port i8042_ports[I8042_NUM_PORTS];
+
+void i8042_lock_chip(void);
+void i8042_unlock_chip(void);
+bool i8042_check_port_owner(const struct serio *);
+
+#else
+
+static inline void i8042_lock_chip(void)
+{
+}
+
+static inline void i8042_unlock_chip(void)
+{
+}
+
+static inline bool i8042_check_port_owner(const struct serio *serio)
+{
+	return false;
+}
+
+#endif
+
+#endif
-- 
2.8.3

