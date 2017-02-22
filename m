From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH v2 1/3] Input: silead - Add OF device ID table
Date: Wed, 22 Feb 2017 11:40:03 -0300
Message-ID: <20170222144005.23447-1-javier@osg.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:44674
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932899AbdBVOkT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Feb 2017 09:40:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

As pointed by Hans de Goede, there's no mssl1680 and this is just used in
some ACPI systems to identify the gsl1680 chip. So isn't included in the
OF device ID table since a DT should use the proper device name instead.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes in v2:
- Remove the mssl1680 entry from the OF device ID table (Hans de Goede).

 drivers/input/touchscreen/silead.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 404830a4a366..813dd68a5c82 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -580,12 +580,25 @@ static const struct acpi_device_id silead_ts_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id silead_ts_of_match[] = {
+	{ .compatible = "silead,gsl1680" },
+	{ .compatible = "silead,gsl1688" },
+	{ .compatible = "silead,gsl3670" },
+	{ .compatible = "silead,gsl3675" },
+	{ .compatible = "silead,gsl3692" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, silead_ts_of_match);
+#endif
+
 static struct i2c_driver silead_ts_driver = {
 	.probe = silead_ts_probe,
 	.id_table = silead_ts_id,
 	.driver = {
 		.name = SILEAD_TS_NAME,
 		.acpi_match_table = ACPI_PTR(silead_ts_acpi_match),
+		.of_match_table = of_match_ptr(silead_ts_of_match),
 		.pm = &silead_ts_pm,
 	},
 };
-- 
2.9.3

