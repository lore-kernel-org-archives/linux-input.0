From: Himangi Saraogi <himangi774@gmail.com>
Subject: [PATCH] input: jornada680_kbd: Allocate resources using managed
 interfaces
Date: Sat, 24 May 2014 17:47:09 +0530
Message-ID: <20140524121709.GA6504@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:48661 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbaEXMRV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 May 2014 08:17:21 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr

This patch moves most data allocated in the probe function from
unmanaged interfaces to managed interfaces. The kfrees and error
handling code is done away with. Also, the unnecesary labels are
removed and the function mrstouch_remove is removed as it becomes
empty after removing the no longer required function calls. Also,
linux/device.h is added to make sure the devm_*() routine declarations
are unambiguously available.

The following Coccinelle semantic patch was used for making a part of
the change:

@platform@
identifier p, probefn, removefn;
@@
struct platform_driver p = {
  .probe = probefn,
  .remove = removefn,
};

@prb@
identifier platform.probefn, pdev;
expression e, e1, e2;
@@
probefn(struct platform_device *pdev, ...) {
  <+...
- e = kzalloc(e1, e2)
+ e = devm_kzalloc(&pdev->dev, e1, e2)
  ...
?-kfree(e);
  ...+>
}

@rem depends on prb@
identifier platform.removefn;
expression e;
@@
removefn(...) {
  <...
- kfree(e);
  ...>
}

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
---
Not compile tested due to incompatible architecture.

 drivers/input/keyboard/jornada680_kbd.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/input/keyboard/jornada680_kbd.c b/drivers/input/keyboard/jornada680_kbd.c
index 69b1f00..806dc6b 100644
--- a/drivers/input/keyboard/jornada680_kbd.c
+++ b/drivers/input/keyboard/jornada680_kbd.c
@@ -16,6 +16,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/device.h>
 #include <linux/input.h>
 #include <linux/input-polldev.h>
 #include <linux/interrupt.h>
@@ -185,11 +186,12 @@ static int jornada680kbd_probe(struct platform_device *pdev)
 	struct input_dev *input_dev;
 	int i, error;
 
-	jornadakbd = kzalloc(sizeof(struct jornadakbd), GFP_KERNEL);
+	jornadakbd = devm_kzalloc(&pdev->dev, sizeof(struct jornadakbd),
+				  GFP_KERNEL);
 	if (!jornadakbd)
 		return -ENOMEM;
 
-	poll_dev = input_allocate_polled_device();
+	poll_dev = devm_input_allocate_polled_device(&pdev->dev);
 	if (!poll_dev) {
 		error = -ENOMEM;
 		goto failed;
@@ -232,21 +234,7 @@ static int jornada680kbd_probe(struct platform_device *pdev)
  failed:
 	printk(KERN_ERR "Jornadakbd: failed to register driver, error: %d\n",
 		error);
-	input_free_polled_device(poll_dev);
-	kfree(jornadakbd);
 	return error;
-
-}
-
-static int jornada680kbd_remove(struct platform_device *pdev)
-{
-	struct jornadakbd *jornadakbd = platform_get_drvdata(pdev);
-
-	input_unregister_polled_device(jornadakbd->poll_dev);
-	input_free_polled_device(jornadakbd->poll_dev);
-	kfree(jornadakbd);
-
-	return 0;
 }
 
 static struct platform_driver jornada680kbd_driver = {
@@ -255,7 +243,6 @@ static struct platform_driver jornada680kbd_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= jornada680kbd_probe,
-	.remove	= jornada680kbd_remove,
 };
 module_platform_driver(jornada680kbd_driver);
 
-- 
1.9.1

