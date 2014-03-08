From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH 01/05] input synaptics-rmi4: Split F01 definitions out into header file for use by reflash.
Date: Fri, 7 Mar 2014 18:29:51 -0800
Message-ID: <1394245795-17347-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:13277 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbaCHCaF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Mar 2014 21:30:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---

 drivers/input/rmi4/rmi_f01.c |  96 ++-----------------------------------
 drivers/input/rmi4/rmi_f01.h | 110 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 92 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index ee5f4a1..41cb795 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -13,95 +13,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include "rmi_driver.h"
-
-#define RMI_PRODUCT_ID_LENGTH    10
-#define RMI_PRODUCT_INFO_LENGTH   2
-
-#define RMI_DATE_CODE_LENGTH      3
-
-#define PRODUCT_ID_OFFSET 0x10
-#define PRODUCT_INFO_OFFSET 0x1E
-
-
-/* Force a firmware reset of the sensor */
-#define RMI_F01_CMD_DEVICE_RESET	1
-
-/* Various F01_RMI_QueryX bits */
-
-#define RMI_F01_QRY1_CUSTOM_MAP		(1 << 0)
-#define RMI_F01_QRY1_NON_COMPLIANT	(1 << 1)
-#define RMI_F01_QRY1_HAS_LTS		(1 << 2)
-#define RMI_F01_QRY1_HAS_SENSOR_ID	(1 << 3)
-#define RMI_F01_QRY1_HAS_CHARGER_INP	(1 << 4)
-#define RMI_F01_QRY1_HAS_ADJ_DOZE	(1 << 5)
-#define RMI_F01_QRY1_HAS_ADJ_DOZE_HOFF	(1 << 6)
-#define RMI_F01_QRY1_HAS_PROPS_2	(1 << 7)
-
-#define RMI_F01_QRY5_YEAR_MASK		0x1f
-#define RMI_F01_QRY6_MONTH_MASK		0x0f
-#define RMI_F01_QRY7_DAY_MASK		0x1f
-
-#define RMI_F01_QRY2_PRODINFO_MASK	0x7f
-
-#define RMI_F01_BASIC_QUERY_LEN		21 /* From Query 00 through 20 */
-
-struct f01_basic_properties {
-	u8 manufacturer_id;
-	bool has_lts;
-	bool has_adjustable_doze;
-	bool has_adjustable_doze_holdoff;
-	char dom[11]; /* YYYY/MM/DD + '\0' */
-	u8 product_id[RMI_PRODUCT_ID_LENGTH + 1];
-	u16 productinfo;
-};
-
-/* F01 device status bits */
-
-/* Most recent device status event */
-#define RMI_F01_STATUS_CODE(status)		((status) & 0x0f)
-/* The device has lost its configuration for some reason. */
-#define RMI_F01_STATUS_UNCONFIGURED(status)	(!!((status) & 0x80))
-
-/* Control register bits */
-
-/*
- * Sleep mode controls power management on the device and affects all
- * functions of the device.
- */
-#define RMI_F01_CTRL0_SLEEP_MODE_MASK	0x03
-
-#define RMI_SLEEP_MODE_NORMAL		0x00
-#define RMI_SLEEP_MODE_SENSOR_SLEEP	0x01
-#define RMI_SLEEP_MODE_RESERVED0	0x02
-#define RMI_SLEEP_MODE_RESERVED1	0x03
-
-#define RMI_IS_VALID_SLEEPMODE(mode) \
-	(mode >= RMI_SLEEP_MODE_NORMAL && mode <= RMI_SLEEP_MODE_RESERVED1)
-
-/*
- * This bit disables whatever sleep mode may be selected by the sleep_mode
- * field and forces the device to run at full power without sleeping.
- */
-#define RMI_F01_CRTL0_NOSLEEP_BIT	(1 << 2)
-
-/*
- * When this bit is set, the touch controller employs a noise-filtering
- * algorithm designed for use with a connected battery charger.
- */
-#define RMI_F01_CRTL0_CHARGER_BIT	(1 << 5)
-
-/*
- * Sets the report rate for the device. The effect of this setting is
- * highly product dependent. Check the spec sheet for your particular
- * touch sensor.
- */
-#define RMI_F01_CRTL0_REPORTRATE_BIT	(1 << 6)
-
-/*
- * Written by the host as an indicator that the device has been
- * successfully configured.
- */
-#define RMI_F01_CRTL0_CONFIGURED_BIT	(1 << 7)
+#include "rmi_f01.h"
 
 /**
  * @ctrl0 - see the bit definitions above.
@@ -136,8 +48,7 @@ struct f01_data {
 	unsigned int num_of_irq_regs;
 };
 
-static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
-				   u16 query_base_addr,
+int rmi_f01_read_properties(struct rmi_device *rmi_dev, u16 query_base_addr,
 				   struct f01_basic_properties *props)
 {
 	u8 basic_query[RMI_F01_BASIC_QUERY_LEN];
@@ -180,7 +91,8 @@ static int rmi_f01_probe(struct rmi_function *fn)
 {
 	struct rmi_device *rmi_dev = fn->rmi_dev;
 	struct rmi_driver_data *driver_data = dev_get_drvdata(&rmi_dev->dev);
-	const struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
+	const struct rmi_device_platform_data *pdata =
+						rmi_get_platform_data(rmi_dev);
 	struct f01_data *f01;
 	int error;
 	u16 ctrl_base_addr = fn->fd.control_base_addr;
diff --git a/drivers/input/rmi4/rmi_f01.h b/drivers/input/rmi4/rmi_f01.h
new file mode 100644
index 0000000..9e5cc2b
--- /dev/null
+++ b/drivers/input/rmi4/rmi_f01.h
@@ -0,0 +1,110 @@
+/*
+ * Copyright (c) 2014 Synaptics Incorporated
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _RMI_F01_H
+#define _RMI_F01_H
+
+
+#define RMI_PRODUCT_ID_LENGTH    10
+#define RMI_PRODUCT_INFO_LENGTH   2
+
+#define RMI_DATE_CODE_LENGTH      3
+
+#define PRODUCT_ID_OFFSET 0x10
+#define PRODUCT_INFO_OFFSET 0x1E
+
+
+/* Force a firmware reset of the sensor */
+#define RMI_F01_CMD_DEVICE_RESET	1
+
+/* Various F01_RMI_QueryX bits */
+
+#define RMI_F01_QRY1_CUSTOM_MAP		(1 << 0)
+#define RMI_F01_QRY1_NON_COMPLIANT	(1 << 1)
+#define RMI_F01_QRY1_HAS_LTS		(1 << 2)
+#define RMI_F01_QRY1_HAS_SENSOR_ID	(1 << 3)
+#define RMI_F01_QRY1_HAS_CHARGER_INP	(1 << 4)
+#define RMI_F01_QRY1_HAS_ADJ_DOZE	(1 << 5)
+#define RMI_F01_QRY1_HAS_ADJ_DOZE_HOFF	(1 << 6)
+#define RMI_F01_QRY1_HAS_PROPS_2	(1 << 7)
+
+#define RMI_F01_QRY5_YEAR_MASK		0x1f
+#define RMI_F01_QRY6_MONTH_MASK		0x0f
+#define RMI_F01_QRY7_DAY_MASK		0x1f
+
+#define RMI_F01_QRY2_PRODINFO_MASK	0x7f
+
+#define RMI_F01_BASIC_QUERY_LEN		21 /* From Query 00 through 20 */
+
+struct f01_basic_properties {
+	u8 manufacturer_id;
+	bool has_lts;
+	bool has_adjustable_doze;
+	bool has_adjustable_doze_holdoff;
+	char dom[11]; /* YYYY/MM/DD + '\0' */
+	u8 product_id[RMI_PRODUCT_ID_LENGTH + 1];
+	u16 productinfo;
+};
+
+/* F01 device status bits */
+
+/* Most recent device status event */
+#define RMI_F01_STATUS_CODE(status)		((status) & 0x0f)
+/* The device has lost its configuration for some reason. */
+#define RMI_F01_STATUS_UNCONFIGURED(status)	(!!((status) & 0x80))
+
+/* Control register bits */
+
+/*
+ * Sleep mode controls power management on the device and affects all
+ * functions of the device.
+ */
+#define RMI_F01_CTRL0_SLEEP_MODE_MASK	0x03
+
+#define RMI_SLEEP_MODE_NORMAL		0x00
+#define RMI_SLEEP_MODE_SENSOR_SLEEP	0x01
+#define RMI_SLEEP_MODE_RESERVED0	0x02
+#define RMI_SLEEP_MODE_RESERVED1	0x03
+
+#define RMI_IS_VALID_SLEEPMODE(mode) \
+	(mode >= RMI_SLEEP_MODE_NORMAL && mode <= RMI_SLEEP_MODE_RESERVED1)
+
+/*
+ * This bit disables whatever sleep mode may be selected by the sleep_mode
+ * field and forces the device to run at full power without sleeping.
+ */
+#define RMI_F01_CRTL0_NOSLEEP_BIT	(1 << 2)
+
+/*
+ * When this bit is set, the touch controller employs a noise-filtering
+ * algorithm designed for use with a connected battery charger.
+ */
+#define RMI_F01_CRTL0_CHARGER_BIT	(1 << 5)
+
+/*
+ * Sets the report rate for the device. The effect of this setting is
+ * highly product dependent. Check the spec sheet for your particular
+ * touch sensor.
+ */
+#define RMI_F01_CRTL0_REPORTRATE_BIT	(1 << 6)
+
+/*
+ * Written by the host as an indicator that the device has been
+ * successfully configured.
+ */
+#define RMI_F01_CRTL0_CONFIGURED_BIT	(1 << 7)
+
+/** Read the F01 query registers and populate the basic_properties structure.
+ * @rmi_dev - the device to be queries.
+ * @query_base_addr - address of the start of the query registers.
+ * @props - pointer to the structure to be filled in.
+ */
+int rmi_f01_read_properties(struct rmi_device *rmi_dev, u16 query_base_addr,
+			    struct f01_basic_properties *props);
+
+#endif
