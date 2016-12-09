From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/4] Input: silead_gsl1680: Add support for setting resolution based on dmi data
Date: Fri,  9 Dec 2016 11:35:22 +0100
Message-ID: <20161209103522.3833-4-hdegoede@redhat.com>
References: <20161209103522.3833-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932349AbcLIKf3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Dec 2016 05:35:29 -0500
In-Reply-To: <20161209103522.3833-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On ACPI based tablets, the ACPI touchscreen node only contains info on
the gpio and the irq, and is missing any info on the axis. This info is
expected to be built into the tablet model specific version of the driver
shipped with the os-image for the device.

Add support for getting the missing info from a table built into the
driver, using dmi data to identify which entry of the table to use and
add info for the CUBE iwork8 Air tablet on which this code was tested /
developed.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=187531
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/silead.c | 51 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index d6593bb..f32b029 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -20,6 +20,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/interrupt.h>
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
@@ -87,6 +88,38 @@ struct silead_fw_data {
 	u32 val;
 };
 
+#ifdef CONFIG_DMI
+struct silead_driver_data {
+	struct touchscreen_properties prop;
+	const char *fw_name;
+	u32 max_fingers;
+};
+
+static struct silead_driver_data cube_iwork8_air_driver_data = {
+	.prop = {
+		.max_x = 1659,
+		.max_y = 899,
+		.swap_x_y = true,
+	},
+	.fw_name = "gsl3670-cube-iwork8-air.fw",
+	.max_fingers = 5,
+};
+
+static const struct dmi_system_id silead_ts_dmi_table[] = {
+	{
+	 .ident = "CUBE iwork8 Air",
+	 .driver_data = &cube_iwork8_air_driver_data,
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "cube"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "i1-TF"),
+		DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+		},
+	},
+
+	{ },
+};
+#endif
+
 static int silead_ts_request_input_dev(struct silead_ts_data *data)
 {
 	struct device *dev = &data->client->dev;
@@ -385,11 +418,27 @@ static void silead_ts_read_props(struct i2c_client *client)
 	const char *str;
 	int error;
 
+#ifdef CONFIG_DMI
+	const struct dmi_system_id *dmi_id;
+
+	dmi_id = dmi_first_match(silead_ts_dmi_table);
+	if (dmi_id) {
+		struct silead_driver_data *driver_data = dmi_id->driver_data;
+
+		data->prop = driver_data->prop;
+		snprintf(data->fw_name, sizeof(data->fw_name),
+			 "silead/%s", driver_data->fw_name);
+		data->max_fingers = driver_data->max_fingers;
+	}
+#endif
+
 	error = device_property_read_u32(dev, "silead,max-fingers",
 					 &data->max_fingers);
 	if (error) {
 		dev_dbg(dev, "Max fingers read error %d\n", error);
-		data->max_fingers = 5; /* Most devices handle up-to 5 fingers */
+		/* Most devices handle up-to 5 fingers */
+		if (data->max_fingers == 0)
+			data->max_fingers = 5;
 	}
 
 	error = device_property_read_string(dev, "firmware-name", &str);
-- 
2.9.3

