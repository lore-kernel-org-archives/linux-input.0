From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH 01/04] input: RMI4 core files
Date: Wed, 13 Nov 2013 15:39:29 -0800
Message-ID: <1384385972-1686-2-git-send-email-cheiny@synaptics.com>
References: <1384385972-1686-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:16061 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab3KMXjs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Nov 2013 18:39:48 -0500
In-Reply-To: <1384385972-1686-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

In addition to the changes described in part 0/5, this implements the following:

* reorders declarations in rmi_bus.c to group related items near each other
(for instance, things relating to function drivers and devices are now 
located together).

* fixes some bugs in the ATTN gpio initialization code.

* adds rmi_control.h, for use by control/debug modules.

* adds rmi_version.h.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Joeri de Gram <j.de.gram@gmail.com>

---

 drivers/input/rmi4/rmi_bus.c     | 397 +++++++++++--------
 drivers/input/rmi4/rmi_bus.h     | 146 +++----
 drivers/input/rmi4/rmi_control.h |  58 +++
 drivers/input/rmi4/rmi_driver.c  | 818 +++++++++++++++++++--------------------
 drivers/input/rmi4/rmi_driver.h  |  97 ++---
 drivers/input/rmi4/rmi_version.h |  16 +
 6 files changed, 827 insertions(+), 705 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 88f60ca..5711866 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011, 2012 Synaptics Incorporated
+ * Copyright (c) 2011-2013 Synaptics Incorporated
  * Copyright (c) 2011 Unixphere
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -16,61 +16,15 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/debugfs.h>
+
 #include "rmi_bus.h"
+#include "rmi_control.h"
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
+DEFINE_MUTEX(rmi_bus_mutex);
 
 #ifdef CONFIG_RMI4_DEBUG
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
+static struct dentry *rmi_bus_debugfs_root;
 #endif
 
 
@@ -85,29 +39,23 @@ static void rmi_bus_teardown_debugfs(void)
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
 };
-
-bool rmi_is_physical_device(struct device *dev)
-{
-	return dev->type == &rmi_device_type;
-}
+EXPORT_SYMBOL_GPL(rmi_device_type);
 
 #if CONFIG_RMI4_DEBUG
 
 static void rmi_physical_setup_debugfs(struct rmi_device *rmi_dev)
 {
 	rmi_dev->debugfs_root = debugfs_create_dir(dev_name(&rmi_dev->dev),
-						   rmi_debugfs_root);
+						   rmi_bus_debugfs_root);
 	if (!rmi_dev->debugfs_root)
-		dev_warn(&rmi_dev->dev, "Failed to create debugfs root.\n");
+		dev_warn(&rmi_dev->dev, "Failed to create sensor debugfs root.\n");
 }
 
 static void rmi_physical_teardown_debugfs(struct rmi_device *rmi_dev)
@@ -118,7 +66,7 @@ static void rmi_physical_teardown_debugfs(struct rmi_device *rmi_dev)
 
 #else
 
-static void rmi_physocal_setup_debugfs(struct rmi_device *rmi_dev)
+static void rmi_physical_setup_debugfs(struct rmi_device *rmi_dev)
 {
 }
 
@@ -128,91 +76,100 @@ static void rmi_physical_teardown_debugfs(struct rmi_device *rmi_dev)
 
 #endif
 
-
 /**
- * rmi_register_physical_device - register a physical device connection on the RMI
- * bus.  Physical drivers provide communication from the devices on the bus to
- * the RMI4 sensor on a bus such as SPI, I2C, and so on.
+ * rmi_register_transport_device - register a transport connection on the RMI
+ * bus.  Transport drivers provide communication with an RMI4 devices residing
+ * on a bus such as SPI, I2C, and so on.
  *
- * @phys: the physical device to register
+ * @transport: the device to register
  */
-int rmi_register_physical_device(struct rmi_phys_device *phys)
+int rmi_register_transport_device(struct rmi_transport_device *xport)
 {
-	static atomic_t physical_device_count = ATOMIC_INIT(0);
-	struct rmi_device_platform_data *pdata = phys->dev->platform_data;
+	static atomic_t transport_dev_count = ATOMIC_INIT(0);
+	struct rmi_device_platform_data *pdata = xport->dev->platform_data;
 	struct rmi_device *rmi_dev;
 	int error;
 
 	if (!pdata) {
-		dev_err(phys->dev, "no platform data!\n");
+		dev_err(xport->dev, "no platform data!\n");
 		return -EINVAL;
 	}
 
-	rmi_dev = devm_kzalloc(phys->dev,
+	rmi_dev = devm_kzalloc(xport->dev,
 				sizeof(struct rmi_device), GFP_KERNEL);
 	if (!rmi_dev)
 		return -ENOMEM;
 
-	rmi_dev->phys = phys;
-	rmi_dev->number = atomic_inc_return(&physical_device_count) - 1;
+	rmi_dev->xport = xport;
+	rmi_dev->number = atomic_inc_return(&transport_dev_count) - 1;
 
 	dev_set_name(&rmi_dev->dev, "sensor%02d", rmi_dev->number);
 
 	rmi_dev->dev.bus = &rmi_bus_type;
 	rmi_dev->dev.type = &rmi_device_type;
 
-	phys->rmi_dev = rmi_dev;
+	xport->rmi_dev = rmi_dev;
+
+	rmi_physical_setup_debugfs(rmi_dev);
 
 	error = device_register(&rmi_dev->dev);
 	if (error)
 		return error;
 
-	rmi_physical_setup_debugfs(rmi_dev);
-
-	dev_dbg(phys->dev, "%s: Registered %s as %s.\n", __func__,
+	dev_dbg(xport->dev, "%s: Registered %s as %s.\n", __func__,
 		pdata->sensor_name, dev_name(&rmi_dev->dev));
 
 	return 0;
 }
-EXPORT_SYMBOL(rmi_register_physical_device);
+EXPORT_SYMBOL_GPL(rmi_register_transport_device);
 
 /**
- * rmi_unregister_physical_device - unregister a physical device connection
- * @phys: the physical driver to unregister
+ * rmi_unregister_transport_device - unregister a transport connection
+ * @xport: the connection to unregister
  *
  */
-void rmi_unregister_physical_device(struct rmi_phys_device *phys)
+void rmi_unregister_transport_device(struct rmi_transport_device *xport)
 {
-	struct rmi_device *rmi_dev = phys->rmi_dev;
+	struct rmi_device *rmi_dev = xport->rmi_dev;
 
 	rmi_physical_teardown_debugfs(rmi_dev);
+
 	device_unregister(&rmi_dev->dev);
 }
-EXPORT_SYMBOL(rmi_unregister_physical_device);
+EXPORT_SYMBOL_GPL(rmi_unregister_transport_device);
 
 
-/*
- * RMI Function devices and their handlers
- */
+static bool rmi_is_physical_driver(struct device_driver *drv)
+{
+	return drv == &rmi_physical_driver.driver;
+}
 
-static void rmi_release_function(struct device *dev)
+static int rmi_physical_remove(struct device *dev)
 {
-	struct rmi_function *fn = to_rmi_function(dev);
+	struct rmi_driver *driver;
+	struct rmi_device *rmi_dev = to_rmi_device(dev);
 
-	kfree(fn);
+	driver = to_rmi_driver(dev->driver);
+
+	if (driver->remove)
+		return driver->remove(rmi_dev);
+	return 0;
 }
 
-/* Device type for RMI Function devices */
-struct device_type rmi_function_type = {
-	.name		= "rmi_function",
-	.release	= rmi_release_function,
-};
+/* Function specific stuff */
 
-bool rmi_is_function_device(struct device *dev)
+static void rmi_release_function_dev(struct device *dev)
 {
-	return dev->type == &rmi_function_type;
+	struct rmi_function *fn = to_rmi_function(dev);
+	kfree(fn);
 }
 
+struct device_type rmi_function_type = {
+	.name    = "rmi_function",
+	.release = rmi_release_function_dev,
+};
+EXPORT_SYMBOL_GPL(rmi_function_type);
+
 #if CONFIG_RMI4_DEBUG
 
 static void rmi_function_setup_debugfs(struct rmi_function *fn)
@@ -244,119 +201,235 @@ static void rmi_function_teardown_debugfs(struct rmi_function *fn)
 
 #endif
 
-int rmi_register_function(struct rmi_function *fn)
+static int rmi_function_match(struct device *dev, struct device_driver *drv)
 {
-	struct rmi_device *rmi_dev = fn->rmi_dev;
-	int error;
+	struct rmi_function_driver *fn_drv = to_rmi_function_driver(drv);
+	struct rmi_function *fn = to_rmi_function(dev);
 
-	dev_set_name(&fn->dev, "%s.fn%02x",
-		     dev_name(&rmi_dev->dev), fn->fd.function_number);
+	return fn->fd.function_number == fn_drv->func;
+}
 
-	fn->dev.parent = &rmi_dev->dev;
-	fn->dev.type = &rmi_function_type;
-	fn->dev.bus = &rmi_bus_type;
+static int rmi_function_probe(struct device *dev)
+{
+	struct rmi_function_driver *fn_drv;
+	struct rmi_function *fn = to_rmi_function(dev);
 
-	error = device_register(&fn->dev);
-	if (error) {
-		dev_err(&rmi_dev->dev,
-			"Failed device_register function device %s\n",
-			dev_name(&fn->dev));
-	}
+	fn_drv = to_rmi_function_driver(dev->driver);
 
-	dev_dbg(&rmi_dev->dev, "Registered F%02X.\n", fn->fd.function_number);
+	if (fn_drv->probe)
+		return fn_drv->probe(fn);
 
-	rmi_function_setup_debugfs(fn);
 	return 0;
 }
 
-void rmi_unregister_function(struct rmi_function *fn)
+static int rmi_function_remove(struct device *dev)
 {
-	rmi_function_teardown_debugfs(fn);
-	device_unregister(&fn->dev);
+	struct rmi_function_driver *fn_drv;
+	struct rmi_function *fn = to_rmi_function(dev);
+
+	fn_drv = to_rmi_function_driver(dev->driver);
+
+	if (fn_drv->remove)
+		return fn_drv->remove(fn);
+
+	return 0;
 }
 
-static int rmi_function_probe(struct device *dev)
+int rmi_register_function_dev(struct rmi_function *fn)
 {
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct rmi_function_handler *handler =
-					to_rmi_function_handler(dev->driver);
+	struct rmi_device *rmi_dev = fn->rmi_dev;
 	int error;
 
-	if (handler->probe) {
-		error = handler->probe(fn);
+	dev_set_name(&fn->dev, "%s.fn%02x", dev_name(&rmi_dev->dev),
+		     fn->fd.function_number);
+
+	fn->dev.parent = &rmi_dev->dev;
+	fn->dev.type = &rmi_function_type;
+	fn->dev.bus = &rmi_bus_type;
+
+	error = device_register(&fn->dev);
+	if (error) {
+		dev_err(&rmi_dev->dev, "Failed device register function device %s.\n",
+			dev_name(&fn->dev));
 		return error;
 	}
 
+	dev_dbg(&rmi_dev->dev, "Registered F%02X.\n",
+		fn->fd.function_number);
+
+	rmi_function_setup_debugfs(fn);
 	return 0;
 }
 
-static int rmi_function_remove(struct device *dev)
+void rmi_unregister_function_dev(struct rmi_function *fn)
 {
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct rmi_function_handler *handler =
-					to_rmi_function_handler(dev->driver);
-
-	if (handler->remove)
-		handler->remove(fn);
-
-	return 0;
+	rmi_function_teardown_debugfs(fn);
+	device_unregister(&fn->dev);
 }
 
 /**
- * rmi_register_function_handler - register a handler for an RMI function
- * @handler: RMI handler that should be registered.
- * @module: pointer to module that implements the handler
- * @mod_name: name of the module implementing the handler
+ * rmi_register_function_driver - register a driver for an RMI function
+ * @fn_drv: RMI driver that should be registered.
+ * @module: pointer to module that implements the driver
+ * @mod_name: name of the module implementing the driver
  *
- * This function performs additional setup of RMI function handler and
+ * This function performs additional setup of RMI function driver and
  * registers it with the RMI core so that it can be bound to
  * RMI function devices.
  */
-int __rmi_register_function_handler(struct rmi_function_handler *handler,
-				     struct module *owner,
-				     const char *mod_name)
+int __rmi_register_function_driver(struct rmi_function_driver *fn_drv,
+				   struct module *owner,
+				   const char *mod_name)
 {
-	struct device_driver *driver = &handler->driver;
+	struct device_driver *driver = &fn_drv->driver;
 	int error;
 
 	driver->bus = &rmi_bus_type;
 	driver->owner = owner;
 	driver->mod_name = mod_name;
 	driver->probe = rmi_function_probe;
-	driver->remove = rmi_function_remove;
 
-	error = driver_register(&handler->driver);
+	error = driver_register(&fn_drv->driver);
 	if (error) {
 		pr_err("driver_register() failed for %s, error: %d\n",
-			handler->driver.name, error);
+		       fn_drv->driver.name, error);
 		return error;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL(__rmi_register_function_handler);
+EXPORT_SYMBOL_GPL(__rmi_register_function_driver);
 
 /**
- * rmi_unregister_function_handler - unregister given RMI function handler
- * @handler: RMI handler that should be unregistered.
+ * rmi_unregister_function_driver - unregister given RMI function driver
+ * @fn_drv: RMI driver that should be unregistered.
  *
- * This function unregisters given function handler from RMI core which
+ * This function unregisters given function driver from RMI core which
  * causes it to be unbound from the function devices.
  */
-void rmi_unregister_function_handler(struct rmi_function_handler *handler)
+void rmi_unregister_function_driver(struct rmi_function_driver *fn_drv)
 {
-	driver_unregister(&handler->driver);
+	driver_unregister(&fn_drv->driver);
 }
-EXPORT_SYMBOL(rmi_unregister_function_handler);
+EXPORT_SYMBOL_GPL(rmi_unregister_function_driver);
 
-/*
- * Bus registration and tear-down
+/* Bus specific stuff */
+
+static int rmi_bus_match(struct device *dev, struct device_driver *drv)
+{
+	bool sensor = rmi_is_physical_device(dev);
+
+	/* First see if types are not compatible.
+	 */
+	if (sensor != rmi_is_physical_driver(drv))
+		return 0;
+
+	return sensor || rmi_function_match(dev, drv);
+}
+
+static int rmi_bus_remove(struct device *dev)
+{
+	if (rmi_is_function_device(dev))
+		return rmi_function_remove(dev);
+	else if (rmi_is_physical_device(dev))
+		return rmi_physical_remove(dev);
+	return -EINVAL;
+}
+
+#ifdef CONFIG_PM
+static int rmi_bus_suspend(struct device *dev)
+{
+	struct device_driver *driver = dev->driver;
+	const struct dev_pm_ops *pm;
+
+	if (!driver)
+		return 0;
+
+	pm = driver->pm;
+	if (pm && pm->suspend)
+		return pm->suspend(dev);
+	if (driver->suspend)
+		return driver->suspend(dev, PMSG_SUSPEND);
+
+	return 0;
+}
+
+static int rmi_bus_resume(struct device *dev)
+{
+	struct device_driver *driver = dev->driver;
+	const struct dev_pm_ops *pm;
+
+	if (!driver)
+		return 0;
+
+	pm = driver->pm;
+	if (pm && pm->resume)
+		return pm->resume(dev);
+	if (driver->resume)
+		return driver->resume(dev);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(rmi_bus_pm_ops,
+			 rmi_bus_suspend, rmi_bus_resume);
+
+struct bus_type rmi_bus_type = {
+	.name		= "rmi",
+	.match		= rmi_bus_match,
+	.remove		= rmi_bus_remove,
+	.pm		= &rmi_bus_pm_ops,
+};
+EXPORT_SYMBOL_GPL(rmi_bus_type);
+
+/**
+ * rmi_for_each_dev - provides a way for other parts of the system to enumerate
+ * the devices on the RMI bus.
+ *
+ * @data - will be passed into the callback function.
+ * @func - will be called for each device.
  */
+int rmi_for_each_dev(void *data, int (*func)(struct device *dev, void *data))
+{
+	int retval;
+	mutex_lock(&rmi_bus_mutex);
+	retval = bus_for_each_dev(&rmi_bus_type, NULL, data, func);
+	mutex_unlock(&rmi_bus_mutex);
+	return retval;
+}
+EXPORT_SYMBOL_GPL(rmi_for_each_dev);
+
+#ifdef CONFIG_RMI4_DEBUG
+static void rmi_bus_setup_debugfs(void)
+{
+	rmi_bus_debugfs_root = debugfs_create_dir(rmi_bus_type.name, NULL);
+	if (!rmi_bus_debugfs_root)
+		pr_err("%s: Failed to create bus debugfs root.\n",
+		       __func__);
+}
+
+static void rmi_bus_teardown_debugfs(void)
+{
+	if (rmi_bus_debugfs_root)
+		debugfs_remove_recursive(rmi_bus_debugfs_root);
+}
+#else
+static void rmi_bus_setup_debugfs(void)
+{
+}
+
+static void rmi_bus_teardown_debugfs(void)
+{
+}
+#endif
 
 static int __init rmi_bus_init(void)
 {
 	int error;
 
+	mutex_init(&rmi_bus_mutex);
+
 	error = bus_register(&rmi_bus_type);
 	if (error) {
 		pr_err("%s: error registering the RMI bus: %d\n",
@@ -364,31 +437,30 @@ static int __init rmi_bus_init(void)
 		return error;
 	}
 
-	error = rmi_register_f01_handler();
+	rmi_bus_setup_debugfs();
+
+	error = rmi_register_function_driver(&rmi_f01_driver);
 	if (error) {
-		pr_err("%s: error registering the RMI F01 handler: %d\n",
+		pr_err("%s: error registering the RMI F01 driver: %d\n",
 			__func__, error);
 		goto err_unregister_bus;
 	}
 
-	error = rmi_register_physical_driver();
+	error = rmi_register_sensor_driver();
 	if (error) {
-		pr_err("%s: error registering the RMI physical driver: %d\n",
+		pr_err("%s: error registering the RMI sensor driver: %d\n",
 			__func__, error);
 		goto err_unregister_f01;
 	}
 
-	rmi_bus_setup_debugfs();
-
 	return 0;
 
 err_unregister_f01:
-	rmi_unregister_f01_handler();
+	rmi_unregister_function_driver(&rmi_f01_driver);
 err_unregister_bus:
 	bus_unregister(&rmi_bus_type);
 	return error;
 }
-module_init(rmi_bus_init);
 
 static void __exit rmi_bus_exit(void)
 {
@@ -396,12 +468,13 @@ static void __exit rmi_bus_exit(void)
 	 * We should only ever get here if all drivers are unloaded, so
 	 * all we have to do at this point is unregister ourselves.
 	 */
-
 	rmi_bus_teardown_debugfs();
-	rmi_unregister_physical_driver();
-	rmi_unregister_f01_handler();
+	rmi_unregister_sensor_driver();
+	rmi_unregister_function_driver(&rmi_f01_driver);
 	bus_unregister(&rmi_bus_type);
 }
+
+module_init(rmi_bus_init);
 module_exit(rmi_bus_exit);
 
 MODULE_AUTHOR("Christopher Heiny <cheiny@synaptics.com");
diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 33e8f1b..85b0c8e 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -22,6 +22,19 @@
 #include <linux/debugfs.h>
 #include <linux/rmi.h>
 
+extern struct bus_type rmi_bus_type;
+
+extern struct device_type rmi_function_type;
+
+#define rmi_is_function_device(dev) \
+	(dev->type == &rmi_function_type)
+
+
+extern struct device_type rmi_device_type;
+
+#define rmi_is_physical_device(dev) \
+	(dev->type == &rmi_device_type)
+
 
 /* Permissions for sysfs attributes.  Since the permissions policy will change
  * on a global basis in the future, rather than edit all sysfs attrs everywhere
@@ -33,14 +46,12 @@
 #define RMI_RW_ATTR (S_IRUGO | S_IWUGO)
 #define RMI_WO_ATTR S_IWUGO
 
-struct rmi_device;
-
 /**
- * struct rmi_function - represents the implementation of an RMI4
- * function for a particular device (basically, a driver for that RMI4 function)
+ * struct rmi_function - represents an a particular RMI4 function on a given
+ * RMI4 sensor.
  *
  * @fd: The function descriptor of the RMI function
- * @rmi_dev: Pointer to the RMI device associated with this function container
+ * @rmi_dev: Pointer to the RMI device associated with this function device
  * @dev: The device associated with this particular function.
  *
  * @num_of_irqs: The number of irqs needed by this function
@@ -49,10 +60,12 @@ struct rmi_device;
  * interrupt handling.
  * @data: Private data pointer
  *
- * @node: entry in physical device list of functions
+ * @list: Used to create a list of function devices.
  * @debugfs_root: used during debugging
+ *
  */
 struct rmi_function {
+
 	struct rmi_function_descriptor fd;
 	struct rmi_device *rmi_dev;
 	struct device dev;
@@ -62,22 +75,17 @@ struct rmi_function {
 	void *data;
 	struct list_head node;
 
-#ifdef CONFIG_RMI4_DEBUG
 	struct dentry *debugfs_root;
-#endif
 };
 
-#define to_rmi_function(d)	container_of(d, struct rmi_function, dev)
-
-bool rmi_is_function_device(struct device *dev);
-
-int __must_check rmi_register_function(struct rmi_function *);
-void rmi_unregister_function(struct rmi_function *);
+#define to_rmi_function(d) \
+	container_of(d, struct rmi_function, dev)
 
 /**
- * struct rmi_function_handler - driver routines for a particular RMI function.
+ * struct rmi_function_driver - driver routines for a particular RMI function.
  *
  * @func: The RMI function number
+ * @probe: Called when the handler is successfully matched to a function device.
  * @reset: Called when a reset of the touch sensor is detected.  The routine
  * should perform any out-of-the-ordinary reset handling that might be
  * necessary.  Restoring of touch sensor configuration registers should be
@@ -87,34 +95,32 @@ void rmi_unregister_function(struct rmi_function *);
  * configuration settings to the device.
  * @attention: Called when the IRQ(s) for the function are set by the touch
  * sensor.
- * @suspend: Should perform any required operations to suspend the particular
- * function.
- * @resume: Should perform any required operations to resume the particular
- * function.
  *
  * All callbacks are expected to return 0 on success, error code on failure.
  */
-struct rmi_function_handler {
+struct rmi_function_driver {
 	struct device_driver driver;
 
 	u8 func;
-
 	int (*probe)(struct rmi_function *fn);
-	void (*remove)(struct rmi_function *fn);
+	int (*remove)(struct rmi_function *fn);
 	int (*config)(struct rmi_function *fn);
 	int (*reset)(struct rmi_function *fn);
 	int (*attention)(struct rmi_function *fn, unsigned long *irq_bits);
 };
 
-#define to_rmi_function_handler(d) \
-		container_of(d, struct rmi_function_handler, driver)
+#define to_rmi_function_driver(d) \
+	container_of(d, struct rmi_function_driver, driver)
 
-int __must_check __rmi_register_function_handler(struct rmi_function_handler *,
-						 struct module *, const char *);
-#define rmi_register_function_handler(handler) \
-	__rmi_register_function_handler(handler, THIS_MODULE, KBUILD_MODNAME)
+int __must_check __rmi_register_function_driver(struct rmi_function_driver *,
+						struct module *, const char *);
+#define rmi_register_function_driver(handler) \
+	__rmi_register_function_driver(handler, THIS_MODULE, KBUILD_MODNAME)
 
-void rmi_unregister_function_handler(struct rmi_function_handler *);
+void rmi_unregister_function_driver(struct rmi_function_driver *);
+
+int __must_check rmi_register_function_dev(struct rmi_function *);
+void rmi_unregister_function_dev(struct rmi_function *);
 
 /**
  * struct rmi_driver - driver for an RMI4 sensor on the RMI bus.
@@ -135,19 +141,22 @@ struct rmi_driver {
 	int (*irq_handler)(struct rmi_device *rmi_dev, int irq);
 	int (*reset_handler)(struct rmi_device *rmi_dev);
 	int (*store_irq_mask)(struct rmi_device *rmi_dev,
-				unsigned long *new_interupts);
+			      unsigned long *new_interupts);
 	int (*restore_irq_mask)(struct rmi_device *rmi_dev);
 	int (*store_productid)(struct rmi_device *rmi_dev);
 	int (*set_input_params)(struct rmi_device *rmi_dev,
-			struct input_dev *input);
+				struct input_dev *input);
+	int (*enable)(struct rmi_device *rmi_dev);
+	void (*disable)(struct rmi_device *rmi_dev);
+	int (*remove)(struct rmi_device *rmi_dev);
 	void *data;
 };
 
 #define to_rmi_driver(d) \
-	container_of(d, struct rmi_driver, driver);
+	container_of(d, struct rmi_driver, driver)
 
-/** struct rmi_phys_info - diagnostic information about the RMI physical
- * device, used in the phys debugfs file.
+/** struct rmi_transport_info - diagnostic information about the RMI transport,
+ * used in the transport-info debugfs file.
  *
  * @proto String indicating the protocol being used.
  * @tx_count Number of transmit operations.
@@ -158,7 +167,7 @@ struct rmi_driver {
  * @rx_errs  Number of errors encountered during receive operations.
  * @att_count Number of times ATTN assertions have been handled.
  */
-struct rmi_phys_info {
+struct rmi_transport_info {
 	char *proto;
 	long tx_count;
 	long tx_bytes;
@@ -169,7 +178,7 @@ struct rmi_phys_info {
 };
 
 /**
- * struct rmi_phys_device - represent an RMI physical device
+ * struct rmi_transport_device - represent an RMI transport conncection
  *
  * @dev: Pointer to the communication device, e.g. i2c or spi
  * @rmi_dev: Pointer to the RMI device
@@ -181,28 +190,28 @@ struct rmi_phys_info {
  * handling
  * @data: Private data pointer
  *
- * The RMI physical device implements the glue between different communication
- * buses such as I2C and SPI.
+ * The RMI transport device implements the glue between different communication
+ * buses such as I2C and SPI and the physical device on the RMI bus.
  *
  */
-struct rmi_phys_device {
+struct rmi_transport_device {
 	struct device *dev;
 	struct rmi_device *rmi_dev;
 
-	int (*write_block)(struct rmi_phys_device *phys, u16 addr,
+	int (*write_block)(struct rmi_transport_device *xport, u16 addr,
 			   const void *buf, const int len);
-	int (*read_block)(struct rmi_phys_device *phys, u16 addr,
+	int (*read_block)(struct rmi_transport_device *xport, u16 addr,
 			  void *buf, const int len);
 
-	int (*enable_device) (struct rmi_phys_device *phys);
-	void (*disable_device) (struct rmi_phys_device *phys);
+	int (*enable_device) (struct rmi_transport_device *xport);
+	void (*disable_device) (struct rmi_transport_device *xport);
 
 	irqreturn_t (*irq_thread)(int irq, void *p);
 	irqreturn_t (*hard_irq)(int irq, void *p);
 
 	void *data;
 
-	struct rmi_phys_info info;
+	struct rmi_transport_info info;
 };
 
 /**
@@ -211,7 +220,7 @@ struct rmi_phys_device {
  * @dev: The device created for the RMI bus
  * @number: Unique number for the device on the bus.
  * @driver: Pointer to associated driver
- * @phys: Pointer to the physical interface
+ * @xport: Pointer to the transport interface
  * @debugfs_root: base for this particular sensor device.
  *
  */
@@ -220,17 +229,15 @@ struct rmi_device {
 	int number;
 
 	struct rmi_driver *driver;
-	struct rmi_phys_device *phys;
+	struct rmi_transport_device *xport;
 
-#ifdef CONFIG_RMI4_DEBUG
 	struct dentry *debugfs_root;
-#endif
+	int    interrupt_restore_block_flag;
+
 };
 
 #define to_rmi_device(d) container_of(d, struct rmi_device, dev)
-#define to_rmi_platform_data(d) ((d)->phys->dev->platform_data)
-
-bool rmi_is_physical_device(struct device *dev);
+#define to_rmi_platform_data(d) ((d)->xport->dev->platform_data)
 
 /**
  * rmi_read - read a single byte
@@ -238,12 +245,12 @@ bool rmi_is_physical_device(struct device *dev);
  * @addr: The address to read from
  * @buf: The read buffer
  *
- * Reads a byte of data using the underlaying physical protocol in to buf. It
+ * Reads a byte of data using the underlying transport into buf. It
  * returns zero or a negative error code.
  */
 static inline int rmi_read(struct rmi_device *d, u16 addr, void *buf)
 {
-	return d->phys->read_block(d->phys, addr, buf, 1);
+	return d->xport->read_block(d->xport, addr, buf, 1);
 }
 
 /**
@@ -253,13 +260,13 @@ static inline int rmi_read(struct rmi_device *d, u16 addr, void *buf)
  * @buf: The read buffer
  * @len: Length of the read buffer
  *
- * Reads a block of byte data using the underlaying physical protocol in to buf.
+ * Reads a block of byte data using the underlying transport into buf.
  * It returns the amount of bytes read or a negative error code.
  */
 static inline int rmi_read_block(struct rmi_device *d, u16 addr, void *buf,
 				 const int len)
 {
-	return d->phys->read_block(d->phys, addr, buf, len);
+	return d->xport->read_block(d->xport, addr, buf, len);
 }
 
 /**
@@ -268,12 +275,12 @@ static inline int rmi_read_block(struct rmi_device *d, u16 addr, void *buf,
  * @addr: The address to write to
  * @data: The data to write
  *
- * Writes a byte from buf using the underlaying physical protocol. It
+ * Writes a byte from buf using the underlying transport. It
  * returns zero or a negative error code.
  */
 static inline int rmi_write(struct rmi_device *d, u16 addr, const u8 data)
 {
-	return d->phys->write_block(d->phys, addr, &data, 1);
+	return d->xport->write_block(d->xport, addr, &data, 1);
 }
 
 /**
@@ -283,34 +290,31 @@ static inline int rmi_write(struct rmi_device *d, u16 addr, const u8 data)
  * @buf: The write buffer
  * @len: Length of the write buffer
  *
- * Writes a block of byte data from buf using the underlaying physical protocol.
+ * Writes a block of byte data from buf using the underlying transport.
  * It returns the amount of bytes written or a negative error code.
  */
 static inline int rmi_write_block(struct rmi_device *d, u16 addr,
 				  const void *buf, const int len)
 {
-	return d->phys->write_block(d->phys, addr, buf, len);
+	return d->xport->write_block(d->xport, addr, buf, len);
 }
 
-int rmi_register_physical_device(struct rmi_phys_device *phys);
-void rmi_unregister_physical_device(struct rmi_phys_device *phys);
+int rmi_register_transport_device(struct rmi_transport_device *xport);
+void rmi_unregister_transport_device(struct rmi_transport_device *xport);
 int rmi_for_each_dev(void *data, int (*func)(struct device *dev, void *data));
 
 /**
- * module_rmi_driver() - Helper macro for registering a function driver
- * @__rmi_driver: rmi_function_handler struct
+ * module_rmi_function_driver() - Helper macro for registering a function driver
+ * @__rmi_driver: rmi_function_driver struct
  *
- * Helper macro for RMI4 function drivers which do not do anything special
- * in module init/exit. This eliminates a lot of boilerplate. Each module
+ * Helper macro for RMI4 function drivers which do not do anything special in
+ * module init/exit. This eliminates a lot of boilerplate. Each module
  * may only use this macro once, and calling it replaces module_init()
  * and module_exit().
  */
-#define module_rmi_driver(__rmi_driver)			\
+#define module_rmi_function_driver(__rmi_driver)	\
 	module_driver(__rmi_driver,			\
-		      rmi_register_function_handler,	\
-		      rmi_unregister_function_handler)
-
-
-extern struct bus_type rmi_bus_type;
+		rmi_register_function_driver,	\
+		rmi_unregister_function_driver)
 
 #endif
diff --git a/drivers/input/rmi4/rmi_control.h b/drivers/input/rmi4/rmi_control.h
new file mode 100644
index 0000000..f8b616e
--- /dev/null
+++ b/drivers/input/rmi4/rmi_control.h
@@ -0,0 +1,58 @@
+/*
+ * Copyright (c) 2013 Synaptics Incorporated
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef RMI_CONTROL_H
+#define RMI_CONTROL_H
+
+#include <linux/device.h>
+#include <linux/list.h>
+
+
+#define GROUP(_attrs) { \
+	.attrs = _attrs,  \
+}
+
+#define attrify(nm) (&dev_attr_##nm.attr)
+
+struct rmi_control_handler_data {
+	struct device *dev;
+	struct list_head list;
+};
+
+/** Information relating to control/debug handling implementations.
+ *
+ * @name - useful for diagnostics
+ * @dev_type - the type of device the handler is interested in.
+ * @function_id - the RMI4 function ID it is interested in (ignored if 0 or
+ * dev_type == rmi_device_type);
+ * @attach - called if a device appears on the bus that matches the parameters
+ * of this handler.
+ * @remove - called when the device disappears from the bus.
+ *
+ * @notifier - used by the control/debug system to accept notifications for
+ * this handler.
+ * @list - used by the control/debug system to keep track of handlers.
+ */
+struct rmi_control_handler {
+	char name[32];
+	struct device_type *dev_type;
+	u8 function_id;
+
+	struct rmi_control_handler_data * (*attach) (struct device *dev,
+						     void *data);
+	int (*remove) (struct rmi_control_handler_data *hdata);
+
+	struct notifier_block notifier;
+	struct list_head list;
+};
+
+
+int rmi_register_control_handler(struct rmi_control_handler *handler);
+void rmi_unregister_control_handler(struct rmi_control_handler *handler);
+
+#endif
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5cf7b33..cafe2dc 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -4,9 +4,10 @@
  *
  * This driver provides the core support for a single RMI4-based device.
  *
- * The RMI4 specification can be found here:
- *
- * http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4%20Intrfacing%20Guide.pdf
+ * The RMI4 specification can be found here (URL split after files/ for
+ * style reasons):
+ * http://www.synaptics.com/sites/default/files/
+ *           511-000136-01-Rev-E-RMI4%20Intrfacing%20Guide.pdf
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
@@ -27,75 +28,31 @@
 #include <linux/rmi.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-#include <uapi/linux/input.h>
+
 #include "rmi_bus.h"
 #include "rmi_driver.h"
+#include "rmi_f01.h"
 
 #define HAS_NONSTANDARD_PDT_MASK 0x40
 #define RMI4_MAX_PAGE 0xff
 #define RMI4_PAGE_SIZE 0x100
 
-#define RMI_DEVICE_RESET_CMD	0x01
-#define DEFAULT_RESET_DELAY_MS	100
-
 #define DEFAULT_POLL_INTERVAL_MS	13
 
 #define IRQ_DEBUG(data) (IS_ENABLED(CONFIG_RMI4_DEBUG) && data->irq_debug)
 
-#ifdef	CONFIG_RMI4_DEBUG
-static void rmi_driver_setup_debugfs(struct rmi_device *rmi_dev)
-{
-	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	struct rmi_phys_info *info = &rmi_dev->phys->info;
-
-	if (!rmi_dev->debugfs_root)
-		return;
-
-	if (!debugfs_create_u32_array("transport_stats", RMI_RO_ATTR,
-				      rmi_dev->debugfs_root,
-				      (u32 *)&info->tx_count, 6))
-		dev_warn(&rmi_dev->dev,
-			 "Failed to create debugfs transport_stats\n");
-
-	if (!debugfs_create_bool("irq_debug", RMI_RW_ATTR,
-				 rmi_dev->debugfs_root,
-				 &data->irq_debug))
-		dev_warn(&rmi_dev->dev, "Failed to create debugfs irq_debug\n");
-
-	if (!debugfs_create_u32("attn_count", RMI_RO_ATTR,
-				rmi_dev->debugfs_root,
-				&data->attn_count))
-		dev_warn(&rmi_dev->dev,
-			 "Failed to create debugfs attn_count\n");
-}
-
-static void rmi_driver_teardown_debugfs(struct rmi_device *rmi_dev)
-{
-	debugfs_remove_recursive(rmi_dev->debugfs_root);
-}
-
-#else
-static inline void rmi_driver_setup_debugfs(struct rmi_device *rmi_dev)
-{
-}
-
-static inline rmi_driver_teardown_debugfs(struct rmi_device *rmi_dev)
-{
-}
-#endif
-
-static irqreturn_t rmi_irq_thread(int irq, void *p)
+static irqreturn_t rmi_irq_thread(int irq, void *ptr)
 {
-	struct rmi_phys_device *phys = p;
-	struct rmi_device *rmi_dev = phys->rmi_dev;
+	struct rmi_transport_device *xport = ptr;
+	struct rmi_device *rmi_dev = xport->rmi_dev;
 	struct rmi_driver *driver = rmi_dev->driver;
-	struct rmi_device_platform_data *pdata = phys->dev->platform_data;
+	struct rmi_device_platform_data *pdata = xport->dev->platform_data;
 	struct rmi_driver_data *data;
 
 	data = dev_get_drvdata(&rmi_dev->dev);
 
 	if (IRQ_DEBUG(data))
-		dev_dbg(phys->dev, "ATTN gpio, value: %d.\n",
+		dev_dbg(xport->dev, "ATTN gpio, value: %d.\n",
 				gpio_get_value(pdata->attn_gpio));
 
 	if (gpio_get_value(pdata->attn_gpio) == pdata->attn_polarity) {
@@ -137,7 +94,6 @@ static int enable_polling(struct rmi_device *rmi_dev)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 
-	dev_dbg(&rmi_dev->dev, "Polling enabled.\n");
 	INIT_WORK(&data->poll_work, rmi_poll_work);
 	hrtimer_init(&data->poll_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	data->poll_timer.function = rmi_poll_timer;
@@ -150,7 +106,6 @@ static void disable_polling(struct rmi_device *rmi_dev)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 
-	dev_dbg(&rmi_dev->dev, "Polling disabled.\n");
 	hrtimer_cancel(&data->poll_timer);
 	cancel_work_sync(&data->poll_work);
 }
@@ -165,12 +120,12 @@ static void disable_sensor(struct rmi_device *rmi_dev)
 	if (!data->irq)
 		disable_polling(rmi_dev);
 
-	if (rmi_dev->phys->disable_device)
-		rmi_dev->phys->disable_device(rmi_dev->phys);
+	if (rmi_dev->xport->disable_device)
+		rmi_dev->xport->disable_device(rmi_dev->xport);
 
 	if (data->irq) {
 		disable_irq(data->irq);
-		free_irq(data->irq, rmi_dev->phys);
+		free_irq(data->irq, rmi_dev->xport);
 	}
 
 	data->enabled = false;
@@ -179,27 +134,28 @@ static void disable_sensor(struct rmi_device *rmi_dev)
 static int enable_sensor(struct rmi_device *rmi_dev)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	struct rmi_phys_device *rmi_phys;
+	struct rmi_transport_device *rmi_transport;
 	int retval = 0;
 	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
 
 	if (data->enabled)
 		return 0;
 
-	if (rmi_dev->phys->enable_device) {
-		retval = rmi_dev->phys->enable_device(rmi_dev->phys);
+	if (rmi_dev->xport->enable_device) {
+		retval = rmi_dev->xport->enable_device(rmi_dev->xport);
 		if (retval)
 			return retval;
 	}
 
-	rmi_phys = rmi_dev->phys;
+	rmi_transport = rmi_dev->xport;
 	if (data->irq) {
 		retval = request_threaded_irq(data->irq,
-				rmi_phys->hard_irq ? rmi_phys->hard_irq : NULL,
-				rmi_phys->irq_thread ?
-					rmi_phys->irq_thread : rmi_irq_thread,
-				data->irq_flags,
-				dev_name(&rmi_dev->dev), rmi_phys);
+			rmi_transport->hard_irq ?
+				rmi_transport->hard_irq : NULL,
+			rmi_transport->irq_thread ?
+				rmi_transport->irq_thread : rmi_irq_thread,
+			data->irq_flags,
+			dev_name(&rmi_dev->dev), rmi_transport);
 		if (retval)
 			return retval;
 	} else {
@@ -210,155 +166,39 @@ static int enable_sensor(struct rmi_device *rmi_dev)
 
 	data->enabled = true;
 
-	if (!pdata->level_triggered &&
+	if (pdata->attn_gpio && !pdata->level_triggered &&
 		    gpio_get_value(pdata->attn_gpio) == pdata->attn_polarity)
 		retval = process_interrupt_requests(rmi_dev);
 
 	return retval;
 }
 
-/* sysfs show and store fns for driver attributes */
-
-static ssize_t rmi_driver_bsr_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct rmi_device *rmi_dev;
-	struct rmi_driver_data *data;
-	rmi_dev = to_rmi_device(dev);
-	data = dev_get_drvdata(&rmi_dev->dev);
-
-	return snprintf(buf, PAGE_SIZE, "%u\n", data->bsr);
-}
-
-static ssize_t rmi_driver_bsr_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	int retval;
-	unsigned long val;
-	struct rmi_device *rmi_dev;
-	struct rmi_driver_data *data;
-
-	rmi_dev = to_rmi_device(dev);
-	data = dev_get_drvdata(&rmi_dev->dev);
-
-	/* need to convert the string data to an actual value */
-	retval = strict_strtoul(buf, 10, &val);
-	if (retval < 0 || val > 255) {
-		dev_err(dev, "Invalid value '%s' written to BSR.\n", buf);
-		return -EINVAL;
-	}
-
-	retval = rmi_write(rmi_dev, BSR_LOCATION, (u8)val);
-	if (retval < 0) {
-		dev_err(dev, "%s : failed to write bsr %lu to %#06x\n",
-			__func__, val, BSR_LOCATION);
-		return retval;
-	}
-
-	data->bsr = val;
-
-	return count;
-}
-
-static DEVICE_ATTR(bsr, RMI_RW_ATTR, rmi_driver_bsr_show, rmi_driver_bsr_store);
-
-static ssize_t rmi_driver_enabled_show(struct device *dev,
-				       struct device_attribute *attr, char *buf)
-{
-	struct rmi_device *rmi_dev = to_rmi_device(dev);
-	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-
-	return snprintf(buf, PAGE_SIZE, "%u\n", data->enabled);
-}
-
-static ssize_t rmi_driver_enabled_store(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t count)
-{
-	struct rmi_device *rmi_dev = to_rmi_device(dev);
-	int retval;
-	int new_value;
-
-	if (sysfs_streq(buf, "0"))
-		new_value = false;
-	else if (sysfs_streq(buf, "1"))
-		new_value = true;
-	else
-		return -EINVAL;
-
-	if (new_value) {
-		retval = enable_sensor(rmi_dev);
-		if (retval) {
-			dev_err(dev, "Failed to enable sensor, code=%d.\n",
-				retval);
-			return -EIO;
-		}
-	} else {
-		disable_sensor(rmi_dev);
-	}
-
-	return count;
-}
-
-/** This sysfs attribute is deprecated, and will be removed in a future release.
- */
-static DEVICE_ATTR(enabled, RMI_RW_ATTR,
-		   rmi_driver_enabled_show, rmi_driver_enabled_store);
-
-static umode_t rmi_driver_attr_visible(struct kobject *kobj,
-				       struct attribute *attr, int n)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct rmi_device *rmi_dev = to_rmi_device(dev);
-	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	umode_t mode = attr->mode;
-
-	if (attr == &dev_attr_bsr.attr) {
-		if (!data->pdt_props.has_bsr)
-			mode = 0;
-	}
-
-	return mode;
-}
-
-static struct attribute *rmi_driver_attrs[] = {
-	&dev_attr_bsr.attr,
-	&dev_attr_enabled.attr,
-	NULL
-};
-
-static struct attribute_group rmi_driver_attr_group = {
-	.is_visible	= rmi_driver_attr_visible,
-	.attrs		= rmi_driver_attrs,
-};
-
 static void rmi_free_function_list(struct rmi_device *rmi_dev)
 {
 	struct rmi_function *fn, *tmp;
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 
-	data->f01_container = NULL;
+	data->f01_dev = NULL;
 
-	/* Doing it in the reverse order so F01 will be removed last */
+	/* Do this in reverse order so F01 will be removed last. */
 	list_for_each_entry_safe_reverse(fn, tmp,
-					 &data->function_list, node) {
+					&data->function_list, node) {
 		list_del(&fn->node);
-		rmi_unregister_function(fn);
+		rmi_unregister_function_dev(fn);
 	}
 }
 
 static int reset_one_function(struct rmi_function *fn)
 {
-	struct rmi_function_handler *fh;
+	struct rmi_function_driver *fn_drv;
 	int retval = 0;
 
 	if (!fn || !fn->dev.driver)
 		return 0;
 
-	fh = to_rmi_function_handler(fn->dev.driver);
-	if (fh->reset) {
-		retval = fh->reset(fn);
+	fn_drv = to_rmi_function_driver(fn->dev.driver);
+	if (fn_drv->reset) {
+		retval = fn_drv->reset(fn);
 		if (retval < 0)
 			dev_err(&fn->dev, "Reset failed with code %d.\n",
 				retval);
@@ -369,15 +209,15 @@ static int reset_one_function(struct rmi_function *fn)
 
 static int configure_one_function(struct rmi_function *fn)
 {
-	struct rmi_function_handler *fh;
+	struct rmi_function_driver *fn_drv;
 	int retval = 0;
 
 	if (!fn || !fn->dev.driver)
 		return 0;
 
-	fh = to_rmi_function_handler(fn->dev.driver);
-	if (fh->config) {
-		retval = fh->config(fn);
+	fn_drv = to_rmi_function_driver(fn->dev.driver);
+	if (fn_drv->config) {
+		retval = fn_drv->config(fn);
 		if (retval < 0)
 			dev_err(&fn->dev, "Config failed with code %d.\n",
 				retval);
@@ -392,6 +232,9 @@ static int rmi_driver_process_reset_requests(struct rmi_device *rmi_dev)
 	struct rmi_function *entry;
 	int retval;
 
+	if (list_empty(&data->function_list))
+		return 0;
+
 	list_for_each_entry(entry, &data->function_list, node) {
 		retval = reset_one_function(entry);
 		if (retval < 0)
@@ -407,6 +250,9 @@ static int rmi_driver_process_config_requests(struct rmi_device *rmi_dev)
 	struct rmi_function *entry;
 	int retval;
 
+	if (list_empty(&data->function_list))
+		return 0;
+
 	list_for_each_entry(entry, &data->function_list, node) {
 		retval = configure_one_function(entry);
 		if (retval < 0)
@@ -419,18 +265,18 @@ static int rmi_driver_process_config_requests(struct rmi_device *rmi_dev)
 static void process_one_interrupt(struct rmi_function *fn,
 		unsigned long *irq_status, struct rmi_driver_data *data)
 {
-	struct rmi_function_handler *fh;
+	struct rmi_function_driver *fn_drv;
 	DECLARE_BITMAP(irq_bits, data->num_of_irq_regs);
 
 	if (!fn || !fn->dev.driver)
 		return;
 
-	fh = to_rmi_function_handler(fn->dev.driver);
-	if (fn->irq_mask && fh->attention) {
+	fn_drv = to_rmi_function_driver(fn->dev.driver);
+	if (fn->irq_mask && fn_drv->attention) {
 		bitmap_and(irq_bits, irq_status, fn->irq_mask,
 				data->irq_count);
 		if (!bitmap_empty(irq_bits, data->irq_count))
-			fh->attention(fn, irq_bits);
+			fn_drv->attention(fn, irq_bits);
 	}
 }
 
@@ -442,7 +288,7 @@ static int process_interrupt_requests(struct rmi_device *rmi_dev)
 	int error;
 
 	error = rmi_read_block(rmi_dev,
-				data->f01_container->fd.data_base_addr + 1,
+				data->f01_dev->fd.data_base_addr + 1,
 				data->irq_status, data->num_of_irq_regs);
 	if (error < 0) {
 		dev_err(dev, "Failed to read irqs, code=%d\n", error);
@@ -466,8 +312,7 @@ static int process_interrupt_requests(struct rmi_device *rmi_dev)
 	 */
 	list_for_each_entry(entry, &data->function_list, node) {
 		if (entry->irq_mask)
-			process_one_interrupt(entry, data->irq_status,
-					      data);
+			process_one_interrupt(entry, data->irq_status, data);
 	}
 
 	return 0;
@@ -483,9 +328,12 @@ static int process_interrupt_requests(struct rmi_device *rmi_dev)
 static int rmi_driver_set_input_params(struct rmi_device *rmi_dev,
 				struct input_dev *input)
 {
-	// FIXME: set up parent
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+
 	input->name = SYNAPTICS_INPUT_DEVICE_NAME;
 	input->id.vendor  = SYNAPTICS_VENDOR_ID;
+	input->id.product = data->board;
+	input->id.version = data->rev;
 	input->id.bustype = BUS_RMI;
 	return 0;
 }
@@ -506,7 +354,7 @@ static int rmi_driver_irq_save(struct rmi_device *rmi_dev,
 	if (!data->irq_stored) {
 		/* Save current enabled interrupts */
 		retval = rmi_read_block(rmi_dev,
-				data->f01_container->fd.control_base_addr+1,
+				data->f01_dev->fd.control_base_addr+1,
 				data->irq_mask_store, data->num_of_irq_regs);
 		if (retval < 0) {
 			dev_err(dev, "%s: Failed to read enabled interrupts!",
@@ -520,7 +368,7 @@ static int rmi_driver_irq_save(struct rmi_device *rmi_dev,
 		 * to identify them.
 		 */
 		retval = rmi_write_block(rmi_dev,
-				data->f01_container->fd.control_base_addr+1,
+				data->f01_dev->fd.control_base_addr+1,
 				new_ints, data->num_of_irq_regs);
 		if (retval < 0) {
 			dev_err(dev, "%s: Failed to change enabled interrupts!",
@@ -549,7 +397,7 @@ static int rmi_driver_irq_restore(struct rmi_device *rmi_dev)
 
 	if (data->irq_stored) {
 		retval = rmi_write_block(rmi_dev,
-				data->f01_container->fd.control_base_addr+1,
+				data->f01_dev->fd.control_base_addr+1,
 				data->irq_mask_store, data->num_of_irq_regs);
 		if (retval < 0) {
 			dev_err(dev, "%s: Failed to write enabled interupts!",
@@ -578,7 +426,7 @@ static int rmi_driver_irq_handler(struct rmi_device *rmi_dev, int irq)
 	/* Can get called before the driver is fully ready to deal with
 	 * interrupts.
 	 */
-	if (!data || !data->f01_container) {
+	if (!data || !data->f01_dev) {
 		dev_dbg(&rmi_dev->dev,
 			 "Not ready to handle interrupts yet!\n");
 		return 0;
@@ -595,9 +443,8 @@ static int rmi_driver_reset_handler(struct rmi_device *rmi_dev)
 	/* Can get called before the driver is fully ready to deal with
 	 * this situation.
 	 */
-	if (!data || !data->f01_container) {
-		dev_warn(&rmi_dev->dev,
-			 "Not ready to handle reset yet!\n");
+	if (!data || !data->f01_dev) {
+		dev_warn(&rmi_dev->dev, "Not ready to handle reset yet!\n");
 		return 0;
 	}
 
@@ -632,17 +479,42 @@ int rmi_driver_irq_get_mask(struct rmi_device *rmi_dev,
 			BITS_TO_LONGS(data->irq_count)*sizeof(unsigned long),
 			GFP_KERNEL);
 
-	if (fn->irq_mask) {
-		for (i = 0; i < fn->num_of_irqs; i++)
-			set_bit(fn->irq_pos+i, fn->irq_mask);
-		return 0;
-	} else
+	if (!fn->irq_mask)
 		return -ENOMEM;
+
+	for (i = 0; i < fn->num_of_irqs; i++)
+		set_bit(fn->irq_pos+i, fn->irq_mask);
+	return 0;
 }
 
-static void rmi_driver_copy_pdt_to_fd(struct pdt_entry *pdt,
-				      struct rmi_function_descriptor *fd,
-				      u16 page_start)
+int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
+			   u16 pdt_address)
+{
+	u8 buf[RMI_PDT_ENTRY_SIZE];
+	int error;
+
+	error = rmi_read_block(rmi_dev, pdt_address, buf, RMI_PDT_ENTRY_SIZE);
+	if (error < 0) {
+		dev_err(&rmi_dev->dev, "Read PDT entry at %#06x failed, code: %d.\n",
+				pdt_address, error);
+		return error;
+	}
+
+	entry->query_base_addr = buf[0];
+	entry->command_base_addr = buf[1];
+	entry->control_base_addr = buf[2];
+	entry->data_base_addr = buf[3];
+	entry->interrupt_source_count = buf[4] & RMI_PDT_INT_SOURCE_COUNT_MASK;
+	entry->function_version = (buf[4] & RMI_PDT_FUNCTION_VERSION_MASK) >> 5;
+	entry->function_number = buf[5];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rmi_read_pdt_entry);
+
+static void copy_pdt_entry_to_fd(struct pdt_entry *pdt,
+				 struct rmi_function_descriptor *fd,
+				 u16 page_start)
 {
 	fd->query_base_addr = pdt->query_base_addr + page_start;
 	fd->command_base_addr = pdt->command_base_addr + page_start;
@@ -653,89 +525,190 @@ static void rmi_driver_copy_pdt_to_fd(struct pdt_entry *pdt,
 	fd->function_version = pdt->function_version;
 }
 
-static int create_function(struct rmi_device *rmi_dev,
+static int create_function_dev(struct rmi_device *rmi_dev,
 				     struct pdt_entry *pdt,
 				     int *current_irq_count,
 				     u16 page_start)
 {
-	struct device *dev = &rmi_dev->dev;
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
-	struct rmi_function *fn;
-	int error;
+	struct rmi_function *fn = NULL;
+	int retval = 0;
+	struct device *dev = &rmi_dev->dev;
+	struct rmi_device_platform_data *pdata;
 
-	dev_dbg(dev, "Initializing F%02X for %s.\n",
-		pdt->function_number, pdata->sensor_name);
+	pdata = to_rmi_platform_data(rmi_dev);
+
+	dev_dbg(dev, "Initializing F%02X device for %s.\n",
+			pdt->function_number, pdata->sensor_name);
 
 	fn = kzalloc(sizeof(struct rmi_function), GFP_KERNEL);
 	if (!fn) {
-		dev_err(dev, "Failed to allocate memory for F%02X\n",
+		dev_err(dev, "Failed to allocate F%02X device.\n",
 			pdt->function_number);
 		return -ENOMEM;
 	}
 
 	INIT_LIST_HEAD(&fn->node);
+	copy_pdt_entry_to_fd(pdt, &fn->fd, page_start);
 
 	fn->rmi_dev = rmi_dev;
 	fn->num_of_irqs = pdt->interrupt_source_count;
-
 	fn->irq_pos = *current_irq_count;
 	*current_irq_count += fn->num_of_irqs;
 
-	rmi_driver_copy_pdt_to_fd(pdt, &fn->fd, page_start);
+	retval = rmi_driver_irq_get_mask(rmi_dev, fn);
+	if (retval < 0) {
+		dev_err(dev, "%s: Failed to create irq_mask for F%02X.\n",
+			__func__, pdt->function_number);
+		return retval;
+	}
 
-	error = rmi_register_function(fn);
-	if (error)
+	retval = rmi_register_function_dev(fn);
+	if (retval < 0) {
+		dev_err(dev, "Failed to register F%02X device.\n",
+			pdt->function_number);
 		goto err_free_mem;
+	}
 
-	list_add_tail(&fn->node, &data->function_list);
+	/* we need to ensure that F01 is at the head of the list.
+	 */
+	if (pdt->function_number == 0x01) {
+		list_add(&fn->node, &data->function_list);
+		data->f01_dev = fn;
+	} else
+		list_add_tail(&fn->node, &data->function_list);
 
 	return 0;
-
 err_free_mem:
 	kfree(fn);
-	return error;
+	return retval;
 }
 
 /*
- * Scan the PDT for F01 so we can force a reset before anything else
- * is done.  This forces the sensor into a known state, and also
- * forces application of any pending updates from reflashing the
- * firmware or configuration.
- *
- * At this time, we also reflash the device if (a) in kernel reflashing is
+ * Once we find F01, we need to see if we're in bootloader mode.  If we are,
+ * we'll stop scanning the PDT with the current page (usually 0x00 in that
+ * case).
+ */
+static void check_bootloader_mode(struct rmi_device *rmi_dev,
+				     struct pdt_entry *pdt,
+				     u16 page_start)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	u8 device_status;
+	int retval = 0;
+
+	retval = rmi_read(rmi_dev, pdt->data_base_addr + page_start,
+			  &device_status);
+	if (retval < 0) {
+		dev_err(&rmi_dev->dev, "Failed to read device status.\n");
+		return;
+	}
+	data->f01_bootloader_mode = RMI_F01_STATUS_BOOTLOADER(device_status);
+	if (RMI_F01_STATUS_BOOTLOADER(device_status))
+		dev_warn(&rmi_dev->dev,
+			 "WARNING: RMI4 device is in bootloader mode!\n");
+
+}
+
+/*
+ * We also reflash the device if (a) in kernel reflashing is
  * enabled, and (b) the reflash module decides it requires reflashing.
  *
  * We have to do this before actually building the PDT because the reflash
  * might cause various registers to move around.
  */
-static int reset_and_reflash(struct rmi_device *rmi_dev)
+static int rmi_device_reflash(struct rmi_device *rmi_dev)
 {
 	struct pdt_entry pdt_entry;
 	int page;
 	struct device *dev = &rmi_dev->dev;
-	bool done = false;
+	bool done;
 	bool has_f01 = false;
+	bool has_f34 = false;
+	struct pdt_entry f34_pdt, f01_pdt;
 	int i;
 	int retval;
-	const struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
-
-	dev_dbg(dev, "Initial reset.\n");
+	struct rmi_device_platform_data *pdata;
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 
-	for (page = 0; (page <= RMI4_MAX_PAGE) && !done; page++) {
+	pdata = to_rmi_platform_data(rmi_dev);
+	data->f01_bootloader_mode = false;
+	for (page = 0; (page <= RMI4_MAX_PAGE); page++) {
 		u16 page_start = RMI4_PAGE_SIZE * page;
 		u16 pdt_start = page_start + PDT_START_SCAN_LOCATION;
 		u16 pdt_end = page_start + PDT_END_SCAN_LOCATION;
-
 		done = true;
-		for (i = pdt_start; i >= pdt_end; i -= sizeof(pdt_entry)) {
-			retval = rmi_read_block(rmi_dev, i, &pdt_entry,
-					       sizeof(pdt_entry));
-			if (retval != sizeof(pdt_entry)) {
-				dev_err(dev, "Read PDT entry at %#06x failed, code = %d.\n",
-						i, retval);
+		for (i = pdt_start; i >= pdt_end ; i -= RMI_PDT_ENTRY_SIZE) {
+			retval = rmi_read_pdt_entry(rmi_dev, &pdt_entry, i);
+			if (retval < 0)
 				return retval;
+
+			if (RMI4_END_OF_PDT(pdt_entry.function_number))
+				break;
+			done = false;
+			if (pdt_entry.function_number == 0x01) {
+				memcpy(&f01_pdt, &pdt_entry, sizeof(pdt_entry));
+				has_f01 = true;
+				check_bootloader_mode(rmi_dev, &pdt_entry,
+						      page_start);
+			} else if (pdt_entry.function_number == 0x34) {
+				memcpy(&f34_pdt, &pdt_entry, sizeof(pdt_entry));
+				has_f34 = true;
+			}
+
+			if (has_f01 && has_f34) {
+				done = true;
+				break;
 			}
+		}
+
+		if (data->f01_bootloader_mode || done)
+			break;
+	}
+
+	if (!has_f01) {
+		dev_warn(dev, "WARNING: Failed to find F01 for initial reflash.\n");
+		return -ENODEV;
+	}
+
+#ifdef CONFIG_RMI4_FWLIB
+	if (has_f34)
+		rmi4_fw_update(rmi_dev, &f01_pdt, &f34_pdt);
+	else
+		dev_warn(dev, "WARNING: No F34 , firmware update will not be done.\n");
+#endif
+
+	return 0;
+}
+
+/*
+ * Scan the PDT for F01 so we can force a reset before anything else
+ * is done.  This forces the sensor into a known state, and also
+ * forces application of any pending updates from reflashing the
+ * firmware or configuration.
+ *
+ */
+static int rmi_device_reset(struct rmi_device *rmi_dev)
+{
+	struct pdt_entry pdt_entry;
+	int page;
+	struct device *dev = &rmi_dev->dev;
+	int i;
+	int error;
+	bool done = false;
+	struct rmi_device_platform_data *pdata;
+
+	pdata = to_rmi_platform_data(rmi_dev);
+	for (page = 0; (page <= RMI4_MAX_PAGE)  && !done; page++) {
+		u16 page_start = RMI4_PAGE_SIZE * page;
+		u16 pdt_start = page_start + PDT_START_SCAN_LOCATION;
+		u16 pdt_end = page_start + PDT_END_SCAN_LOCATION;
+		done = true;
+
+		for (i = pdt_start; i >= pdt_end; i -= RMI_PDT_ENTRY_SIZE) {
+			error = rmi_read_pdt_entry(rmi_dev, &pdt_entry, i);
+			if (error < 0)
+				return error;
 
 			if (RMI4_END_OF_PDT(pdt_entry.function_number))
 				break;
@@ -744,28 +717,64 @@ static int reset_and_reflash(struct rmi_device *rmi_dev)
 			if (pdt_entry.function_number == 0x01) {
 				u16 cmd_addr = page_start +
 					pdt_entry.command_base_addr;
-				u8 cmd_buf = RMI_DEVICE_RESET_CMD;
-				retval = rmi_write_block(rmi_dev, cmd_addr,
-						&cmd_buf, 1);
-				if (retval < 0) {
+				u8 cmd = RMI_F01_CMD_DEVICE_RESET;
+				error = rmi_write_block(rmi_dev, cmd_addr,
+						&cmd, sizeof(cmd));
+				if (error < 0) {
 					dev_err(dev, "Initial reset failed. Code = %d.\n",
-						retval);
-					return retval;
+						error);
+					return error;
 				}
-				mdelay(pdata->reset_delay_ms);
-				done = true;
-				has_f01 = true;
-				break;
+				msleep(pdata->reset_delay_ms);
+				return 0;
 			}
 		}
 	}
 
-	if (!has_f01) {
-		dev_warn(dev, "WARNING: Failed to find F01 for initial reset.\n");
-		return -ENODEV;
+	return -ENODEV;
+}
+
+static int rmi_count_irqs(struct rmi_device *rmi_dev)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	struct pdt_entry pdt_entry;
+	int page;
+	int irq_count = 0;
+	bool done = false;
+	int i;
+	int retval;
+
+	mutex_lock(&data->pdt_mutex);
+
+	for (page = 0; (page <= RMI4_MAX_PAGE) && !done; page++) {
+		u16 page_start = RMI4_PAGE_SIZE * page;
+		u16 pdt_start = page_start + PDT_START_SCAN_LOCATION;
+		u16 pdt_end = page_start + PDT_END_SCAN_LOCATION;
+
+		done = true;
+		for (i = pdt_start; i >= pdt_end; i -= RMI_PDT_ENTRY_SIZE) {
+			retval = rmi_read_pdt_entry(rmi_dev, &pdt_entry, i);
+			if (retval < 0)
+				goto error_exit;
+
+			if (RMI4_END_OF_PDT(pdt_entry.function_number))
+				break;
+			irq_count += pdt_entry.interrupt_source_count;
+			done = false;
+
+			if (pdt_entry.function_number == 0x01)
+				check_bootloader_mode(rmi_dev, &pdt_entry,
+						      page_start);
+		}
+		done = done || data->f01_bootloader_mode;
 	}
+	data->irq_count = irq_count;
+	data->num_of_irq_regs = (irq_count + 7) / 8;
+	retval = 0;
 
-	return 0;
+error_exit:
+	mutex_unlock(&data->pdt_mutex);
+	return retval;
 }
 
 static int rmi_scan_pdt(struct rmi_device *rmi_dev)
@@ -790,33 +799,30 @@ static int rmi_scan_pdt(struct rmi_device *rmi_dev)
 		u16 pdt_end = page_start + PDT_END_SCAN_LOCATION;
 
 		done = true;
-		for (i = pdt_start; i >= pdt_end; i -= sizeof(pdt_entry)) {
-			retval = rmi_read_block(rmi_dev, i, &pdt_entry,
-					       sizeof(pdt_entry));
-			if (retval != sizeof(pdt_entry)) {
-				dev_err(dev, "Read of PDT entry at %#06x failed.\n",
-					i);
+		for (i = pdt_start; i >= pdt_end; i -= RMI_PDT_ENTRY_SIZE) {
+			retval = rmi_read_pdt_entry(rmi_dev, &pdt_entry, i);
+			if (retval < 0)
 				goto error_exit;
-			}
 
 			if (RMI4_END_OF_PDT(pdt_entry.function_number))
 				break;
 
-			dev_dbg(dev, "Found F%02X on page %#04x\n",
+			dev_dbg(dev, "Found F%02X on page %#04x.\n",
 					pdt_entry.function_number, page);
 			done = false;
 
-			// XXX need to make sure we create F01 first...
-			retval = create_function(rmi_dev,
-					&pdt_entry, &irq_count, page_start);
+			if (pdt_entry.function_number == 0x01)
+				check_bootloader_mode(rmi_dev, &pdt_entry,
+						      page_start);
+
 
+			retval = create_function_dev(rmi_dev,
+					&pdt_entry, &irq_count, page_start);
 			if (retval)
 				goto error_exit;
 		}
 		done = done || data->f01_bootloader_mode;
 	}
-	data->irq_count = irq_count;
-	data->num_of_irq_regs = (irq_count + 7) / 8;
 	dev_dbg(dev, "%s: Done with PDT scan.\n", __func__);
 	retval = 0;
 
@@ -825,8 +831,6 @@ error_exit:
 	return retval;
 }
 
-#if 0
-// XXX is this crap needed with F01 always present?
 static int f01_notifier_call(struct notifier_block *nb,
 				unsigned long action, void *data)
 {
@@ -842,11 +846,9 @@ static int f01_notifier_call(struct notifier_block *nb,
 
 	switch (action) {
 	case BUS_NOTIFY_BOUND_DRIVER:
-		dev_dbg(dev, "%s: F01 driver bound.\n", __func__);
 		enable_sensor(fn->rmi_dev);
 		break;
 	case BUS_NOTIFY_UNBIND_DRIVER:
-		dev_dbg(dev, "%s: F01 driver going away.\n", __func__);
 		disable_sensor(fn->rmi_dev);
 		break;
 	}
@@ -856,16 +858,13 @@ static int f01_notifier_call(struct notifier_block *nb,
 static struct notifier_block rmi_bus_notifier = {
 	.notifier_call = f01_notifier_call,
 };
-#endif
 
 #ifdef CONFIG_PM_SLEEP
 static int rmi_driver_suspend(struct device *dev)
 {
-	struct rmi_driver_data *data;
-	int retval = 0;
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
-
-	data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	int retval = 0;
 
 	mutex_lock(&data->suspend_mutex);
 
@@ -877,13 +876,6 @@ static int rmi_driver_suspend(struct device *dev)
 
 	disable_sensor(rmi_dev);
 
-#if 0
-	/** Do it backwards so F01 comes last. */
-	list_for_each_entry_reverse(entry, &data->function_list, node)
-		if (suspend_one_device(entry) < 0)
-			goto exit;
-#endif
-
 	if (data->post_suspend)
 		retval = data->post_suspend(data->pm_data);
 
@@ -894,11 +886,10 @@ exit:
 
 static int rmi_driver_resume(struct device *dev)
 {
-	struct rmi_driver_data *data;
-	int retval = 0;
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	int retval = 0;
 
-	data = dev_get_drvdata(&rmi_dev->dev);
 	mutex_lock(&data->suspend_mutex);
 
 	if (data->pre_resume) {
@@ -907,14 +898,6 @@ static int rmi_driver_resume(struct device *dev)
 			goto exit;
 	}
 
-#if 0
-	/** Do it forwards, so F01 comes first. */
-	list_for_each_entry(entry, &data->function_list, node) {
-		if (resume_one_device(entry) < 0)
-			goto exit;
-	}
-#endif
-
 	retval = enable_sensor(rmi_dev);
 	if (retval)
 		goto exit;
@@ -923,47 +906,38 @@ static int rmi_driver_resume(struct device *dev)
 	if (data->post_resume) {
 		retval = data->post_resume(data->pm_data);
 		if (retval)
-			goto exit;
+			dev_err(&rmi_dev->dev, "Post resume failed with %d.\n",
+				retval);
 	}
 
-	data->suspended = false;
 exit:
 	mutex_unlock(&data->suspend_mutex);
 	return retval;
 }
 
-#endif /* CONFIG_PM */
 
-static SIMPLE_DEV_PM_OPS(rmi_driver_pm, rmi_driver_suspend, rmi_driver_resume);
+#endif /* CONFIG_PM_SLEEP */
 
-static int rmi_driver_remove(struct device *dev)
+static int rmi_driver_remove(struct rmi_device *rmi_dev)
 {
-	struct rmi_device *rmi_dev = to_rmi_device(dev);
-
-	rmi_driver_teardown_debugfs(rmi_dev);
-	sysfs_remove_group(&dev->kobj, &rmi_driver_attr_group);
-
 	disable_sensor(rmi_dev);
-	rmi_free_function_list(rmi_dev);
 
+	rmi_free_function_list(rmi_dev);
 	return 0;
 }
 
+static const char *GPIO_LABEL = "attn";
+
 static int rmi_driver_probe(struct device *dev)
 {
 	struct rmi_driver *rmi_driver;
 	struct rmi_driver_data *data = NULL;
-	struct rmi_function *fn;
 	struct rmi_device_platform_data *pdata;
 	int retval = 0;
 	struct rmi_device *rmi_dev;
 
-	dev_dbg(dev, "%s: Starting probe.\n", __func__);
-
-	if (!rmi_is_physical_device(dev)) {
-		dev_dbg(dev, "Not a sensor device.\n");
+	if (!rmi_is_physical_device(dev))
 		return -ENODEV;
-	}
 
 	rmi_dev = to_rmi_device(dev);
 	rmi_driver = to_rmi_driver(dev->driver);
@@ -998,31 +972,13 @@ static int rmi_driver_probe(struct device *dev)
 	 */
 	if (!pdata->reset_delay_ms)
 		pdata->reset_delay_ms = DEFAULT_RESET_DELAY_MS;
-	retval = reset_and_reflash(rmi_dev);
+	retval = rmi_device_reset(rmi_dev);
 	if (retval)
 		dev_warn(dev, "RMI initial reset failed! Continuing in spite of this.\n");
 
-	retval = rmi_scan_pdt(rmi_dev);
-	if (retval) {
-		dev_err(dev, "PDT scan for %s failed with code %d.\n",
-			pdata->sensor_name, retval);
-		goto err_free_data;
-	}
-
-	if (!data->f01_container) {
-		dev_err(dev, "missing F01 container!\n");
-		retval = -EINVAL;
-		goto err_free_data;
-	}
-
-	list_for_each_entry(fn, &data->function_list, node) {
-		retval = rmi_driver_irq_get_mask(rmi_dev, fn);
-		if (retval < 0) {
-			dev_err(dev, "%s: Failed to create irq_mask.\n",
-				__func__);
-			goto err_free_data;
-		}
-	}
+	retval = rmi_device_reflash(rmi_dev);
+	if (retval)
+		dev_warn(dev, "RMI reflash failed! Continuing in spite of this.\n");
 
 	retval = rmi_read(rmi_dev, PDT_PROPERTIES_LOCATION, &data->pdt_props);
 	if (retval < 0) {
@@ -1033,6 +989,31 @@ static int rmi_driver_probe(struct device *dev)
 			 PDT_PROPERTIES_LOCATION);
 	}
 
+	if (pdata->attn_gpio) {
+		data->irq = gpio_to_irq(pdata->attn_gpio);
+		if (pdata->level_triggered) {
+			data->irq_flags = IRQF_ONESHOT |
+				((pdata->attn_polarity == RMI_ATTN_ACTIVE_HIGH)
+				? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW);
+		} else {
+			data->irq_flags =
+				(pdata->attn_polarity == RMI_ATTN_ACTIVE_HIGH)
+				? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
+		}
+		dev_dbg(dev, "Mapped IRQ %d for GPIO %d.\n",
+			data->irq, pdata->attn_gpio);
+	} else
+		data->poll_interval = ktime_set(0,
+			(pdata->poll_interval_ms ? pdata->poll_interval_ms :
+			DEFAULT_POLL_INTERVAL_MS) * 1000 * 1000);
+
+	retval = rmi_count_irqs(rmi_dev);
+	if (retval) {
+		dev_err(dev, "IRQ counting for %s failed with code %d.\n",
+			pdata->sensor_name, retval);
+		goto err_free_data;
+	}
+
 	mutex_init(&data->irq_mutex);
 	data->irq_status = devm_kzalloc(dev,
 		BITS_TO_LONGS(data->irq_count)*sizeof(unsigned long),
@@ -1043,8 +1024,7 @@ static int rmi_driver_probe(struct device *dev)
 		goto err_free_data;
 	}
 
-	data->current_irq_mask = devm_kzalloc(dev,
-				data->num_of_irq_regs,
+	data->current_irq_mask = devm_kzalloc(dev, data->num_of_irq_regs,
 				GFP_KERNEL);
 	if (!data->current_irq_mask) {
 		dev_err(dev, "Failed to allocate current_irq_mask.\n");
@@ -1052,15 +1032,6 @@ static int rmi_driver_probe(struct device *dev)
 		goto err_free_data;
 	}
 
-	retval = rmi_read_block(rmi_dev,
-				data->f01_container->fd.control_base_addr+1,
-				data->current_irq_mask, data->num_of_irq_regs);
-	if (retval < 0) {
-		dev_err(dev, "%s: Failed to read current IRQ mask.\n",
-			__func__);
-		goto err_free_data;
-	}
-
 	data->irq_mask_store = devm_kzalloc(dev,
 		BITS_TO_LONGS(data->irq_count)*sizeof(unsigned long),
 		GFP_KERNEL);
@@ -1069,6 +1040,29 @@ static int rmi_driver_probe(struct device *dev)
 		retval = -ENOMEM;
 		goto err_free_data;
 	}
+
+	retval = rmi_scan_pdt(rmi_dev);
+	if (retval) {
+		dev_err(dev, "PDT scan for %s failed with code %d.\n",
+			pdata->sensor_name, retval);
+		goto err_free_data;
+	}
+
+	if (!data->f01_dev) {
+		dev_err(dev, "missing F01 device!\n");
+		retval = -EINVAL;
+		goto err_free_data;
+	}
+
+	retval = rmi_read_block(rmi_dev,
+				data->f01_dev->fd.control_base_addr+1,
+				data->current_irq_mask, data->num_of_irq_regs);
+	if (retval < 0) {
+		dev_err(dev, "%s: Failed to read current IRQ mask.\n",
+			__func__);
+		goto err_free_data;
+	}
+
 	if (IS_ENABLED(CONFIG_PM)) {
 		data->pm_data = pdata->pm_data;
 		data->pre_suspend = pdata->pre_suspend;
@@ -1079,50 +1073,32 @@ static int rmi_driver_probe(struct device *dev)
 		mutex_init(&data->suspend_mutex);
 	}
 
-	retval = sysfs_create_group(&dev->kobj, &rmi_driver_attr_group);
-	if (retval < 0) {
-		dev_err(dev, "%s: Failed to create sysfs group\n", __func__);
-		goto err_free_data;
-	}
-
-	rmi_driver_setup_debugfs(rmi_dev);
-
-	if (pdata->attn_gpio) {
-		data->irq = gpio_to_irq(pdata->attn_gpio);
-		if (pdata->level_triggered) {
-			data->irq_flags = IRQF_ONESHOT |
-				((pdata->attn_polarity == RMI_ATTN_ACTIVE_HIGH)
-				? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW);
-		} else {
-			data->irq_flags =
-				(pdata->attn_polarity == RMI_ATTN_ACTIVE_HIGH)
-				? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
-		}
-	} else
-		data->poll_interval = ktime_set(0,
-			(pdata->poll_interval_ms ? pdata->poll_interval_ms :
-			DEFAULT_POLL_INTERVAL_MS) * 1000);
-
-	if (data->f01_container->dev.driver) {
+	if (data->f01_dev->dev.driver) {
 		/* Driver already bound, so enable ATTN now. */
 		enable_sensor(rmi_dev);
 	}
 
 	if (IS_ENABLED(CONFIG_RMI4_DEV) && pdata->attn_gpio) {
-		retval = gpio_export(pdata->attn_gpio, false);
-		if (retval) {
-			dev_warn(dev, "WARNING: Failed to export ATTN gpio!\n");
-			retval = 0;
-		} else {
-			retval = gpio_export_link(dev,
-						  "attn", pdata->attn_gpio);
-			if (retval) {
-				dev_warn(dev,
-					"WARNING: Failed to symlink ATTN gpio!\n");
-				retval = 0;
-			} else {
-				dev_info(dev, "Exported ATTN GPIO %d.",
-					pdata->attn_gpio);
+		retval = gpio_request(pdata->attn_gpio, GPIO_LABEL);
+		if (retval)
+			dev_warn(dev, "WARNING: Failed to request ATTN gpio %d, code=%d.\n",
+				 pdata->attn_gpio, retval);
+		else {
+			retval = gpio_export(pdata->attn_gpio, false);
+			if (retval)
+				dev_warn(dev, "WARNING: Failed to export ATTN gpio %d, code=%d!\n",
+					pdata->attn_gpio, retval);
+			else {
+				retval = gpio_export_link(dev,
+						"attn", pdata->attn_gpio);
+				if (retval) {
+					dev_warn(dev,
+						"WARNING: Failed to symlink ATTN gpio!\n");
+					retval = 0;
+				} else {
+					dev_info(dev, "Exported ATTN GPIO %d.",
+						pdata->attn_gpio);
+				}
 			}
 		}
 	}
@@ -1130,45 +1106,57 @@ static int rmi_driver_probe(struct device *dev)
 	return 0;
 
  err_free_data:
+	rmi_free_function_list(rmi_dev);
 	return retval;
 }
 
+static UNIVERSAL_DEV_PM_OPS(rmi_driver_pm, rmi_driver_suspend,
+			    rmi_driver_resume, NULL);
+
 struct rmi_driver rmi_physical_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
-		.name	= "rmi_physical",
-		.bus	= &rmi_bus_type,
-		.pm	= &rmi_driver_pm,
-		.probe = rmi_driver_probe,
-		.remove = rmi_driver_remove,
+		.owner    = THIS_MODULE,
+		.name     = "rmi_physical",
+		.bus      = &rmi_bus_type,
+		.pm       = &rmi_driver_pm,
+		.probe    = rmi_driver_probe,
 	},
 	.irq_handler = rmi_driver_irq_handler,
 	.reset_handler = rmi_driver_reset_handler,
 	.store_irq_mask = rmi_driver_irq_save,
 	.restore_irq_mask = rmi_driver_irq_restore,
 	.set_input_params = rmi_driver_set_input_params,
+	.enable = enable_sensor,
+	.disable = disable_sensor,
+	.remove = rmi_driver_remove,
 };
 
-bool rmi_is_physical_driver(struct device_driver *drv)
+int __init rmi_register_sensor_driver(void)
 {
-	return drv == &rmi_physical_driver.driver;
-}
-
-int __init rmi_register_physical_driver(void)
-{
-	int error;
+	int retval;
 
-	error = driver_register(&rmi_physical_driver.driver);
-	if (error) {
+	retval = driver_register(&rmi_physical_driver.driver);
+	if (retval) {
 		pr_err("%s: driver register failed, code=%d.\n", __func__,
-		       error);
-		return error;
+		       retval);
+		return retval;
 	}
 
+	/* Ask the bus to let us know when drivers are bound to devices. */
+	retval = bus_register_notifier(&rmi_bus_type, &rmi_bus_notifier);
+	if (retval) {
+		pr_err("%s: failed to register bus notifier, code=%d.\n",
+		       __func__, retval);
+		return retval;
+	}
+
+	pr_debug("%s: sensor driver registered.\n", __func__);
+
 	return 0;
 }
 
-void __exit rmi_unregister_physical_driver(void)
+void __exit rmi_unregister_sensor_driver(void)
 {
+	bus_unregister_notifier(&rmi_bus_type, &rmi_bus_notifier);
 	driver_unregister(&rmi_physical_driver.driver);
 }
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index f8d87e9..c873526 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -13,38 +13,31 @@
 #include <linux/ctype.h>
 #include <linux/hrtimer.h>
 #include <linux/ktime.h>
-#include "rmi_bus.h"
+#include <linux/rmi.h>
 
-#define RMI_DRIVER_VERSION "1.6"
+#include "rmi_bus.h"
+#include "rmi_version.h"
 
 #define SYNAPTICS_INPUT_DEVICE_NAME "Synaptics RMI4 Touch Sensor"
 #define SYNAPTICS_VENDOR_ID 0x06cb
 
-#define GROUP(_attrs) { \
-	.attrs = _attrs,  \
-}
 
-#define attrify(nm) (&dev_attr_##nm.attr)
+#define DEFAULT_RESET_DELAY_MS	100
 
 #define PDT_PROPERTIES_LOCATION 0x00EF
 #define BSR_LOCATION 0x00FE
 
-struct pdt_properties {
-	u8 reserved_1:6;
-	u8 has_bsr:1;
-	u8 reserved_2:1;
-} __attribute__((__packed__));
+#define RMI_PDT_PROPS_HAS_BSR 0x02
 
 struct rmi_driver_data {
 	struct list_head function_list;
-
 	struct rmi_device *rmi_dev;
 
-	struct rmi_function *f01_container;
+	struct rmi_function *f01_dev;
 	bool f01_bootloader_mode;
 
 	u32 attn_count;
-	u32 irq_debug;	/* Should be bool, but debugfs wants u32 */
+	u32 irq_debug;
 	int irq;
 	int irq_flags;
 	int num_of_irq_regs;
@@ -59,11 +52,13 @@ struct rmi_driver_data {
 	struct hrtimer poll_timer;
 	struct work_struct poll_work;
 	ktime_t poll_interval;
-
 	struct mutex pdt_mutex;
-	struct pdt_properties pdt_props;
+	u8 pdt_props;
 	u8 bsr;
 
+	int board;
+	int rev;
+
 	bool enabled;
 #ifdef CONFIG_PM
 	bool suspended;
@@ -76,54 +71,42 @@ struct rmi_driver_data {
 	int (*post_resume) (const void *pm_data);
 #endif
 
-#ifdef CONFIG_RMI4_DEBUG
-	struct dentry *debugfs_delay;
-	struct dentry *debugfs_phys;
-	struct dentry *debugfs_reg_ctl;
-	struct dentry *debugfs_reg;
-	struct dentry *debugfs_irq;
-	struct dentry *debugfs_attn_count;
-	u16 reg_debug_addr;
-	u8 reg_debug_size;
-#endif
-
 	void *data;
 };
 
+
+#define RMI_PDT_ENTRY_SIZE 6
+#define RMI_PDT_FUNCTION_VERSION_MASK	0x60
+#define RMI_PDT_INT_SOURCE_COUNT_MASK	0x07
+
 #define PDT_START_SCAN_LOCATION 0x00e9
 #define PDT_END_SCAN_LOCATION	0x0005
 #define RMI4_END_OF_PDT(id) ((id) == 0x00 || (id) == 0xff)
 
 struct pdt_entry {
-	u8 query_base_addr:8;
-	u8 command_base_addr:8;
-	u8 control_base_addr:8;
-	u8 data_base_addr:8;
-	u8 interrupt_source_count:3;
-	u8 bits3and4:2;
-	u8 function_version:2;
-	u8 bit7:1;
-	u8 function_number:8;
-} __attribute__((__packed__));
-
-static inline void copy_pdt_entry_to_fd(struct pdt_entry *pdt,
-				 struct rmi_function_descriptor *fd,
-				 u16 page_start)
-{
-	fd->query_base_addr = pdt->query_base_addr + page_start;
-	fd->command_base_addr = pdt->command_base_addr + page_start;
-	fd->control_base_addr = pdt->control_base_addr + page_start;
-	fd->data_base_addr = pdt->data_base_addr + page_start;
-	fd->function_number = pdt->function_number;
-	fd->interrupt_source_count = pdt->interrupt_source_count;
-	fd->function_version = pdt->function_version;
-}
-
-bool rmi_is_physical_driver(struct device_driver *);
-int rmi_register_physical_driver(void);
-void rmi_unregister_physical_driver(void);
-
-int rmi_register_f01_handler(void);
-void rmi_unregister_f01_handler(void);
+	u8 query_base_addr;
+	u8 command_base_addr;
+	u8 control_base_addr;
+	u8 data_base_addr;
+	u8 interrupt_source_count;
+	u8 function_version;
+	u8 function_number;
+};
+
+int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
+			   u16 pdt_address);
+
+#ifdef	CONFIG_RMI4_FWLIB
+extern void rmi4_fw_update(struct rmi_device *rmi_dev,
+		struct pdt_entry *f01_pdt, struct pdt_entry *f34_pdt);
+#else
+#define rmi4_fw_update(rmi_dev, f01_pdt, f34_pdt) 0
+#endif
+
+extern struct rmi_driver rmi_physical_driver;
+extern struct rmi_function_driver rmi_f01_driver;
+
+int rmi_register_sensor_driver(void);
+void rmi_unregister_sensor_driver(void);
 
 #endif
diff --git a/drivers/input/rmi4/rmi_version.h b/drivers/input/rmi4/rmi_version.h
new file mode 100644
index 0000000..e205627
--- /dev/null
+++ b/drivers/input/rmi4/rmi_version.h
@@ -0,0 +1,16 @@
+#ifndef RMI_VERSION_H
+#define RMI_VERSION_H
+
+#define RMI_VERSION_MAJOR "1"
+#define RMI_VERSION_MINOR "8"
+#define RMI_VERSION_SUBMINOR "7"
+
+#define RMI_VERSION_BRANCH "master"
+#define RMI_EXTRA_NUMBER "1"
+#define RMI_EXTRA_STRING "master.0"
+
+#define RMI_DRIVER_VERSION RMI_VERSION_MAJOR "." \
+	RMI_VERSION_MINOR "." RMI_VERSION_SUBMINOR "-" \
+	RMI_EXTRA_STRING
+
+#endif
