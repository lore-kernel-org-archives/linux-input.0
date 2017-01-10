From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 10/10] Input: elantech - automatically bind an SMBus device when acceptable
Date: Tue, 10 Jan 2017 17:11:28 +0100
Message-ID: <20170110161128.7441-11-benjamin.tissoires@redhat.com>
References: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Andrew Duggan <aduggan@synaptics.com>
Cc: Adrian Alves <aalves@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In the same way Synaptics devices can use a secondary bus with a better
bandwidth, Elantech touchpads can also be talked over SMBus.

It's unclear right now which devices have this capability, so use a module
parameter to enable/disable this. We can then whitelist them until we find
a more reliable way of detecting them.

When provided, elan_i2c also prevents the PS/2 node from resuming by
calling serio_deactivate().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/misc/ps2_smbus.c      | 23 +++++++++++++++-
 drivers/input/mouse/elan_i2c.h      |  2 ++
 drivers/input/mouse/elan_i2c_core.c |  8 ++++++
 drivers/input/mouse/elantech.c      | 54 +++++++++++++++++++++++++++++++++++++
 drivers/input/mouse/elantech.h      |  3 +++
 5 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/ps2_smbus.c b/drivers/input/misc/ps2_smbus.c
index d1f27ed..2463afd 100644
--- a/drivers/input/misc/ps2_smbus.c
+++ b/drivers/input/misc/ps2_smbus.c
@@ -23,6 +23,7 @@ DEFINE_MUTEX(ps2smbus_mutex);
 
 enum ps2smbus_type {
 	PS2SMBUS_SYNAPTICS_RMI4,
+	PS2SMBUS_ELAN_SMBUS,
 };
 
 struct ps2smbus {
@@ -56,6 +57,18 @@ static void ps2smbus_create_rmi4(struct ps2smbus *ps2smbus,
 	ps2smbus->smbus_client = i2c_new_device(adap, &i2c_info);
 }
 
+static void ps2smbus_create_elan(struct ps2smbus *ps2smbus,
+				 struct i2c_adapter *adap)
+{
+	const struct i2c_board_info i2c_info = {
+		I2C_BOARD_INFO("elan_i2c", 0x15),
+		.platform_data = ps2smbus->pdata,
+		.flags = I2C_CLIENT_HOST_NOTIFY,
+	};
+
+	ps2smbus->smbus_client = i2c_new_device(adap, &i2c_info);
+}
+
 static void ps2smbus_worker(struct work_struct *work)
 {
 	struct ps2smbus_work *ps2smbus_work;
@@ -68,9 +81,16 @@ static void ps2smbus_worker(struct work_struct *work)
 
 	switch (ps2smbus_work->type) {
 	case PS2SMBUS_REGISTER_DEVICE:
-		if (ps2smbus_work->ps2smbus->type == PS2SMBUS_SYNAPTICS_RMI4)
+		switch (ps2smbus_work->ps2smbus->type) {
+		case PS2SMBUS_SYNAPTICS_RMI4:
 			ps2smbus_create_rmi4(ps2smbus_work->ps2smbus,
 					     ps2smbus_work->adap);
+			break;
+		case PS2SMBUS_ELAN_SMBUS:
+			ps2smbus_create_elan(ps2smbus_work->ps2smbus,
+					     ps2smbus_work->adap);
+			break;
+		}
 		break;
 	case PS2SMBUS_UNREGISTER_DEVICE:
 		if (client)
@@ -215,6 +235,7 @@ static int ps2smbus_remove(struct platform_device *pdev)
 
 static const struct platform_device_id ps2smbus_id_table[] = {
 	{ .name = "rmi4", .driver_data = PS2SMBUS_SYNAPTICS_RMI4 },
+	{ .name = "elan_smbus", .driver_data = PS2SMBUS_ELAN_SMBUS },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, ps2smbus_id_table);
diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/elan_i2c.h
index 468763a..d555015 100644
--- a/drivers/input/mouse/elan_i2c.h
+++ b/drivers/input/mouse/elan_i2c.h
@@ -37,6 +37,7 @@
 #define ETP_FW_SIGNATURE_SIZE	6
 
 struct i2c_client;
+struct serio;
 struct completion;
 
 enum tp_mode {
@@ -93,6 +94,7 @@ extern const struct elan_transport_ops elan_smbus_ops, elan_i2c_ops;
  * be created and handled by the driver.
  */
 struct elan_platform_data {
+	struct serio *parent;
 	bool trackpoint;
 };
 
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index ca9adf7..97ff61d 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/serio.h>
 #include <linux/input.h>
 #include <linux/uaccess.h>
 #include <linux/jiffies.h>
@@ -1092,6 +1093,7 @@ static int elan_probe(struct i2c_client *client,
 	const struct elan_transport_ops *transport_ops;
 	struct device *dev = &client->dev;
 	struct elan_tp_data *data;
+	struct serio *parent = NULL;
 	unsigned long irqflags;
 	bool has_trackpoint = pdata && pdata->trackpoint;
 	int error;
@@ -1122,6 +1124,12 @@ static int elan_probe(struct i2c_client *client,
 	init_completion(&data->fw_completion);
 	mutex_init(&data->sysfs_mutex);
 
+	if (pdata)
+		parent = pdata->parent;
+
+	/* Make sure the driver stays here on resume */
+	serio_deactivate(parent);
+
 	data->vcc = devm_regulator_get(&client->dev, "vcc");
 	if (IS_ERR(data->vcc)) {
 		error = PTR_ERR(data->vcc);
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index db7d1d6..f83940d 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -16,11 +16,28 @@
 #include <linux/module.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
+#include <linux/platform_device.h>
 #include <linux/serio.h>
 #include <linux/libps2.h>
 #include <asm/unaligned.h>
 #include "psmouse.h"
 #include "elantech.h"
+#include "elan_i2c.h"
+
+/*
+ * The newest Elan devices can use a secondary bus (over SMBus) which
+ * provides a better bandwidth and allow a better control of the touchpads.
+ * This is used to decide if we need to use this bus or not.
+ */
+enum {
+	ELAN_SMBUS_NOT_SET = -1,
+	ELAN_SMBUS_OFF,
+	ELAN_SMBUS_ON,
+};
+
+static int elan_smbus = ELAN_SMBUS_OFF;
+module_param_named(elan_smbus, elan_smbus, int, 0644);
+MODULE_PARM_DESC(elan_smbus, "Use a secondary bus for the Elantech device.");
 
 #define elantech_debug(fmt, ...)					\
 	do {								\
@@ -1470,6 +1487,11 @@ static void elantech_disconnect(struct psmouse *psmouse)
 {
 	struct elantech_data *etd = psmouse->private;
 
+	if (etd->smbus) {
+		platform_device_unregister(etd->smbus);
+		etd->smbus = NULL;
+	}
+
 	if (etd->tp_dev)
 		input_unregister_device(etd->tp_dev);
 	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
@@ -1629,6 +1651,35 @@ static int elantech_set_properties(struct elantech_data *etd)
 	return 0;
 }
 
+static int smbus_id;
+
+static int elan_create_smbus(struct psmouse *psmouse, struct elantech_data *etd)
+{
+	struct platform_device *pdev;
+	struct platform_device_info pdevinfo;
+	struct elan_platform_data pdata = {
+		.trackpoint = !!etd->tp_dev,
+	};
+
+	if (etd->smbus)
+		return -EINVAL;
+
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+	pdevinfo.name = "elan_smbus";
+	pdevinfo.id = smbus_id++;
+	pdevinfo.data = &pdata;
+	pdevinfo.size_data = sizeof(pdata);
+	pdevinfo.parent = &psmouse->ps2dev.serio->dev;
+
+	pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	etd->smbus = pdev;
+
+	return 0;
+}
+
 /*
  * Initialize the touchpad and create sysfs entries
  */
@@ -1751,6 +1802,9 @@ int elantech_init(struct psmouse *psmouse)
 	psmouse->reconnect = elantech_reconnect;
 	psmouse->pktsize = etd->hw_version > 1 ? 6 : 4;
 
+	if (etd->hw_version == 4 && elan_smbus == ELAN_SMBUS_ON)
+		elan_create_smbus(psmouse, etd);
+
 	return 0;
  init_fail_tp_reg:
 	input_free_device(tp_dev);
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index e1cbf40..299f2e3d 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -144,6 +144,9 @@ struct elantech_data {
 	unsigned char parity[256];
 	int (*send_cmd)(struct psmouse *psmouse, unsigned char c, unsigned char *param);
 	void (*original_set_rate)(struct psmouse *psmouse, unsigned int rate);
+
+	/* SMBus handling */
+	struct platform_device *smbus;
 };
 
 #ifdef CONFIG_MOUSE_PS2_ELANTECH
-- 
2.9.3
