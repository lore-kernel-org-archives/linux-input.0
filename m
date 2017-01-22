From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] Input: silead - Do not try to directly access the GPIO when using ACPI pm
Date: Sun, 22 Jan 2017 21:00:08 +0100
Message-ID: <20170122200008.27027-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbdAVUAL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Jan 2017 15:00:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

On some x86 tablets we cannot directly access the GPIOs as they are
claimed by the ACPI tables, so check it the i2c client is not being
power-managed by ACPI before trying to get the power pin GPIO.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Check acpi_bus_power_manageable() instead of trying to directly
 control the acpi power level ourselves
---
 drivers/input/touchscreen/silead.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 404830a..2fbcd7f 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -31,6 +31,7 @@
 #include <linux/irq.h>
 #include <linux/regulator/consumer.h>
 
+#include <acpi/acpi_bus.h>
 #include <asm/unaligned.h>
 
 #define SILEAD_TS_NAME		"silead_ts"
@@ -494,12 +495,21 @@ static int silead_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	/* Power GPIO pin */
-	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
-	if (IS_ERR(data->gpio_power)) {
-		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
-			dev_err(dev, "Shutdown GPIO request failed\n");
-		return PTR_ERR(data->gpio_power);
+	/*
+	 * If device power is not managed by ACPI, get the power_gpio
+	 * and manage it ourselves.
+	 */
+#ifdef CONFIG_ACPI
+	if (!acpi_bus_power_manageable(ACPI_HANDLE(dev)))
+#endif
+	{
+		data->gpio_power = devm_gpiod_get_optional(dev, "power",
+							   GPIOD_OUT_LOW);
+		if (IS_ERR(data->gpio_power)) {
+			if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
+				dev_err(dev, "Power GPIO request failed\n");
+			return PTR_ERR(data->gpio_power);
+		}
 	}
 
 	error = silead_ts_setup(client);
-- 
2.9.3

