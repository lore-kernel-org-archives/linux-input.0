From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/4] Input: walkera0701 - claim parport when opening the
 device
Date: Sun, 06 Jan 2013 00:59:47 -0800
Message-ID: <20130106085947.18147.4193.stgit@dtor-d630.eng.vmware.com>
References: <20130106085931.18147.78960.stgit@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:62820 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab3AFI7u (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Jan 2013 03:59:50 -0500
Received: by mail-pb0-f54.google.com with SMTP id wz12so9993492pbc.27
        for <linux-input@vger.kernel.org>; Sun, 06 Jan 2013 00:59:50 -0800 (PST)
In-Reply-To: <20130106085931.18147.78960.stgit@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Popovec <popovec@fei.tuke.sk>
Cc: linux-input@vger.kernel.org

Postpone claiming the port until the device is opened, instead of doing
that when the driver is loaded.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/walkera0701.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/input/joystick/walkera0701.c b/drivers/input/joystick/walkera0701.c
index b86134c..b76ac58 100644
--- a/drivers/input/joystick/walkera0701.c
+++ b/drivers/input/joystick/walkera0701.c
@@ -183,6 +183,9 @@ static int walkera0701_open(struct input_dev *dev)
 {
 	struct walkera_dev *w = input_get_drvdata(dev);
 
+	if (parport_claim(w->pardevice))
+		return -EBUSY;
+
 	parport_enable_irq(w->parport);
 	return 0;
 }
@@ -193,6 +196,8 @@ static void walkera0701_close(struct input_dev *dev)
 
 	parport_disable_irq(w->parport);
 	hrtimer_cancel(&w->timer);
+
+	parport_release(w->pardevice);
 }
 
 static int walkera0701_connect(struct walkera_dev *w, int parport)
@@ -227,12 +232,6 @@ static int walkera0701_connect(struct walkera_dev *w, int parport)
 		goto err_unregister_device;
 	}
 
-	if (parport_claim(w->pardevice)) {
-		pr_err("failed to claim parport\n");
-		error = -EBUSY;
-		goto err_unregister_device;
-	}
-
 	hrtimer_init(&w->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	w->timer.function = timer_handler;
 
@@ -240,7 +239,7 @@ static int walkera0701_connect(struct walkera_dev *w, int parport)
 	if (!w->input_dev) {
 		pr_err("failed to allocate input device\n");
 		error = -ENOMEM;
-		goto err_release_parport;
+		goto err_unregister_device;
 	}
 
 	input_set_drvdata(w->input_dev, w);
@@ -276,8 +275,6 @@ static int walkera0701_connect(struct walkera_dev *w, int parport)
 
 err_free_input_dev:
 	input_free_device(w->input_dev);
-err_release_parport:
-	parport_release(w->pardevice);
 err_unregister_device:
 	parport_unregister_device(w->pardevice);
 err_put_parport:
@@ -288,7 +285,6 @@ err_put_parport:
 static void walkera0701_disconnect(struct walkera_dev *w)
 {
 	input_unregister_device(w->input_dev);
-	parport_release(w->pardevice);
 	parport_unregister_device(w->pardevice);
 	parport_put_port(w->parport);
 }

