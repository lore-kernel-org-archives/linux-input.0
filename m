From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/4] Input: gamecon - use parallel port device model
Date: Tue, 29 Sep 2015 22:06:31 +0530
Message-ID: <1443544594-5800-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1443544594-5800-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33588 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934932AbbI2Qgv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 12:36:51 -0400
In-Reply-To: <1443544594-5800-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Modify gamecon driver to use the new Parallel Port device model.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/joystick/gamecon.c | 100 +++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
index e68e497..394ccbe 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -53,7 +53,7 @@ struct gc_config {
 	unsigned int nargs;
 };
 
-static struct gc_config gc_cfg[GC_MAX_PORTS] __initdata;
+static struct gc_config gc_cfg[GC_MAX_PORTS];
 
 module_param_array_named(map, gc_cfg[0].args, int, &gc_cfg[0].nargs, 0);
 MODULE_PARM_DESC(map, "Describes first set of devices (<parport#>,<pad1>,<pad2>,..<pad5>)");
@@ -92,6 +92,7 @@ struct gc {
 	struct timer_list timer;
 	int pad_count[GC_MAX];
 	int used;
+	int parportno;
 	struct mutex mutex;
 };
 
@@ -304,7 +305,7 @@ static int gc_n64_play_effect(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static int __init gc_n64_init_ff(struct input_dev *dev, int i)
+static int gc_n64_init_ff(struct input_dev *dev, int i)
 {
 	struct gc_subdev *sdev;
 	int err;
@@ -811,7 +812,7 @@ static void gc_close(struct input_dev *dev)
 	mutex_unlock(&gc->mutex);
 }
 
-static int __init gc_setup_pad(struct gc *gc, int idx, int pad_type)
+static int gc_setup_pad(struct gc *gc, int idx, int pad_type)
 {
 	struct gc_pad *pad = &gc->pads[idx];
 	struct input_dev *input_dev;
@@ -926,46 +927,54 @@ err_free_dev:
 	return err;
 }
 
-static struct gc __init *gc_probe(int parport, int *pads, int n_pads)
+static void gc_attach(struct parport *pp)
 {
 	struct gc *gc;
-	struct parport *pp;
 	struct pardevice *pd;
 	int i;
 	int count = 0;
-	int err;
+	int *pads, n_pads;
+	struct pardev_cb gc_parport_cb;
+
+	for (i = 0; i < GC_MAX_PORTS; i++) {
+		if (gc_cfg[i].nargs == 0 || gc_cfg[i].args[0] < 0)
+			continue;
+
+		if (gc_cfg[i].args[0] == pp->number)
+			break;
+	}
 
-	pp = parport_find_number(parport);
-	if (!pp) {
-		pr_err("no such parport %d\n", parport);
-		err = -EINVAL;
-		goto err_out;
+	if (i == GC_MAX_PORTS) {
+		pr_debug("Not using parport%d.\n", pp->number);
+		return;
 	}
+	pads = gc_cfg[i].args + 1;
+	n_pads = gc_cfg[i].nargs - 1;
+
+	gc_parport_cb.flags = PARPORT_FLAG_EXCL;
 
-	pd = parport_register_device(pp, "gamecon", NULL, NULL, NULL, PARPORT_DEV_EXCL, NULL);
+	pd = parport_register_dev_model(pp, "gamecon", &gc_parport_cb, i);
 	if (!pd) {
 		pr_err("parport busy already - lp.o loaded?\n");
-		err = -EBUSY;
-		goto err_put_pp;
+		return;
 	}
 
 	gc = kzalloc(sizeof(struct gc), GFP_KERNEL);
 	if (!gc) {
 		pr_err("Not enough memory\n");
-		err = -ENOMEM;
 		goto err_unreg_pardev;
 	}
 
 	mutex_init(&gc->mutex);
 	gc->pd = pd;
+	gc->parportno = pp->number;
 	setup_timer(&gc->timer, gc_timer, (long) gc);
 
 	for (i = 0; i < n_pads && i < GC_MAX_DEVICES; i++) {
 		if (!pads[i])
 			continue;
 
-		err = gc_setup_pad(gc, i, pads[i]);
-		if (err)
+		if (gc_setup_pad(gc, i, pads[i]))
 			goto err_unreg_devs;
 
 		count++;
@@ -973,12 +982,11 @@ static struct gc __init *gc_probe(int parport, int *pads, int n_pads)
 
 	if (count == 0) {
 		pr_err("No valid devices specified\n");
-		err = -EINVAL;
 		goto err_free_gc;
 	}
 
-	parport_put_port(pp);
-	return gc;
+	gc_base[i] = gc;
+	return;
 
  err_unreg_devs:
 	while (--i >= 0)
@@ -988,15 +996,23 @@ static struct gc __init *gc_probe(int parport, int *pads, int n_pads)
 	kfree(gc);
  err_unreg_pardev:
 	parport_unregister_device(pd);
- err_put_pp:
-	parport_put_port(pp);
- err_out:
-	return ERR_PTR(err);
 }
 
-static void gc_remove(struct gc *gc)
+static void gc_detach(struct parport *port)
 {
 	int i;
+	struct gc *gc;
+
+	for (i = 0; i < GC_MAX_PORTS; i++) {
+		if (gc_base[i] && gc_base[i]->parportno == port->number)
+			break;
+	}
+
+	if (i == GC_MAX_PORTS)
+		return;
+
+	gc = gc_base[i];
+	gc_base[i] = NULL;
 
 	for (i = 0; i < GC_MAX_DEVICES; i++)
 		if (gc->pads[i].dev)
@@ -1005,11 +1021,17 @@ static void gc_remove(struct gc *gc)
 	kfree(gc);
 }
 
+static struct parport_driver gc_parport_driver = {
+	.name = "gamecon",
+	.match_port = gc_attach,
+	.detach = gc_detach,
+	.devmodel = true,
+};
+
 static int __init gc_init(void)
 {
 	int i;
 	int have_dev = 0;
-	int err = 0;
 
 	for (i = 0; i < GC_MAX_PORTS; i++) {
 		if (gc_cfg[i].nargs == 0 || gc_cfg[i].args[0] < 0)
@@ -1017,37 +1039,21 @@ static int __init gc_init(void)
 
 		if (gc_cfg[i].nargs < 2) {
 			pr_err("at least one device must be specified\n");
-			err = -EINVAL;
-			break;
-		}
-
-		gc_base[i] = gc_probe(gc_cfg[i].args[0],
-				      gc_cfg[i].args + 1, gc_cfg[i].nargs - 1);
-		if (IS_ERR(gc_base[i])) {
-			err = PTR_ERR(gc_base[i]);
-			break;
+			return -EINVAL;
 		}
 
 		have_dev = 1;
 	}
 
-	if (err) {
-		while (--i >= 0)
-			if (gc_base[i])
-				gc_remove(gc_base[i]);
-		return err;
-	}
+	if (!have_dev)
+		return -ENODEV;
 
-	return have_dev ? 0 : -ENODEV;
+	return parport_register_driver(&gc_parport_driver);
 }
 
 static void __exit gc_exit(void)
 {
-	int i;
-
-	for (i = 0; i < GC_MAX_PORTS; i++)
-		if (gc_base[i])
-			gc_remove(gc_base[i]);
+	parport_unregister_driver(&gc_parport_driver);
 }
 
 module_init(gc_init);
-- 
1.9.1

