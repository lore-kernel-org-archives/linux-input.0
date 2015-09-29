From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4/4] Input: walkera0701 - use parallel port device model
Date: Tue, 29 Sep 2015 22:06:34 +0530
Message-ID: <1443544594-5800-5-git-send-email-sudipm.mukherjee@gmail.com>
References: <1443544594-5800-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33674 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935105AbbI2Qg5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 12:36:57 -0400
In-Reply-To: <1443544594-5800-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Modify walkera0701 driver to use the new Parallel Port device model.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/joystick/walkera0701.c | 64 +++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/input/joystick/walkera0701.c b/drivers/input/joystick/walkera0701.c
index b76ac58..9c07fe9 100644
--- a/drivers/input/joystick/walkera0701.c
+++ b/drivers/input/joystick/walkera0701.c
@@ -200,35 +200,38 @@ static void walkera0701_close(struct input_dev *dev)
 	parport_release(w->pardevice);
 }
 
-static int walkera0701_connect(struct walkera_dev *w, int parport)
+static void walkera0701_attach(struct parport *pp)
 {
-	int error;
+	struct pardev_cb walkera0701_parport_cb;
+	struct walkera_dev *w = &w_dev;
 
-	w->parport = parport_find_number(parport);
-	if (!w->parport) {
-		pr_err("parport %d does not exist\n", parport);
-		return -ENODEV;
+	if (pp->number != walkera0701_pp_no) {
+		pr_debug("Not using parport%d.\n", pp->number);
+		return;
 	}
 
-	if (w->parport->irq == -1) {
+	if (pp->irq == -1) {
 		pr_err("parport %d does not have interrupt assigned\n",
-			parport);
-		error = -EINVAL;
-		goto err_put_parport;
+			pp->number);
+		return;
 	}
 
-	w->pardevice = parport_register_device(w->parport, "walkera0701",
-				    NULL, NULL, walkera0701_irq_handler,
-				    PARPORT_DEV_EXCL, w);
+	w->parport = pp;
+
+	walkera0701_parport_cb.flags = PARPORT_FLAG_EXCL;
+	walkera0701_parport_cb.irq_func = walkera0701_irq_handler;
+	walkera0701_parport_cb.private = w;
+
+	w->pardevice = parport_register_dev_model(pp, "walkera0701",
+						  &walkera0701_parport_cb, 0);
+
 	if (!w->pardevice) {
 		pr_err("failed to register parport device\n");
-		error = -EIO;
-		goto err_put_parport;
+		return;
 	}
 
 	if (parport_negotiate(w->pardevice->port, IEEE1284_MODE_COMPAT)) {
 		pr_err("failed to negotiate parport mode\n");
-		error = -EIO;
 		goto err_unregister_device;
 	}
 
@@ -238,7 +241,6 @@ static int walkera0701_connect(struct walkera_dev *w, int parport)
 	w->input_dev = input_allocate_device();
 	if (!w->input_dev) {
 		pr_err("failed to allocate input device\n");
-		error = -ENOMEM;
 		goto err_unregister_device;
 	}
 
@@ -265,38 +267,46 @@ static int walkera0701_connect(struct walkera_dev *w, int parport)
 	input_set_abs_params(w->input_dev, ABS_RUDDER, -512, 512, 0, 0);
 	input_set_abs_params(w->input_dev, ABS_MISC, -512, 512, 0, 0);
 
-	error = input_register_device(w->input_dev);
-	if (error) {
+	if (input_register_device(w->input_dev)) {
 		pr_err("failed to register input device\n");
 		goto err_free_input_dev;
 	}
 
-	return 0;
+	return;
 
 err_free_input_dev:
 	input_free_device(w->input_dev);
 err_unregister_device:
 	parport_unregister_device(w->pardevice);
-err_put_parport:
-	parport_put_port(w->parport);
-	return error;
 }
 
-static void walkera0701_disconnect(struct walkera_dev *w)
+static void walkera0701_detach(struct parport *port)
 {
+	struct walkera_dev *w = &w_dev;
+
+	if (!w->pardevice || w->parport->number != port->number)
+		return;
+
 	input_unregister_device(w->input_dev);
 	parport_unregister_device(w->pardevice);
-	parport_put_port(w->parport);
+	w->parport = NULL;
 }
 
+static struct parport_driver walkera0701_parport_driver = {
+	.name = "walkera0701",
+	.match_port = walkera0701_attach,
+	.detach = walkera0701_detach,
+	.devmodel = true,
+};
+
 static int __init walkera0701_init(void)
 {
-	return walkera0701_connect(&w_dev, walkera0701_pp_no);
+	return parport_register_driver(&walkera0701_parport_driver);
 }
 
 static void __exit walkera0701_exit(void)
 {
-	walkera0701_disconnect(&w_dev);
+	parport_unregister_driver(&walkera0701_parport_driver);
 }
 
 module_init(walkera0701_init);
-- 
1.9.1

