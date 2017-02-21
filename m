From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/3] Input: silead - Add OF device ID table
Date: Tue, 21 Feb 2017 15:12:52 -0300
Message-ID: <20170221181254.14748-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/touchscreen/silead.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 404830a4a366..aae3ba1c3e02 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -580,12 +580,26 @@ static const struct acpi_device_id silead_ts_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id silead_ts_of_match[] = {
+	{ .compatible = "silead,gsl1680" },
+	{ .compatible = "silead,gsl1688" },
+	{ .compatible = "silead,gsl3670" },
+	{ .compatible = "silead,gsl3675" },
+	{ .compatible = "silead,gsl3692" },
+	{ .compatible = "silead,mssl1680" },
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
