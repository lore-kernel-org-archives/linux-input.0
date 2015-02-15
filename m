From: Roman Volkov <v1ron@v1ros.org>
Subject: [PATCH v3 4/5] i8042: Prepare i8042 driver for DT support
Date: Mon, 16 Feb 2015 00:11:46 +0300
Message-ID: <1424034707-15723-5-git-send-email-v1ron@v1ros.org>
References: <1423857173-16432-6-git-send-email-v1ron@v1ros.org>
 <1424034707-15723-1-git-send-email-v1ron@v1ros.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424034707-15723-1-git-send-email-v1ron@v1ros.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roman Volkov <v1ron@v1ros.org>
List-Id: linux-input@vger.kernel.org

Move i8042_platform_init() call from i8042_init() to i8042_probe() to
pass the platform_device structure pointer, since the former function
now requires this argument.

Use platform_create_bundle() when there is no DT support in the kernel,
and platform_driver_probe() otherwise, which does not create a device.

Signed-off-by: Roman Volkov <v1ron@v1ros.org>
---
 drivers/input/serio/i8042.c | 46 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 2f09062..96b62fd 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1422,6 +1422,18 @@ static int __init i8042_probe(struct platform_device *dev)
 
 	i8042_platform_device = dev;
 
+#ifdef SERIO_I8042_DT
+	error = i8042_platform_init(dev);
+#else
+	error = i8042_platform_init();
+#endif
+	if (error)
+		return error;
+
+	error = i8042_controller_check();
+	if (error)
+		goto out_platform_exit;
+
 	if (i8042_reset) {
 		error = i8042_controller_selftest();
 		if (error)
@@ -1440,13 +1452,13 @@ static int __init i8042_probe(struct platform_device *dev)
 	if (!i8042_noaux) {
 		error = i8042_setup_aux();
 		if (error && error != -ENODEV && error != -EBUSY)
-			goto out_fail;
+			goto out_res_free;
 	}
 
 	if (!i8042_nokbd) {
 		error = i8042_setup_kbd();
 		if (error)
-			goto out_fail;
+			goto out_res_free;
 	}
 /*
  * Ok, everything is ready, let's register all serio ports
@@ -1455,11 +1467,13 @@ static int __init i8042_probe(struct platform_device *dev)
 
 	return 0;
 
- out_fail:
+ out_res_free:
 	i8042_free_aux_ports();	/* in case KBD failed but AUX not */
 	i8042_free_irqs();
 	i8042_controller_reset(false);
 	i8042_platform_device = NULL;
+ out_platform_exit:
+	i8042_platform_exit();
 
 	return error;
 }
@@ -1498,36 +1512,26 @@ static struct platform_driver i8042_driver = {
 static int __init i8042_init(void)
 {
 	struct platform_device *pdev;
-	int err;
 
 	dbg_init();
-
-	err = i8042_platform_init();
-	if (err)
-		return err;
-
-	err = i8042_controller_check();
-	if (err)
-		goto err_platform_exit;
-
+#ifdef SERIO_I8042_DT
+	pdev = ERR_PTR(platform_driver_probe(&i8042_driver, i8042_probe));
+#else
 	pdev = platform_create_bundle(&i8042_driver, i8042_probe, NULL, 0, NULL, 0);
-	if (IS_ERR(pdev)) {
-		err = PTR_ERR(pdev);
-		goto err_platform_exit;
-	}
+#endif
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
 
 	panic_blink = i8042_panic_blink;
 
 	return 0;
-
- err_platform_exit:
-	i8042_platform_exit();
-	return err;
 }
 
 static void __exit i8042_exit(void)
 {
+#ifndef SERIO_I8042_DT
 	platform_device_unregister(i8042_platform_device);
+#endif
 	platform_driver_unregister(&i8042_driver);
 	i8042_platform_exit();
 
-- 
2.3.0
