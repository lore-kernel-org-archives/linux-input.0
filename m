From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/4] Input: serio - use parallel port device model
Date: Tue, 29 Sep 2015 22:06:33 +0530
Message-ID: <1443544594-5800-4-git-send-email-sudipm.mukherjee@gmail.com>
References: <1443544594-5800-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35334 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934888AbbI2Qgz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 12:36:55 -0400
In-Reply-To: <1443544594-5800-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Modify parkbd driver to use the new Parallel Port device model.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/serio/parkbd.c | 55 +++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
index 1e8cd6f..74bb172 100644
--- a/drivers/input/serio/parkbd.c
+++ b/drivers/input/serio/parkbd.c
@@ -141,19 +141,15 @@ static void parkbd_interrupt(void *dev_id)
 	parkbd_last = jiffies;
 }
 
-static int parkbd_getport(void)
+static int parkbd_getport(struct parport *pp)
 {
-	struct parport *pp;
+	struct pardev_cb parkbd_parport_cb;
 
-	pp = parport_find_number(parkbd_pp_no);
+	parkbd_parport_cb.irq_func = parkbd_interrupt;
+	parkbd_parport_cb.flags = PARPORT_FLAG_EXCL;
 
-	if (pp == NULL) {
-		printk(KERN_ERR "parkbd: no such parport\n");
-		return -ENODEV;
-	}
-
-	parkbd_dev = parport_register_device(pp, "parkbd", NULL, NULL, parkbd_interrupt, PARPORT_DEV_EXCL, NULL);
-	parport_put_port(pp);
+	parkbd_dev = parport_register_dev_model(pp, "parkbd",
+						&parkbd_parport_cb, 0);
 
 	if (!parkbd_dev)
 		return -ENODEV;
@@ -183,19 +179,21 @@ static struct serio * __init parkbd_allocate_serio(void)
 	return serio;
 }
 
-static int __init parkbd_init(void)
+static void parkbd_attach(struct parport *pp)
 {
-	int err;
+	if (pp->number != parkbd_pp_no) {
+		pr_debug("Not using parport%d.\n", pp->number);
+		return;
+	}
 
-	err = parkbd_getport();
-	if (err)
-		return err;
+	if (parkbd_getport(pp))
+		return;
 
 	parkbd_port = parkbd_allocate_serio();
 	if (!parkbd_port) {
 		parport_release(parkbd_dev);
 		parport_unregister_device(parkbd_dev);
-		return -ENOMEM;
+		return;
 	}
 
 	parkbd_writelines(3);
@@ -205,14 +203,35 @@ static int __init parkbd_init(void)
 	printk(KERN_INFO "serio: PARKBD %s adapter on %s\n",
                         parkbd_mode ? "AT" : "XT", parkbd_dev->port->name);
 
-	return 0;
+	return;
 }
 
-static void __exit parkbd_exit(void)
+static void parkbd_detach(struct parport *port)
 {
+	if (!parkbd_port || port->number != parkbd_pp_no)
+		return;
+
 	parport_release(parkbd_dev);
 	serio_unregister_port(parkbd_port);
 	parport_unregister_device(parkbd_dev);
+	parkbd_port = NULL;
+}
+
+static struct parport_driver parkbd_parport_driver = {
+	.name = "parkbd",
+	.match_port = parkbd_attach,
+	.detach = parkbd_detach,
+	.devmodel = true,
+};
+
+static int __init parkbd_init(void)
+{
+	return parport_register_driver(&parkbd_parport_driver);
+}
+
+static void __exit parkbd_exit(void)
+{
+	parport_unregister_driver(&parkbd_parport_driver);
 }
 
 module_init(parkbd_init);
-- 
1.9.1

