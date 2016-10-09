From: Raphael Assenat <raph@raphnet.net>
Subject: [PATCH] Initialize axis values in joydev_open_device()
Date: Sun, 9 Oct 2016 16:12:28 -0400
Message-ID: <20161009201228.GT24360@yggdrasil2.lan.raphnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.perfora.net ([74.208.4.194]:51271 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751066AbcJIUMb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 9 Oct 2016 16:12:31 -0400
Received: from yggdrasil2.lan.raphnet.net ([24.201.146.26]) by
 mrelay.perfora.net (mreueus002) with ESMTPSA (Nemesis) id
 0M10GX-1b160X1m8d-00v6ac for <linux-input@vger.kernel.org>; Sun, 09 Oct 2016
 22:12:30 +0200
Received: from raph by yggdrasil2.lan.raphnet.net with local (Exim 4.72)
        (envelope-from <raph@raphnet.net>)
        id 1btKSS-0006zR-Qp
        for linux-input@vger.kernel.org; Sun, 09 Oct 2016 16:12:28 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Postpone axis initialization to the first open instead of doing it once
in joydev_connect. This is to make sure the generated startup events
are representative of the current joystick state rather than what
it was when joydev_connect() was called, potentially much earlier.

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
