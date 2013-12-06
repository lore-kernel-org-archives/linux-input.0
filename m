From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH V2] input synaptics-rmi4: Reorder declarations in rmi_bus.c
Date: Thu, 5 Dec 2013 16:29:16 -0800
Message-ID: <1386289756-12429-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:60544 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3LFA3V (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Dec 2013 19:29:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

This patch implements changes to the synaptics-rmi4 branch of
Dmitry's input tree.  The base for the patch is commit
8ca01dc61a42b6f7bcba052a8c084000f7057a34.

This patch primarily reorders the various declarations in rmi_bus.c in order to
group related elements together, along with some typo fixes.  The code is still
horribly broken, but this change should make the following fixes easier to
 review.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Joerie de Gram <j.de.gram@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---
 drivers/input/rmi4/rmi_bus.c | 189 +++++++++++++++++++++----------------------
 1 file changed, 90 insertions(+), 99 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 88f60ca..d9c450b 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011, 2012 Synaptics Incorporated
+ * Copyright (c) 2011-2013 Synaptics Incorporated
  * Copyright (c) 2011 Unixphere
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -19,77 +19,20 @@
 #include "rmi_bus.h"
 #include "rmi_driver.h"
 
-static int rmi_function_match(struct device *dev, struct device_driver *drv)
-{
-	struct rmi_function_handler *handler = to_rmi_function_handler(drv);
-	struct rmi_function *fn = to_rmi_function(dev);
-
-	return fn->fd.function_number == handler->func;
-}
-
-static int rmi_bus_match(struct device *dev, struct device_driver *drv)
-{
-	bool physical = rmi_is_physical_device(dev);
-
-	/* First see if types are not compatible */
-	if (physical != rmi_is_physical_driver(drv))
-		return 0;
-
-	return physical || rmi_function_match(dev, drv);
-}
-
-struct bus_type rmi_bus_type = {
-	.match		= rmi_bus_match,
-	.name		= "rmi",
-};
-
-#ifdef CONFIG_RMI4_DEBUG
-
-static struct dentry *rmi_debugfs_root;
-
-static void rmi_bus_setup_debugfs(void)
-{
-	rmi_debugfs_root = debugfs_create_dir(rmi_bus_type.name, NULL);
-	if (!rmi_debugfs_root)
-		pr_err("%s: Failed to create debugfs root\n",
-		       __func__);
-}
-
-static void rmi_bus_teardown_debugfs(void)
-{
-	if (rmi_debugfs_root)
-		debugfs_remove_recursive(rmi_debugfs_root);
-}
-
-#else
-
-static void rmi_bus_setup_debugfs(void)
-{
-}
-
-static void rmi_bus_teardown_debugfs(void)
-{
-}
-
-#endif
-
-
 /*
  * RMI Physical devices
  *
  * Physical RMI device consists of several functions serving particular
- * purpose. For example F11 is a 2D touch sensor while F10 is a generic
+ * purpose. For example F11 is a 2D touch sensor while F01 is a generic
  * function present in every RMI device.
  */
 
 static void rmi_release_device(struct device *dev)
 {
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
-
 	kfree(rmi_dev);
 }
 
-/* Device type for physical RMI devices */
 struct device_type rmi_device_type = {
 	.name		= "rmi_sensor",
 	.release	= rmi_release_device,
@@ -118,7 +61,7 @@ static void rmi_physical_teardown_debugfs(struct rmi_device *rmi_dev)
 
 #else
 
-static void rmi_physocal_setup_debugfs(struct rmi_device *rmi_dev)
+static void rmi_physical_setup_debugfs(struct rmi_device *rmi_dev)
 {
 }
 
@@ -128,7 +71,6 @@ static void rmi_physical_teardown_debugfs(struct rmi_device *rmi_dev)
 
 #endif
 
-
 /**
  * rmi_register_physical_device - register a physical device connection on the RMI
  * bus.  Physical drivers provide communication from the devices on the bus to
@@ -174,7 +116,7 @@ int rmi_register_physical_device(struct rmi_phys_device *phys)
 
 	return 0;
 }
-EXPORT_SYMBOL(rmi_register_physical_device);
+EXPORT_SYMBOL_GPL(rmi_register_physical_device);
 
 /**
  * rmi_unregister_physical_device - unregister a physical device connection
@@ -191,18 +133,14 @@ void rmi_unregister_physical_device(struct rmi_phys_device *phys)
 EXPORT_SYMBOL(rmi_unregister_physical_device);
 
 
-/*
- * RMI Function devices and their handlers
- */
+/* Function specific stuff */
 
 static void rmi_release_function(struct device *dev)
 {
 	struct rmi_function *fn = to_rmi_function(dev);
-
 	kfree(fn);
 }
 
-/* Device type for RMI Function devices */
 struct device_type rmi_function_type = {
 	.name		= "rmi_function",
 	.release	= rmi_release_function,
@@ -244,35 +182,12 @@ static void rmi_function_teardown_debugfs(struct rmi_function *fn)
 
 #endif
 
-int rmi_register_function(struct rmi_function *fn)
+static int rmi_function_match(struct device *dev, struct device_driver *drv)
 {
-	struct rmi_device *rmi_dev = fn->rmi_dev;
-	int error;
-
-	dev_set_name(&fn->dev, "%s.fn%02x",
-		     dev_name(&rmi_dev->dev), fn->fd.function_number);
-
-	fn->dev.parent = &rmi_dev->dev;
-	fn->dev.type = &rmi_function_type;
-	fn->dev.bus = &rmi_bus_type;
-
-	error = device_register(&fn->dev);
-	if (error) {
-		dev_err(&rmi_dev->dev,
-			"Failed device_register function device %s\n",
-			dev_name(&fn->dev));
-	}
-
-	dev_dbg(&rmi_dev->dev, "Registered F%02X.\n", fn->fd.function_number);
-
-	rmi_function_setup_debugfs(fn);
-	return 0;
-}
+	struct rmi_function_handler *handler = to_rmi_function_handler(drv);
+	struct rmi_function *fn = to_rmi_function(dev);
 
-void rmi_unregister_function(struct rmi_function *fn)
-{
-	rmi_function_teardown_debugfs(fn);
-	device_unregister(&fn->dev);
+	return fn->fd.function_number == handler->func;
 }
 
 static int rmi_function_probe(struct device *dev)
@@ -302,6 +217,38 @@ static int rmi_function_remove(struct device *dev)
 	return 0;
 }
 
+int rmi_register_function(struct rmi_function *fn)
+{
+	struct rmi_device *rmi_dev = fn->rmi_dev;
+	int error;
+
+	dev_set_name(&fn->dev, "%s.fn%02x",
+		     dev_name(&rmi_dev->dev), fn->fd.function_number);
+
+	fn->dev.parent = &rmi_dev->dev;
+	fn->dev.type = &rmi_function_type;
+	fn->dev.bus = &rmi_bus_type;
+
+	error = device_register(&fn->dev);
+	if (error) {
+		dev_err(&rmi_dev->dev,
+			"Failed device_register function device %s\n",
+			dev_name(&fn->dev));
+		return error;
+	}
+
+	dev_dbg(&rmi_dev->dev, "Registered F%02X.\n", fn->fd.function_number);
+
+	rmi_function_setup_debugfs(fn);
+	return 0;
+}
+
+void rmi_unregister_function(struct rmi_function *fn)
+{
+	rmi_function_teardown_debugfs(fn);
+	device_unregister(&fn->dev);
+}
+
 /**
  * rmi_register_function_handler - register a handler for an RMI function
  * @handler: RMI handler that should be registered.
@@ -334,7 +281,7 @@ int __rmi_register_function_handler(struct rmi_function_handler *handler,
 
 	return 0;
 }
-EXPORT_SYMBOL(__rmi_register_function_handler);
+EXPORT_SYMBOL_GPL(__rmi_register_function_handler);
 
 /**
  * rmi_unregister_function_handler - unregister given RMI function handler
@@ -347,11 +294,55 @@ void rmi_unregister_function_handler(struct rmi_function_handler *handler)
 {
 	driver_unregister(&handler->driver);
 }
-EXPORT_SYMBOL(rmi_unregister_function_handler);
+EXPORT_SYMBOL_GPL(rmi_unregister_function_handler);
 
-/*
- * Bus registration and tear-down
- */
+/* Bus specific stuff */
+
+static int rmi_bus_match(struct device *dev, struct device_driver *drv)
+{
+	bool physical = rmi_is_physical_device(dev);
+
+	/* First see if types are not compatible */
+	if (physical != rmi_is_physical_driver(drv))
+		return 0;
+
+	return physical || rmi_function_match(dev, drv);
+}
+
+struct bus_type rmi_bus_type = {
+	.match		= rmi_bus_match,
+	.name		= "rmi",
+};
+
+#ifdef CONFIG_RMI4_DEBUG
+
+static struct dentry *rmi_debugfs_root;
+
+static void rmi_bus_setup_debugfs(void)
+{
+	rmi_debugfs_root = debugfs_create_dir(rmi_bus_type.name, NULL);
+	if (!rmi_debugfs_root)
+		pr_err("%s: Failed to create debugfs root\n",
+		       __func__);
+}
+
+static void rmi_bus_teardown_debugfs(void)
+{
+	if (rmi_debugfs_root)
+		debugfs_remove_recursive(rmi_debugfs_root);
+}
+
+#else
+
+static void rmi_bus_setup_debugfs(void)
+{
+}
+
+static void rmi_bus_teardown_debugfs(void)
+{
+}
+
+#endif
 
 static int __init rmi_bus_init(void)
 {
