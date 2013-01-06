From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/4] Input: walkera0701 - use proper error codes
Date: Sun, 06 Jan 2013 00:59:41 -0800
Message-ID: <20130106085941.18147.57658.stgit@dtor-d630.eng.vmware.com>
References: <20130106085931.18147.78960.stgit@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:57460 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab3AFI7p (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Jan 2013 03:59:45 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so8187136dad.27
        for <linux-input@vger.kernel.org>; Sun, 06 Jan 2013 00:59:45 -0800 (PST)
In-Reply-To: <20130106085931.18147.78960.stgit@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Popovec <popovec@fei.tuke.sk>
Cc: linux-input@vger.kernel.org

We have been using -EBUSY where we should have used -EIO or -ENOMEM,
so let's fix that and also add some diagnostic messages.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/walkera0701.c |   56 ++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/input/joystick/walkera0701.c b/drivers/input/joystick/walkera0701.c
index da657e6..b86134c 100644
--- a/drivers/input/joystick/walkera0701.c
+++ b/drivers/input/joystick/walkera0701.c
@@ -197,37 +197,51 @@ static void walkera0701_close(struct input_dev *dev)
 
 static int walkera0701_connect(struct walkera_dev *w, int parport)
 {
-	int err = -ENODEV;
+	int error;
 
 	w->parport = parport_find_number(parport);
-	if (w->parport == NULL)
+	if (!w->parport) {
+		pr_err("parport %d does not exist\n", parport);
 		return -ENODEV;
+	}
 
 	if (w->parport->irq == -1) {
 		pr_err("parport %d does not have interrupt assigned\n",
 			parport);
-		goto init_err;
+		error = -EINVAL;
+		goto err_put_parport;
 	}
 
-	err = -EBUSY;
 	w->pardevice = parport_register_device(w->parport, "walkera0701",
 				    NULL, NULL, walkera0701_irq_handler,
 				    PARPORT_DEV_EXCL, w);
-	if (!w->pardevice)
-		goto init_err;
+	if (!w->pardevice) {
+		pr_err("failed to register parport device\n");
+		error = -EIO;
+		goto err_put_parport;
+	}
 
-	if (parport_negotiate(w->pardevice->port, IEEE1284_MODE_COMPAT))
-		goto init_err1;
+	if (parport_negotiate(w->pardevice->port, IEEE1284_MODE_COMPAT)) {
+		pr_err("failed to negotiate parport mode\n");
+		error = -EIO;
+		goto err_unregister_device;
+	}
 
-	if (parport_claim(w->pardevice))
-		goto init_err1;
+	if (parport_claim(w->pardevice)) {
+		pr_err("failed to claim parport\n");
+		error = -EBUSY;
+		goto err_unregister_device;
+	}
 
 	hrtimer_init(&w->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	w->timer.function = timer_handler;
 
 	w->input_dev = input_allocate_device();
-	if (!w->input_dev)
-		goto init_err2;
+	if (!w->input_dev) {
+		pr_err("failed to allocate input device\n");
+		error = -ENOMEM;
+		goto err_release_parport;
+	}
 
 	input_set_drvdata(w->input_dev, w);
 	w->input_dev->name = "Walkera WK-0701 TX";
@@ -252,21 +266,23 @@ static int walkera0701_connect(struct walkera_dev *w, int parport)
 	input_set_abs_params(w->input_dev, ABS_RUDDER, -512, 512, 0, 0);
 	input_set_abs_params(w->input_dev, ABS_MISC, -512, 512, 0, 0);
 
-	err = input_register_device(w->input_dev);
-	if (err)
-		goto init_err3;
+	error = input_register_device(w->input_dev);
+	if (error) {
+		pr_err("failed to register input device\n");
+		goto err_free_input_dev;
+	}
 
 	return 0;
 
- init_err3:
+err_free_input_dev:
 	input_free_device(w->input_dev);
- init_err2:
+err_release_parport:
 	parport_release(w->pardevice);
- init_err1:
+err_unregister_device:
 	parport_unregister_device(w->pardevice);
- init_err:
+err_put_parport:
 	parport_put_port(w->parport);
-	return err;
+	return error;
 }
 
 static void walkera0701_disconnect(struct walkera_dev *w)

