From: Raphael Assenat <raph@raphnet.net>
Subject: [PATCH RESEND] Initialize axis values in joydev_open_device()
Date: Sun, 18 Dec 2016 15:20:50 -0500
Message-ID: <20161218202050.GX10002@yggdrasil2.lan.raphnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.perfora.net ([74.208.4.194]:60709 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753150AbcLRUZ5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Dec 2016 15:25:57 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Postpone axis initialization to the first open instead of doing it once
in joydev_connect. This is to make sure the generated startup events
are representative of the current joystick state rather than what
it was when joydev_connect() was called, potentially much earlier.

This solves issues with joystick driven menus that start scrolling
up each time they are started, until the user moves the joystick to
generate events. In emulator menu setups where the menu program is
restarted every time the game exits, the repeated need to move the
joystick to stop the unintended scrolling gets old rather quickly...

Unless I misunderstood the intent of JS_EVENT_INIT, I think the startup
events should reflect the current state of the joystick. Please consider
applying if it makes sense.

Signed-off-by: Raphael Assenat <raph@raphnet.net>

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 5d11fea..5b42e5a 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -156,6 +156,38 @@ static void joydev_event(struct input_handle *handle,
 	wake_up_interruptible(&joydev->wait);
 }
 
+static void joydev_refresh_state(struct joydev *joydev)
+{
+	struct input_dev *dev = joydev->handle.dev;
+	int i, j, t;
+
+	for (i = 0; i < joydev->nabs; i++) {
+		j = joydev->abspam[i];
+		if (input_abs_get_max(dev, j) == input_abs_get_min(dev, j)) {
+			joydev->corr[i].type = JS_CORR_NONE;
+			joydev->abs[i] = input_abs_get_val(dev, j);
+			continue;
+		}
+		joydev->corr[i].type = JS_CORR_BROKEN;
+		joydev->corr[i].prec = input_abs_get_fuzz(dev, j);
+
+		t = (input_abs_get_max(dev, j) + input_abs_get_min(dev, j)) / 2;
+		joydev->corr[i].coef[0] = t - input_abs_get_flat(dev, j);
+		joydev->corr[i].coef[1] = t + input_abs_get_flat(dev, j);
+
+		t = (input_abs_get_max(dev, j) - input_abs_get_min(dev, j)) / 2
+			- 2 * input_abs_get_flat(dev, j);
+		if (t) {
+			joydev->corr[i].coef[2] = (1 << 29) / t;
+			joydev->corr[i].coef[3] = (1 << 29) / t;
+
+			joydev->abs[i] =
+				joydev_correct(input_abs_get_val(dev, j),
+					       joydev->corr + i);
+		}
+	}
+}
+
 static int joydev_fasync(int fd, struct file *file, int on)
 {
 	struct joydev_client *client = file->private_data;
@@ -202,6 +234,8 @@ static int joydev_open_device(struct joydev *joydev)
 		retval = input_open_device(&joydev->handle);
 		if (retval)
 			joydev->open--;
+		else
+			joydev_refresh_state(joydev);
 	}
 
 	mutex_unlock(&joydev->mutex);
@@ -816,7 +850,7 @@ static int joydev_connect(struct input_handler *handler, struct input_dev *dev,
 			  const struct input_device_id *id)
 {
 	struct joydev *joydev;
-	int i, j, t, minor, dev_no;
+	int i, minor, dev_no;
 	int error;
 
 	minor = input_get_new_minor(JOYDEV_MINOR_BASE, JOYDEV_MINORS, true);
@@ -869,31 +903,7 @@ static int joydev_connect(struct input_handler *handler, struct input_dev *dev,
 			joydev->nkey++;
 		}
 
-	for (i = 0; i < joydev->nabs; i++) {
-		j = joydev->abspam[i];
-		if (input_abs_get_max(dev, j) == input_abs_get_min(dev, j)) {
-			joydev->corr[i].type = JS_CORR_NONE;
-			joydev->abs[i] = input_abs_get_val(dev, j);
-			continue;
-		}
-		joydev->corr[i].type = JS_CORR_BROKEN;
-		joydev->corr[i].prec = input_abs_get_fuzz(dev, j);
-
-		t = (input_abs_get_max(dev, j) + input_abs_get_min(dev, j)) / 2;
-		joydev->corr[i].coef[0] = t - input_abs_get_flat(dev, j);
-		joydev->corr[i].coef[1] = t + input_abs_get_flat(dev, j);
-
-		t = (input_abs_get_max(dev, j) - input_abs_get_min(dev, j)) / 2
-			- 2 * input_abs_get_flat(dev, j);
-		if (t) {
-			joydev->corr[i].coef[2] = (1 << 29) / t;
-			joydev->corr[i].coef[3] = (1 << 29) / t;
-
-			joydev->abs[i] =
-				joydev_correct(input_abs_get_val(dev, j),
-					       joydev->corr + i);
-		}
-	}
+	joydev_refresh_state(joydev);
 
 	joydev->dev.devt = MKDEV(INPUT_MAJOR, minor);
 	joydev->dev.class = &input_class;
