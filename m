From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: [PATCH] sh: maple: Robust checking for errors on maple keyboard
 initialisation
Date: Sat, 20 Dec 2008 18:25:27 +0000
Message-ID: <1229797527.6502.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: lkmL <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Matt Fleming <matt@console-pimps.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-input@vger.kernel.org

As was pointed out in response to http://lkml.org/lkml/2008/12/19/373
maple drivers were not properly checking for NULL pointers.

This patch fixes this for the keyboard driver already in mainline.

Robust checking for errors on maple keyboard initialisation

Reported-by: Matt Fleming <matt@console-pimps.org>
Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index 22f17a5..9133af8 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -159,22 +159,41 @@ static void dc_kbd_callback(struct mapleq *mq)
 
 static int probe_maple_kbd(struct device *dev)
 {
-	struct maple_device *mdev = to_maple_dev(dev);
-	struct maple_driver *mdrv = to_maple_driver(dev->driver);
+	struct maple_device *mdev;
+	struct maple_driver *mdrv;
 	int i, error;
 	struct dc_kbd *kbd;
 	struct input_dev *idev;
 
-	if (!(mdev->function & MAPLE_FUNC_KEYBOARD))
-		return -EINVAL;
+	mdev = to_maple_dev(dev);
+	if (!mdev) {
+		error = EINVAL;
+		goto fail;
+	}
+
+	mdrv = to_maple_driver(dev->driver);
+	if (!mdrv) {
+		error = EINVAL;
+		goto fail;
+	}
+
+	if (!(mdev->function & MAPLE_FUNC_KEYBOARD)) {
+		error = EINVAL;
+		goto fail;
+	}
 
 	kbd = kzalloc(sizeof(struct dc_kbd), GFP_KERNEL);
-	idev = input_allocate_device();
-	if (!kbd || !idev) {
-		error = -ENOMEM;
+	if (!kbd) {
+		error = ENOMEM;
 		goto fail;
 	}
 
+	idev = input_allocate_device();
+	if (!idev) {
+		error = ENOMEM;
+		goto fail_idev_alloc;
+	}
+
 	kbd->dev = idev;
 	memcpy(kbd->keycode, dc_kbd_keycode, sizeof(kbd->keycode));
 
@@ -195,7 +214,7 @@ static int probe_maple_kbd(struct device *dev)
 
 	error = input_register_device(idev);
 	if (error)
-		goto fail;
+		goto fail_register;
 
 	/* Maple polling is locked to VBLANK - which may be just 50/s */
 	maple_getcond_callback(mdev, dc_kbd_callback, HZ/50,
@@ -207,11 +226,13 @@ static int probe_maple_kbd(struct device *dev)
 
 	return error;
 
-fail:
+fail_register:
+	maple_set_drvdata(mdev, NULL);
 	input_free_device(idev);
+fail_idev_alloc:
 	kfree(kbd);
-	maple_set_drvdata(mdev, NULL);
-	return error;
+fail:
+	return -error;
 }
 
 static int remove_maple_kbd(struct device *dev)

