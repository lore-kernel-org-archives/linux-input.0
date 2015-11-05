From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 15/26] Input: synaptics-rmi4: Remove unused debugfs code
Date: Thu, 5 Nov 2015 15:40:56 -0800
Message-ID: <1446766856-30897-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:46027 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965324AbbKEXlE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Nov 2015 18:41:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

Previous versions of the driver reported statistics in debugfs.
But that code has been removed and debugfs is no longer used. This
patch removes all remaining debugfs code.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_bus.c    | 109 ++--------------------------------------
 drivers/input/rmi4/rmi_bus.h    |   6 ---
 drivers/input/rmi4/rmi_driver.h |  11 ----
 3 files changed, 3 insertions(+), 123 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 9222c7a..cb1577b 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -15,15 +15,10 @@
 #include <linux/rmi.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/debugfs.h>
 #include <linux/of.h>
 #include "rmi_bus.h"
 #include "rmi_driver.h"
 
-#ifdef CONFIG_RMI4_DEBUG
-static struct dentry *rmi_debugfs_root;
-#endif
-
 /*
  * RMI Physical devices
  *
@@ -49,34 +44,6 @@ bool rmi_is_physical_device(struct device *dev)
 	return dev->type == &rmi_device_type;
 }
 
-#ifdef CONFIG_RMI4_DEBUG
-
-static void rmi_physical_setup_debugfs(struct rmi_device *rmi_dev)
-{
-	rmi_dev->debugfs_root = debugfs_create_dir(dev_name(&rmi_dev->dev),
-						   rmi_debugfs_root);
-	if (!rmi_dev->debugfs_root)
-		dev_warn(&rmi_dev->dev, "Failed to create debugfs root.\n");
-}
-
-static void rmi_physical_teardown_debugfs(struct rmi_device *rmi_dev)
-{
-	if (rmi_dev->debugfs_root)
-		debugfs_remove_recursive(rmi_dev->debugfs_root);
-}
-
-#else
-
-static void rmi_physical_setup_debugfs(struct rmi_device *rmi_dev)
-{
-}
-
-static void rmi_physical_teardown_debugfs(struct rmi_device *rmi_dev)
-{
-}
-
-#endif
-
 /**
  * rmi_register_transport_device - register a transport device connection
  * on the RMI bus.  Transport drivers provide communication from the devices
@@ -107,8 +74,6 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
 
 	xport->rmi_dev = rmi_dev;
 
-	rmi_physical_setup_debugfs(rmi_dev);
-
 	error = device_add(&rmi_dev->dev);
 	if (error)
 		goto err_put_device;
@@ -119,7 +84,6 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
 	return 0;
 
 err_put_device:
-	rmi_physical_teardown_debugfs(rmi_dev);
 	put_device(&rmi_dev->dev);
 	return error;
 }
@@ -135,7 +99,6 @@ void rmi_unregister_transport_device(struct rmi_transport_dev *xport)
 	struct rmi_device *rmi_dev = xport->rmi_dev;
 
 	device_del(&rmi_dev->dev);
-	rmi_physical_teardown_debugfs(rmi_dev);
 	put_device(&rmi_dev->dev);
 }
 EXPORT_SYMBOL(rmi_unregister_transport_device);
@@ -160,37 +123,6 @@ bool rmi_is_function_device(struct device *dev)
 	return dev->type == &rmi_function_type;
 }
 
-#ifdef CONFIG_RMI4_DEBUG
-
-static void rmi_function_setup_debugfs(struct rmi_function *fn)
-{
-	char dirname[12];
-
-	snprintf(dirname, sizeof(dirname), "F%02X", fn->fd.function_number);
-	fn->debugfs_root = debugfs_create_dir(dirname,
-					      fn->rmi_dev->debugfs_root);
-	if (!fn->debugfs_root)
-		dev_warn(&fn->dev, "Failed to create debugfs dir.\n");
-}
-
-static void rmi_function_teardown_debugfs(struct rmi_function *fn)
-{
-	if (fn->debugfs_root)
-		debugfs_remove_recursive(fn->debugfs_root);
-}
-
-#else
-
-static void rmi_function_setup_debugfs(struct rmi_function *fn)
-{
-}
-
-static void rmi_function_teardown_debugfs(struct rmi_function *fn)
-{
-}
-
-#endif
-
 static int rmi_function_match(struct device *dev, struct device_driver *drv)
 {
 	struct rmi_function_handler *handler = to_rmi_function_handler(drv);
@@ -257,29 +189,26 @@ int rmi_register_function(struct rmi_function *fn)
 	fn->dev.type = &rmi_function_type;
 	fn->dev.bus = &rmi_bus_type;
 
-	rmi_function_setup_debugfs(fn);
-
 	error = device_add(&fn->dev);
 	if (error) {
 		dev_err(&rmi_dev->dev,
 			"Failed device_register function device %s\n",
 			dev_name(&fn->dev));
-		goto err_teardown_debugfs;
+		goto err_put_device;
 	}
 
 	dev_dbg(&rmi_dev->dev, "Registered F%02X.\n", fn->fd.function_number);
 
 	return 0;
 
-err_teardown_debugfs:
-	rmi_function_teardown_debugfs(fn);
+err_put_device:
+	put_device(&fn->dev);
 	return error;
 }
 
 void rmi_unregister_function(struct rmi_function *fn)
 {
 	device_del(&fn->dev);
-	rmi_function_teardown_debugfs(fn);
 
 	if (fn->dev.of_node)
 		of_node_put(fn->dev.of_node);
@@ -406,34 +335,6 @@ int rmi_of_property_read_u8(struct device *dev, u8 *result,
 }
 EXPORT_SYMBOL_GPL(rmi_of_property_read_u8);
 
-#ifdef CONFIG_RMI4_DEBUG
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
 static int __init rmi_bus_init(void)
 {
 	int error;
@@ -445,8 +346,6 @@ static int __init rmi_bus_init(void)
 		return error;
 	}
 
-	rmi_bus_setup_debugfs();
-
 	error = rmi_register_f01_handler();
 	if (error) {
 		pr_err("%s: error registering the RMI F01 handler: %d\n",
@@ -475,7 +374,6 @@ err_unregister_f11:
 err_unregister_f01:
 	rmi_unregister_f01_handler();
 err_unregister_bus:
-	rmi_bus_teardown_debugfs();
 	bus_unregister(&rmi_bus_type);
 	return error;
 }
@@ -491,7 +389,6 @@ static void __exit rmi_bus_exit(void)
 	rmi_unregister_physical_driver();
 	rmi_unregister_f11_handler();
 	rmi_unregister_f01_handler();
-	rmi_bus_teardown_debugfs();
 	bus_unregister(&rmi_bus_type);
 }
 module_exit(rmi_bus_exit);
diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index ecd0b8e..71c9005 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -19,7 +19,6 @@
 #include <linux/stat.h>
 #include <linux/types.h>
 #include <linux/wait.h>
-#include <linux/debugfs.h>
 #include <linux/rmi.h>
 
 struct rmi_device;
@@ -39,7 +38,6 @@ struct rmi_device;
  * @data: Private data pointer
  *
  * @node: entry in device's list of functions
- * @debugfs_root: used during debugging
  */
 struct rmi_function {
 	struct rmi_function_descriptor fd;
@@ -47,10 +45,6 @@ struct rmi_function {
 	struct device dev;
 	struct list_head node;
 
-#ifdef CONFIG_RMI4_DEBUG
-	struct dentry *debugfs_root;
-#endif
-
 	unsigned int num_of_irqs;
 	unsigned int irq_pos;
 	unsigned long irq_mask[];
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 4e99e48..833e954 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -74,17 +74,6 @@ struct rmi_driver_data {
 	int (*post_resume) (const void *pm_data);
 #endif
 
-#ifdef CONFIG_RMI4_DEBUG
-	struct dentry *debugfs_delay;
-	struct dentry *debugfs_xport;
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
 
-- 
2.1.4

