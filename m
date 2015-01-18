From: Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/3] input: goodix: Add device tree support
Date: Sun, 18 Jan 2015 17:04:30 +0300
Message-ID: <1421589870-14232-1-git-send-email-mamlinav@gmail.com>
References: <1421589740-12132-1-git-send-email-mamlinav@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421589740-12132-1-git-send-email-mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/touchscreen/Kconfig  |  2 +-
 drivers/input/touchscreen/goodix.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 5891752..c4a79b7 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -297,7 +297,7 @@ config TOUCHSCREEN_FUJITSU
 
 config TOUCHSCREEN_GOODIX
 	tristate "Goodix I2C touchscreen"
-	depends on I2C && ACPI
+	depends on I2C && (ACPI || OF)
 	help
 	  Say Y here if you have the Goodix touchscreen (such as one
 	  installed in Onda v975w tablets) connected to your
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index ca19668..603d2ae 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -23,6 +23,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <asm/unaligned.h>
 
 struct goodix_ts_data {
@@ -378,6 +379,14 @@ static const struct acpi_device_id goodix_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 
+#ifdef CONFIG_OF
+static struct of_device_id goodix_of_match[] = {
+	{ .compatible = "goodix,gt9xx" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, goodix_of_match);
+#endif
+
 static struct i2c_driver goodix_ts_driver = {
 	.probe = goodix_ts_probe,
 	.id_table = goodix_ts_id,
@@ -385,6 +394,7 @@ static struct i2c_driver goodix_ts_driver = {
 		.name = "Goodix-TS",
 		.owner = THIS_MODULE,
 		.acpi_match_table = goodix_acpi_match,
+		.of_match_table = of_match_ptr(goodix_of_match),
 	},
 };
 module_i2c_driver(goodix_ts_driver);
-- 
2.0.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
