From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 3/4] Input: icn8318 - Add support for ACPI enumeration
Date: Sun, 18 Jun 2017 12:18:28 +0200
Message-ID: <20170618101829.18734-3-hdegoede@redhat.com>
References: <20170618101829.18734-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdFRKSg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Jun 2017 06:18:36 -0400
In-Reply-To: <20170618101829.18734-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

The icn8505 variant is found on some x86 tablets, which use ACPI
enumeration, add support for ACPI enumeration.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Drop the code to get resolution from a table based on the _SUB ACPI
 string, we now read it directly from the controller
---
 drivers/input/touchscreen/Kconfig           |  2 +-
 drivers/input/touchscreen/chipone_icn8318.c | 44 ++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index fff1467506e7..e3b52d356e13 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -155,7 +155,7 @@ config TOUCHSCREEN_CHIPONE_ICN8318
 	tristate "chipone icn8318 touchscreen controller"
 	depends on GPIOLIB || COMPILE_TEST
 	depends on I2C
-	depends on OF
+	depends on OF || ACPI
 	help
 	  Say Y here if you have a ChipOne icn8318 or icn8505 based
 	  I2C touchscreen.
diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
index 43cc38734d8e..7a28caef1475 100644
--- a/drivers/input/touchscreen/chipone_icn8318.c
+++ b/drivers/input/touchscreen/chipone_icn8318.c
@@ -12,6 +12,7 @@
  * Hans de Goede <hdegoede@redhat.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
@@ -235,6 +236,43 @@ static int icn8318_probe_of(struct icn8318_data *data, struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id icn8318_acpi_match[] = {
+	{ "CHPN0001", ICN8505 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, icn8318_acpi_match);
+
+static int icn8318_probe_acpi(struct icn8318_data *data, struct device *dev)
+{
+	const struct acpi_device_id *id;
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(dev);
+	id = acpi_match_device(icn8318_acpi_match, dev);
+	if (!adev || !id)
+		return -ENODEV;
+
+	data->model = id->driver_data;
+
+	/*
+	 * Disable ACPI power management the _PS3 method is empty, so
+	 * there is no powersaving when using ACPI power management.
+	 * The _PS0 method resets the controller causing it to loose its
+	 * firmware, which has been loaded by the BIOS and we do not
+	 * know how to restore the firmware.
+	 */
+	adev->flags.power_manageable = 0;
+
+	return 0;
+}
+#else
+static int icn8318_probe_acpi(struct icn8318_data *data, struct device *dev)
+{
+	return -ENODEV;
+}
+#endif
+
 static int icn8318_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -268,7 +306,10 @@ static int icn8318_probe(struct i2c_client *client)
 	input_set_capability(input, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input, EV_ABS, ABS_MT_POSITION_Y);
 
-	error = icn8318_probe_of(data, dev);
+	if (client->dev.of_node)
+		error = icn8318_probe_of(data, dev);
+	else
+		error = icn8318_probe_acpi(data, dev);
 	if (error)
 		return error;
 
@@ -340,6 +381,7 @@ static struct i2c_driver icn8318_driver = {
 	.driver = {
 		.name	= "chipone_icn8318",
 		.pm	= &icn8318_pm_ops,
+		.acpi_match_table = ACPI_PTR(icn8318_acpi_match),
 		.of_match_table = icn8318_of_match,
 	},
 	.probe_new = icn8318_probe,
-- 
2.13.0

