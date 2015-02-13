From: Roman Volkov <v1ron@v1ros.org>
Subject: [PATCH v2 4/5] i8042: Prepare i8042 driver for DT support
Date: Fri, 13 Feb 2015 22:52:52 +0300
Message-ID: <1423857173-16432-5-git-send-email-v1ron@v1ros.org>
References: <20150203011051.11999a16@v1ron-s7>
 <1423857173-16432-1-git-send-email-v1ron@v1ros.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423857173-16432-1-git-send-email-v1ron@v1ros.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roman Volkov <v1ron@v1ros.org>, Tony Prisk <linux@prisktech.co.nz>
List-Id: linux-input@vger.kernel.org

Use platform_device_probe() instead of platform_create_bundle() when
compiled with DT support, since the latter function is not suitable for
handling the OF device tree.

The order of initialization is changed, since i8042_platform_init() for DT
requires initialized platform_device structure. To avoid searching of the
compatible node twice, the platform_device structure pointer must be passed
to the i8042_platform_init() function right after initialization by
platform_device_probe().

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
Signed-off-by: Roman Volkov <v1ron@v1ros.org>
---
This is remaining weak place in the patch set. No ideas yet on
how to reduce the using of ifdefs to make code cleaner, need more discussion.

 drivers/input/serio/i8042.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 2f09062..86a47ec 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1421,16 +1421,32 @@ static int __init i8042_probe(struct platform_device *dev)
 	int error;
 
 	i8042_platform_device = dev;
+#ifdef SERIO_I8042_DT
+	error = i8042_platform_init(dev);
+	if (error)
+		return error;
 
+	error = i8042_controller_check();
+	if (error)
+		goto out_platform_exit;
+#endif
 	if (i8042_reset) {
 		error = i8042_controller_selftest();
 		if (error)
+#ifdef SERIO_I8042_DT
+			goto out_platform_exit;
+#else
 			return error;
+#endif
 	}
 
 	error = i8042_controller_init();
 	if (error)
+#ifdef SERIO_I8042_DT
+		goto out_platform_exit;
+#else
 		return error;
+#endif
 
 #ifdef CONFIG_X86
 	if (i8042_dritek)
@@ -1460,7 +1476,10 @@ static int __init i8042_probe(struct platform_device *dev)
 	i8042_free_irqs();
 	i8042_controller_reset(false);
 	i8042_platform_device = NULL;
-
+#ifdef SERIO_I8042_DT
+ out_platform_exit:
+	i8042_platform_exit();
+#endif
 	return error;
 }
 
@@ -1497,11 +1516,18 @@ static struct platform_driver i8042_driver = {
 
 static int __init i8042_init(void)
 {
+#ifndef SERIO_I8042_DT
 	struct platform_device *pdev;
+#endif
 	int err;
 
 	dbg_init();
 
+#ifdef SERIO_I8042_DT
+	err = platform_driver_probe(&i8042_driver, i8042_probe);
+	if (err)
+		return err;
+#else
 	err = i8042_platform_init();
 	if (err)
 		return err;
@@ -1515,14 +1541,15 @@ static int __init i8042_init(void)
 		err = PTR_ERR(pdev);
 		goto err_platform_exit;
 	}
-
+#endif
 	panic_blink = i8042_panic_blink;
 
 	return 0;
-
+#ifndef SERIO_I8042_DT
  err_platform_exit:
 	i8042_platform_exit();
 	return err;
+#endif
 }
 
 static void __exit i8042_exit(void)
-- 
2.3.0
