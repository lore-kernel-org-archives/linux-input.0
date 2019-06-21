From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v8 1/5] Input: elan_i2c: Export the device id whitelist
Date: Fri, 21 Jun 2019 07:50:42 -0700
Message-ID: <20190621145042.38637-1-jeffrey.l.hugo@gmail.com>
References: <20190621144854.38568-1-jeffrey.l.hugo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621144854.38568-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, jikos@kernel.org, hdegoede@redhat.com
Cc: bjorn.andersson@linaro.org, agross@kernel.org, lee.jones@linaro.org, xnox@ubuntu.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
List-Id: linux-input@vger.kernel.org

Elan_i2c and hid-quirks work in conjunction to decide which devices each
driver will handle.  Elan_i2c has a whitelist of devices that should be
consumed by hid-quirks so that there is one master list of devices to
handoff between the drivers.  Put the ids in a header file so that
hid-quirks can consume it instead of duplicating the list.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c | 50 +------------------
 include/linux/input/elan-i2c-ids.h  | 76 +++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 49 deletions(-)
 create mode 100644 include/linux/input/elan-i2c-ids.h

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 65cd325eabc3..e2c824abd19c 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -37,6 +37,7 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/property.h>
+#include <linux/input/elan-i2c-ids.h>
 #include <linux/regulator/consumer.h>
 #include <asm/unaligned.h>
 
@@ -1375,55 +1376,6 @@ static const struct i2c_device_id elan_id[] = {
 MODULE_DEVICE_TABLE(i2c, elan_id);
 
 #ifdef CONFIG_ACPI
-static const struct acpi_device_id elan_acpi_id[] = {
-	{ "ELAN0000", 0 },
-	{ "ELAN0100", 0 },
-	{ "ELAN0600", 0 },
-	{ "ELAN0601", 0 },
-	{ "ELAN0602", 0 },
-	{ "ELAN0603", 0 },
-	{ "ELAN0604", 0 },
-	{ "ELAN0605", 0 },
-	{ "ELAN0606", 0 },
-	{ "ELAN0607", 0 },
-	{ "ELAN0608", 0 },
-	{ "ELAN0609", 0 },
-	{ "ELAN060B", 0 },
-	{ "ELAN060C", 0 },
-	{ "ELAN060F", 0 },
-	{ "ELAN0610", 0 },
-	{ "ELAN0611", 0 },
-	{ "ELAN0612", 0 },
-	{ "ELAN0615", 0 },
-	{ "ELAN0616", 0 },
-	{ "ELAN0617", 0 },
-	{ "ELAN0618", 0 },
-	{ "ELAN0619", 0 },
-	{ "ELAN061A", 0 },
-	{ "ELAN061B", 0 },
-	{ "ELAN061C", 0 },
-	{ "ELAN061D", 0 },
-	{ "ELAN061E", 0 },
-	{ "ELAN061F", 0 },
-	{ "ELAN0620", 0 },
-	{ "ELAN0621", 0 },
-	{ "ELAN0622", 0 },
-	{ "ELAN0623", 0 },
-	{ "ELAN0624", 0 },
-	{ "ELAN0625", 0 },
-	{ "ELAN0626", 0 },
-	{ "ELAN0627", 0 },
-	{ "ELAN0628", 0 },
-	{ "ELAN0629", 0 },
-	{ "ELAN062A", 0 },
-	{ "ELAN062B", 0 },
-	{ "ELAN062C", 0 },
-	{ "ELAN062D", 0 },
-	{ "ELAN0631", 0 },
-	{ "ELAN0632", 0 },
-	{ "ELAN1000", 0 },
-	{ }
-};
 MODULE_DEVICE_TABLE(acpi, elan_acpi_id);
 #endif
 
diff --git a/include/linux/input/elan-i2c-ids.h b/include/linux/input/elan-i2c-ids.h
new file mode 100644
index 000000000000..ceabb01a6a7d
--- /dev/null
+++ b/include/linux/input/elan-i2c-ids.h
@@ -0,0 +1,76 @@
+/*
+ * Elan I2C/SMBus Touchpad device whitelist
+ *
+ * Copyright (c) 2013 ELAN Microelectronics Corp.
+ *
+ * Author: æ維 (Duson Lin) <dusonlin@emc.com.tw>
+ * Author: KT Liao <kt.liao@emc.com.tw>
+ * Version: 1.6.3
+ *
+ * Based on cyapa driver:
+ * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
+ * copyright (c) 2011-2012 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Trademarks are the property of their respective owners.
+ */
+
+#ifndef __ELAN_I2C_IDS_H
+#define __ELAN_I2C_IDS_H
+
+#include <linux/mod_devicetable.h>
+
+static const struct acpi_device_id elan_acpi_id[] = {
+	{ "ELAN0000", 0 },
+	{ "ELAN0100", 0 },
+	{ "ELAN0600", 0 },
+	{ "ELAN0601", 0 },
+	{ "ELAN0602", 0 },
+	{ "ELAN0603", 0 },
+	{ "ELAN0604", 0 },
+	{ "ELAN0605", 0 },
+	{ "ELAN0606", 0 },
+	{ "ELAN0607", 0 },
+	{ "ELAN0608", 0 },
+	{ "ELAN0609", 0 },
+	{ "ELAN060B", 0 },
+	{ "ELAN060C", 0 },
+	{ "ELAN060F", 0 },
+	{ "ELAN0610", 0 },
+	{ "ELAN0611", 0 },
+	{ "ELAN0612", 0 },
+	{ "ELAN0615", 0 },
+	{ "ELAN0616", 0 },
+	{ "ELAN0617", 0 },
+	{ "ELAN0618", 0 },
+	{ "ELAN0619", 0 },
+	{ "ELAN061A", 0 },
+	{ "ELAN061B", 0 },
+	{ "ELAN061C", 0 },
+	{ "ELAN061D", 0 },
+	{ "ELAN061E", 0 },
+	{ "ELAN061F", 0 },
+	{ "ELAN0620", 0 },
+	{ "ELAN0621", 0 },
+	{ "ELAN0622", 0 },
+	{ "ELAN0623", 0 },
+	{ "ELAN0624", 0 },
+	{ "ELAN0625", 0 },
+	{ "ELAN0626", 0 },
+	{ "ELAN0627", 0 },
+	{ "ELAN0628", 0 },
+	{ "ELAN0629", 0 },
+	{ "ELAN062A", 0 },
+	{ "ELAN062B", 0 },
+	{ "ELAN062C", 0 },
+	{ "ELAN062D", 0 },
+	{ "ELAN0631", 0 },
+	{ "ELAN0632", 0 },
+	{ "ELAN1000", 0 },
+	{ }
+};
+
+#endif /* __ELAN_I2C_IDS_H */
-- 
2.17.1
