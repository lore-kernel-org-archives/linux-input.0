From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] Input: drivers/joystick: use parallel port device model
Date: Tue,  4 Aug 2015 19:55:51 +0530
Message-ID: <1438698351-24604-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-input@vger.kernel.org

Modify db9 driver to use the new Parallel Port device model.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

v2: an extra check was removed. db9_base could not be removed. Already
mailed you the reasons, reference is at:
https://lkml.org/lkml/2015/8/3/403

 drivers/input/joystick/db9.c | 110 ++++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 54 deletions(-)

diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
index 8e7de5c..e457e10 100644
--- a/drivers/input/joystick/db9.c
+++ b/drivers/input/joystick/db9.c
@@ -48,7 +48,7 @@ struct db9_config {
 };
 
 #define DB9_MAX_PORTS		3
-static struct db9_config db9_cfg[DB9_MAX_PORTS] __initdata;
+static struct db9_config db9_cfg[DB9_MAX_PORTS];
 
 module_param_array_named(dev, db9_cfg[0].args, int, &db9_cfg[0].nargs, 0);
 MODULE_PARM_DESC(dev, "Describes first attached device (<parport#>,<type>)");
@@ -106,6 +106,7 @@ struct db9 {
 	struct pardevice *pd;
 	int mode;
 	int used;
+	int parportno;
 	struct mutex mutex;
 	char phys[DB9_MAX_DEVICES][32];
 };
@@ -553,54 +554,60 @@ static void db9_close(struct input_dev *dev)
 	mutex_unlock(&db9->mutex);
 }
 
-static struct db9 __init *db9_probe(int parport, int mode)
+static void db9_attach(struct parport *pp)
 {
 	struct db9 *db9;
 	const struct db9_mode_data *db9_mode;
-	struct parport *pp;
 	struct pardevice *pd;
 	struct input_dev *input_dev;
 	int i, j;
-	int err;
+	int mode;
+	struct pardev_cb db9_parport_cb;
+
+	for (i = 0; i < DB9_MAX_PORTS; i++) {
+		if (db9_cfg[i].nargs == 0 ||
+		    db9_cfg[i].args[DB9_ARG_PARPORT] < 0)
+			continue;
+
+		if (db9_cfg[i].args[DB9_ARG_PARPORT] == pp->number)
+			break;
+	}
+
+	if (i == DB9_MAX_PORTS) {
+		pr_debug("Not using parport%d.\n", pp->number);
+		return;
+	}
+
+	mode = db9_cfg[i].args[DB9_ARG_MODE];
 
 	if (mode < 1 || mode >= DB9_MAX_PAD || !db9_modes[mode].n_buttons) {
 		printk(KERN_ERR "db9.c: Bad device type %d\n", mode);
-		err = -EINVAL;
-		goto err_out;
+		return;
 	}
 
 	db9_mode = &db9_modes[mode];
 
-	pp = parport_find_number(parport);
-	if (!pp) {
-		printk(KERN_ERR "db9.c: no such parport\n");
-		err = -ENODEV;
-		goto err_out;
-	}
-
 	if (db9_mode->bidirectional && !(pp->modes & PARPORT_MODE_TRISTATE)) {
 		printk(KERN_ERR "db9.c: specified parport is not bidirectional\n");
-		err = -EINVAL;
-		goto err_put_pp;
+		return;
 	}
 
-	pd = parport_register_device(pp, "db9", NULL, NULL, NULL, PARPORT_DEV_EXCL, NULL);
+	db9_parport_cb.flags = PARPORT_FLAG_EXCL;
+
+	pd = parport_register_dev_model(pp, "db9", &db9_parport_cb, i);
 	if (!pd) {
 		printk(KERN_ERR "db9.c: parport busy already - lp.o loaded?\n");
-		err = -EBUSY;
-		goto err_put_pp;
+		return;
 	}
 
 	db9 = kzalloc(sizeof(struct db9), GFP_KERNEL);
-	if (!db9) {
-		printk(KERN_ERR "db9.c: Not enough memory\n");
-		err = -ENOMEM;
+	if (!db9)
 		goto err_unreg_pardev;
-	}
 
 	mutex_init(&db9->mutex);
 	db9->pd = pd;
 	db9->mode = mode;
+	db9->parportno = pp->number;
 	init_timer(&db9->timer);
 	db9->timer.data = (long) db9;
 	db9->timer.function = db9_timer;
@@ -610,7 +617,6 @@ static struct db9 __init *db9_probe(int parport, int mode)
 		db9->dev[i] = input_dev = input_allocate_device();
 		if (!input_dev) {
 			printk(KERN_ERR "db9.c: Not enough memory for input device\n");
-			err = -ENOMEM;
 			goto err_unreg_devs;
 		}
 
@@ -639,13 +645,12 @@ static struct db9 __init *db9_probe(int parport, int mode)
 				input_set_abs_params(input_dev, db9_abs[j], 1, 255, 0, 0);
 		}
 
-		err = input_register_device(input_dev);
-		if (err)
+		if (input_register_device(input_dev))
 			goto err_free_dev;
 	}
 
-	parport_put_port(pp);
-	return db9;
+	db9_base[i] = db9;
+	return;
 
  err_free_dev:
 	input_free_device(db9->dev[i]);
@@ -655,15 +660,22 @@ static struct db9 __init *db9_probe(int parport, int mode)
 	kfree(db9);
  err_unreg_pardev:
 	parport_unregister_device(pd);
- err_put_pp:
-	parport_put_port(pp);
- err_out:
-	return ERR_PTR(err);
 }
 
-static void db9_remove(struct db9 *db9)
+static void db9_detach(struct parport *port)
 {
 	int i;
+	struct db9 *db9;
+
+	for (i = 0; i < DB9_MAX_PORTS; i++) {
+		if (db9_base[i] && db9_base[i]->parportno == port->number)
+			break;
+	}
+
+	if (i == DB9_MAX_PORTS)
+		return;
+
+	db9 = db9_base[i];
 
 	for (i = 0; i < min(db9_modes[db9->mode].n_pads, DB9_MAX_DEVICES); i++)
 		input_unregister_device(db9->dev[i]);
@@ -671,11 +683,17 @@ static void db9_remove(struct db9 *db9)
 	kfree(db9);
 }
 
+static struct parport_driver db9_parport_driver = {
+	.name = "db9",
+	.match_port = db9_attach,
+	.detach = db9_detach,
+	.devmodel = true,
+};
+
 static int __init db9_init(void)
 {
 	int i;
 	int have_dev = 0;
-	int err = 0;
 
 	for (i = 0; i < DB9_MAX_PORTS; i++) {
 		if (db9_cfg[i].nargs == 0 || db9_cfg[i].args[DB9_ARG_PARPORT] < 0)
@@ -683,37 +701,21 @@ static int __init db9_init(void)
 
 		if (db9_cfg[i].nargs < 2) {
 			printk(KERN_ERR "db9.c: Device type must be specified.\n");
-			err = -EINVAL;
-			break;
-		}
-
-		db9_base[i] = db9_probe(db9_cfg[i].args[DB9_ARG_PARPORT],
-					db9_cfg[i].args[DB9_ARG_MODE]);
-		if (IS_ERR(db9_base[i])) {
-			err = PTR_ERR(db9_base[i]);
-			break;
+			return -EINVAL;
 		}
 
 		have_dev = 1;
 	}
 
-	if (err) {
-		while (--i >= 0)
-			if (db9_base[i])
-				db9_remove(db9_base[i]);
-		return err;
-	}
+	if (!have_dev)
+		return -ENODEV;
 
-	return have_dev ? 0 : -ENODEV;
+	return parport_register_driver(&db9_parport_driver);
 }
 
 static void __exit db9_exit(void)
 {
-	int i;
-
-	for (i = 0; i < DB9_MAX_PORTS; i++)
-		if (db9_base[i])
-			db9_remove(db9_base[i]);
+	parport_unregister_driver(&db9_parport_driver);
 }
 
 module_init(db9_init);
-- 
1.9.1
