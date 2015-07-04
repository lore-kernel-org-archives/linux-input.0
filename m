From: Roman Volkov <rvolkov@v1ros.org>
Subject: [PATCH v4 3/4] i8042: Add OF/FDT support to the driver
Date: Sat,  4 Jul 2015 20:35:43 +0300
Message-ID: <1436031344-15455-4-git-send-email-rvolkov@v1ros.org>
References: <342234234esdfewrewrwer@dkoi.org>
 <1436031344-15455-1-git-send-email-rvolkov@v1ros.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v1ros.org ([109.234.34.72]:53243 "EHLO smtp.v1ros.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755396AbbGEJAr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 5 Jul 2015 05:00:47 -0400
In-Reply-To: <1436031344-15455-1-git-send-email-rvolkov@v1ros.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>, Roman Volkov <rvolkov@v1ros.org>

Original driver should be modified to support OF/FDT bindings. The
platform_create_bundle() function should be removed when compiled for
OF-capable machines, since the device tree is already created by the
platform code. The driver should also contain the OF match table and
call platform-specific probe/remove functions.

Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
---
 drivers/input/serio/i8042.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index cb5ece7..ec58af1 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1442,8 +1442,27 @@ static int __init i8042_probe(struct platform_device *dev)
 {
 	int error;
 
-	i8042_platform_device = dev;
+	if (i8042_platform_device) {
+		printk("%s: multiple controllers found, ignoring '%s'\n",
+			__func__, dev->name);
+		return 0;
+	}
+#ifdef SERIO_I8042_OF
+	if (!dev->dev.of_node) {
+		printk("%s: non-OF device found, ignoring '%s'\n",
+			__func__, dev->name);
+		return 0;
+	}
 
+	error = i8042_platform_probe(dev);
+	if (error)
+		return error;
+#endif
+	error = i8042_controller_check();
+	if (error)
+		return error;
+
+	i8042_platform_device = dev;
 	if (i8042_reset) {
 		error = i8042_controller_selftest();
 		if (error)
@@ -1488,9 +1507,17 @@ static int __init i8042_probe(struct platform_device *dev)
 
 static int i8042_remove(struct platform_device *dev)
 {
+	if (dev != i8042_platform_device) {
+		dbg("%s: ignoring device %s\n", __func__, dev->name);
+		return 0;
+	}
+
 	i8042_unregister_ports();
 	i8042_free_irqs();
 	i8042_controller_reset(false);
+#ifdef SERIO_I8042_OF
+	i8042_platform_remove(dev);
+#endif
 	i8042_platform_device = NULL;
 
 	return 0;
@@ -1502,6 +1529,9 @@ static struct platform_driver i8042_driver = {
 #ifdef CONFIG_PM
 		.pm	= &i8042_pm_ops,
 #endif
+#ifdef SERIO_I8042_OF
+		.of_match_table = i8042_of_match,
+#endif
 	},
 	.remove		= i8042_remove,
 	.shutdown	= i8042_shutdown,
@@ -1514,15 +1544,16 @@ static int __init i8042_init(void)
 
 	dbg_init();
 
+	i8042_platform_device = NULL;
 	err = i8042_platform_init();
 	if (err)
 		return err;
 
-	err = i8042_controller_check();
-	if (err)
-		goto err_platform_exit;
-
+#ifdef SERIO_I8042_OF
+	pdev = ERR_PTR(platform_driver_probe(&i8042_driver, i8042_probe));
+#else
 	pdev = platform_create_bundle(&i8042_driver, i8042_probe, NULL, 0, NULL, 0);
+#endif
 	if (IS_ERR(pdev)) {
 		err = PTR_ERR(pdev);
 		goto err_platform_exit;
@@ -1539,7 +1570,9 @@ static int __init i8042_init(void)
 
 static void __exit i8042_exit(void)
 {
+#ifndef SERIO_I8042_OF
 	platform_device_unregister(i8042_platform_device);
+#endif
 	platform_driver_unregister(&i8042_driver);
 	i8042_platform_exit();
 
-- 
2.4.2

