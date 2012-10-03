From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/4] Input: mousedev - factor out psaux code to reduce #ifdefery
Date: Wed,  3 Oct 2012 14:02:59 -0700
Message-ID: <1349298182-22452-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:42088 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab2JCVDH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Oct 2012 17:03:07 -0400
Received: by dakn41 with SMTP id n41so1393557dak.19
        for <linux-input@vger.kernel.org>; Wed, 03 Oct 2012 14:03:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

This is the previously posted dynamic input devices patch with changes
that has nothing to do with dynamic minors split into separate patches
for easier reviewing. We also now preserving format of /proc/bus/input/handlers
to ensure userspace ABI.

 drivers/input/mousedev.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 964e43d..8d3942f 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -25,9 +25,6 @@
 #include <linux/major.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
-#include <linux/miscdevice.h>
-#endif
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Mouse (ExplorerPS/2) device interfaces");
@@ -1064,10 +1061,36 @@ static struct input_handler mousedev_handler = {
 };
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
+#include <linux/miscdevice.h>
+
 static struct miscdevice psaux_mouse = {
-	PSMOUSE_MINOR, "psaux", &mousedev_fops
+	.minor	= PSMOUSE_MINOR,
+	.name	= "psaux",
+	.fops	= &mousedev_fops,
 };
-static int psaux_registered;
+
+static bool psaux_registered;
+
+static void __init mousedev_psaux_register(void)
+{
+	int error;
+
+	error = misc_register(&psaux_mouse);
+	if (error)
+		pr_warn("could not register psaux device, error: %d\n",
+			   error);
+	else
+		psaux_registered = true;
+}
+
+static void __exit mousedev_psaux_unregister(void)
+{
+	if (psaux_registered)
+		misc_deregister(&psaux_mouse);
+}
+#else
+static inline void mousedev_psaux_register(void) { }
+static inline void mousedev_psaux_unregister(void) { }
 #endif
 
 static int __init mousedev_init(void)
@@ -1084,14 +1107,7 @@ static int __init mousedev_init(void)
 		return error;
 	}
 
-#ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
-	error = misc_register(&psaux_mouse);
-	if (error)
-		pr_warn("could not register psaux device, error: %d\n",
-			   error);
-	else
-		psaux_registered = 1;
-#endif
+	mousedev_psaux_register();
 
 	pr_info("PS/2 mouse device common for all mice\n");
 
@@ -1100,10 +1116,7 @@ static int __init mousedev_init(void)
 
 static void __exit mousedev_exit(void)
 {
-#ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
-	if (psaux_registered)
-		misc_deregister(&psaux_mouse);
-#endif
+	mousedev_psaux_unregister();
 	input_unregister_handler(&mousedev_handler);
 	mousedev_destroy(mousedev_mix);
 }
-- 
1.7.11.4

