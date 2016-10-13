From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 15/18] Input: synaptics-rmi4 - add rmi_platform
Date: Thu, 13 Oct 2016 17:51:09 +0200
Message-ID: <1476373872-18027-16-git-send-email-benjamin.tissoires@redhat.com>
References: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756348AbcJMPvy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Oct 2016 11:51:54 -0400
In-Reply-To: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

This driver is a glue between PS/2 devices that enumerate
the RMI4 device and the RMI4 SMBus driver.

We mostly use an intermediate platform device to not
add a dependency between psmouse and I2C. It also handles
the subtleties of going around the serio mutex lock by
deferring the i2c creation/destruction in a separate
thread.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

changes in v2:
- use alloc_ordered_workqueue instead of create_singlethread_workqueue
- Remove unneeded semicolon reported by scripts/coccinelle/misc/semicolon.cocci
---
 drivers/input/rmi4/Kconfig        |  12 ++
 drivers/input/rmi4/Makefile       |   1 +
 drivers/input/rmi4/rmi_platform.c | 235 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/input/rmi4/rmi_platform.c

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index eea1862..7a755fe 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -30,6 +30,7 @@ config RMI4_SPI
 config RMI4_SMB
 	tristate "RMI4 SMB Support"
 	depends on RMI4_CORE && I2C
+	select RMI4_PLATFORM
 	help
 	  Say Y here if you want to support RMI4 devices connected to an SMB
 	  bus.
@@ -39,6 +40,17 @@ config RMI4_SMB
 	  To compile this driver as a module, choose M here: the module will be
 	  called rmi_smbus.
 
+config RMI4_PLATFORM
+	tristate "RMI4 Platform Support"
+	depends on RMI4_CORE && RMI4_SMB && I2C
+	help
+	  Say Y here if you want to support RMI4 devices connected to an SMB
+	  bus but enumerated through PS/2.
+
+	  if unsure, say N.
+	  To compile this driver as a module, choose M here: the module will be
+	  called rmi_platform.
+
 config RMI4_F03
         bool "RMI4 Function 03 (PS2 Guest)"
         depends on RMI4_CORE
diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index 8271b65..c5a34ce 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -14,3 +14,4 @@ rmi_core-$(CONFIG_RMI4_F54) += rmi_f54.o
 obj-$(CONFIG_RMI4_I2C) += rmi_i2c.o
 obj-$(CONFIG_RMI4_SPI) += rmi_spi.o
 obj-$(CONFIG_RMI4_SMB) += rmi_smbus.o
+obj-$(CONFIG_RMI4_PLATFORM) += rmi_platform.o
diff --git a/drivers/input/rmi4/rmi_platform.c b/drivers/input/rmi4/rmi_platform.c
new file mode 100644
index 0000000..6d31aea
--- /dev/null
+++ b/drivers/input/rmi4/rmi_platform.c
@@ -0,0 +1,235 @@
+/*
+ * Copyright (c) 2016 Red Hat, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/rmi.h>
+#include <linux/slab.h>
+
+#define DRIVER_DESC	"RMI4 Platform PS/2 - SMBus bridge driver"
+
+MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@redhat.com>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+static struct workqueue_struct *krmi_wq;
+DEFINE_MUTEX(rmi_mutex);
+
+struct rmi_pltf {
+	struct i2c_client *smbus_client;
+	struct notifier_block i2c_notifier;
+	struct rmi_device_platform_data *pdata;
+};
+
+enum rmi_event_type {
+	RMI_REGISTER_DEVICE,
+	RMI_UNREGISTER_DEVICE,
+};
+
+struct rmi_work {
+	struct work_struct work;
+	enum rmi_event_type type;
+	struct rmi_pltf *rmi;
+	struct i2c_adapter *adap;
+};
+
+static void rmi_create_intertouch(struct rmi_pltf *rmi_pltf,
+				  struct i2c_adapter *adap)
+{
+	const struct i2c_board_info i2c_info = {
+		I2C_BOARD_INFO("rmi4_smbus", 0x2c),
+		.platform_data = rmi_pltf->pdata,
+	};
+
+	rmi_pltf->smbus_client = i2c_new_device(adap, &i2c_info);
+}
+
+static void rmi_worker(struct work_struct *work)
+{
+	struct rmi_work *rmi_work = container_of(work, struct rmi_work, work);
+
+	mutex_lock(&rmi_mutex);
+
+	switch (rmi_work->type) {
+	case RMI_REGISTER_DEVICE:
+		rmi_create_intertouch(rmi_work->rmi, rmi_work->adap);
+		break;
+	case RMI_UNREGISTER_DEVICE:
+		if (rmi_work->rmi->smbus_client)
+			i2c_unregister_device(rmi_work->rmi->smbus_client);
+		break;
+	}
+
+	kfree(rmi_work);
+
+	mutex_unlock(&rmi_mutex);
+}
+
+static int rmi_schedule_work(enum rmi_event_type type,
+			     struct rmi_pltf *rmi,
+			     struct i2c_adapter *adap)
+{
+	struct rmi_work *rmi_work = kzalloc(sizeof(*rmi_work), GFP_KERNEL);
+
+	if (!rmi_work)
+		return -ENOMEM;
+
+	rmi_work->type = type;
+	rmi_work->rmi = rmi;
+	rmi_work->adap = adap;
+
+	INIT_WORK(&rmi_work->work, rmi_worker);
+
+	queue_work(krmi_wq, &rmi_work->work);
+
+	return 0;
+}
+
+static int rmi_attach_i2c_device(struct device *dev, void *data)
+{
+	struct rmi_pltf *rmi_pltf = data;
+	struct i2c_adapter *adap;
+
+	if (dev->type != &i2c_adapter_type)
+		return 0;
+
+	adap = to_i2c_adapter(dev);
+
+	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_HOST_NOTIFY))
+		return 0;
+
+	if (rmi_pltf->smbus_client)
+		return 0;
+
+	rmi_schedule_work(RMI_REGISTER_DEVICE, rmi_pltf, adap);
+
+	pr_debug("rmi_platform: adapter [%s] registered\n", adap->name);
+	return 0;
+}
+
+static int rmi_detach_i2c_device(struct device *dev, struct rmi_pltf *rmi_pltf)
+{
+	struct i2c_client *client;
+
+	if (dev->type == &i2c_adapter_type)
+		return 0;
+
+	mutex_lock(&rmi_mutex);
+
+	client = to_i2c_client(dev);
+	if (client == rmi_pltf->smbus_client)
+		rmi_pltf->smbus_client = NULL;
+
+	mutex_unlock(&rmi_mutex);
+
+	pr_debug("rmi_platform: client [%s] unregistered\n", client->name);
+	return 0;
+}
+
+static int rmi_notifier_call(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct rmi_pltf *rmi_pltf;
+
+	rmi_pltf = container_of(nb, struct rmi_pltf, i2c_notifier);
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		return rmi_attach_i2c_device(dev, rmi_pltf);
+	case BUS_NOTIFY_DEL_DEVICE:
+		return rmi_detach_i2c_device(dev, rmi_pltf);
+	}
+
+	return 0;
+}
+
+static int rmi_probe(struct platform_device *pdev)
+{
+	struct rmi_device_platform_data *pdata = pdev->dev.platform_data;
+	struct rmi_pltf *rmi_pltf;
+	int error;
+
+	rmi_pltf = devm_kzalloc(&pdev->dev, sizeof(struct rmi_pltf),
+				GFP_KERNEL);
+	if (!rmi_pltf)
+		return -ENOMEM;
+
+	rmi_pltf->i2c_notifier.notifier_call = rmi_notifier_call;
+
+	rmi_pltf->pdata = pdata;
+
+	/* Keep track of adapters which will be added or removed later */
+	error = bus_register_notifier(&i2c_bus_type, &rmi_pltf->i2c_notifier);
+	if (error)
+		return error;
+
+	/* Bind to already existing adapters right away */
+	i2c_for_each_dev(rmi_pltf, rmi_attach_i2c_device);
+
+	platform_set_drvdata(pdev, rmi_pltf);
+
+	return 0;
+}
+
+static int rmi_remove(struct platform_device *pdev)
+{
+	struct rmi_pltf *rmi_pltf = platform_get_drvdata(pdev);
+
+	bus_unregister_notifier(&i2c_bus_type, &rmi_pltf->i2c_notifier);
+
+	if (rmi_pltf->smbus_client)
+		rmi_schedule_work(RMI_UNREGISTER_DEVICE, rmi_pltf, NULL);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static const struct platform_device_id rmi_id_table[] = {
+	{ .name = "rmi4" },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, rmi_id_table);
+
+static struct platform_driver rmi_drv = {
+	.driver		= {
+		.name	= "rmi4",
+	},
+	.probe		= rmi_probe,
+	.remove		= rmi_remove,
+	.id_table	= rmi_id_table,
+};
+
+static int __init rmi_init(void)
+{
+	int err;
+
+	krmi_wq = alloc_ordered_workqueue("krmid", WQ_MEM_RECLAIM);
+	if (!krmi_wq) {
+		pr_err("failed to create krmid workqueue\n");
+		return -ENOMEM;
+	}
+
+	err = platform_driver_register(&rmi_drv);
+	if (err)
+		destroy_workqueue(krmi_wq);
+
+	return err;
+}
+
+static void __exit rmi_exit(void)
+{
+	platform_driver_unregister(&rmi_drv);
+	destroy_workqueue(krmi_wq);
+}
+
+module_init(rmi_init);
+module_exit(rmi_exit);
-- 
2.7.4

