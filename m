From: Aleksei Mamlin <mamlinav@gmail.com>
Subject: [PATCH 1/2] input: goodix: Add device tree support
Date: Wed,  4 Mar 2015 11:33:48 +0300
Message-ID: <1425458028-4521-1-git-send-email-mamlinav@gmail.com>
References: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:38661 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760425AbbCDIem (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 03:34:42 -0500
In-Reply-To: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Hans de Goede <hdegoede@redhat.com>, Aleksei Mamlin <mamlinav@gmail.com>

This patch adds device tree support for Goodix GT9xx series touchscreen
controller.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 .../bindings/input/touchscreen/goodix.txt          | 27 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/input/touchscreen/Kconfig                  |  2 +-
 drivers/input/touchscreen/goodix.c                 | 19 ++++++++++++++-
 4 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/goodix.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
new file mode 100644
index 0000000..cbaf085
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -0,0 +1,27 @@
+Device tree bindings for Goodix GT9xx series touchscreen controller
+
+Required properties:
+
+ - compatible		: Should be "goodix,gt9110"
+				 or "goodix,gt927"
+				 or "goodix,gt9271"
+				 or "goodix,gt928"
+				 or "goodix,gt967"
+ - reg			: I2C address of the chip
+ - interrupt-parent 	: Interrupt controller to which the chip is connected
+ - interrupts		: Interrupt to which the chip is connected
+
+Example:
+
+	i2c@00000000 {
+		/* ... */
+
+		gt928@5d {
+			compatible = "goodix,gt928";
+			reg = <0x5d>;
+			interrupt-parent = <&gpio>;
+			interrupts = <0 0>;
+		};
+
+		/* ... */
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389ca13..e9f70d8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -76,6 +76,7 @@ geniatech	Geniatech, Inc.
 giantplus	Giantplus Technology Co., Ltd.
 globalscale	Globalscale Technologies, Inc.
 gmt	Global Mixed-mode Technology, Inc.
+goodix	Shenzhen Huiding Technology Co. Ltd.
 google	Google, Inc.
 gumstix	Gumstix, Inc.
 gw	Gateworks Corporation
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 5891752..7a6ab8c 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -297,7 +297,7 @@ config TOUCHSCREEN_FUJITSU
 
 config TOUCHSCREEN_GOODIX
 	tristate "Goodix I2C touchscreen"
-	depends on I2C && ACPI
+	depends on I2C
 	help
 	  Say Y here if you have the Goodix touchscreen (such as one
 	  installed in Onda v975w tablets) connected to your
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index ca19668..16f016a 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -23,6 +23,8 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/acpi.h>
+#include <linux/of.h>
 #include <asm/unaligned.h>
 
 struct goodix_ts_data {
@@ -372,11 +374,25 @@ static const struct i2c_device_id goodix_ts_id[] = {
 	{ }
 };
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id goodix_acpi_match[] = {
 	{ "GDIX1001", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
+#endif
+
+#ifdef CONFIG_OF
+static struct of_device_id goodix_of_match[] = {
+	{ .compatible = "goodix,gt9110" },
+	{ .compatible = "goodix,gt927" },
+	{ .compatible = "goodix,gt9271" },
+	{ .compatible = "goodix,gt928" },
+	{ .compatible = "goodix,gt967" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, goodix_of_match);
+#endif
 
 static struct i2c_driver goodix_ts_driver = {
 	.probe = goodix_ts_probe,
@@ -384,7 +400,8 @@ static struct i2c_driver goodix_ts_driver = {
 	.driver = {
 		.name = "Goodix-TS",
 		.owner = THIS_MODULE,
-		.acpi_match_table = goodix_acpi_match,
+		.acpi_match_table = ACPI_PTR(goodix_acpi_match),
+		.of_match_table = of_match_ptr(goodix_of_match),
 	},
 };
 module_i2c_driver(goodix_ts_driver);
-- 
2.0.5

