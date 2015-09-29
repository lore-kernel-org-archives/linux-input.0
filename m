From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/4] Input: turbografx - use parallel port device model
Date: Tue, 29 Sep 2015 22:06:32 +0530
Message-ID: <1443544594-5800-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1443544594-5800-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443544594-5800-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-input@vger.kernel.org

Modify turbografx driver to use the new Parallel Port device model.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/joystick/turbografx.c | 100 ++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 49 deletions(-)

diff --git a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
index 891797a..01e8ea9 100644
--- a/drivers/input/joystick/turbografx.c
+++ b/drivers/input/joystick/turbografx.c
@@ -49,7 +49,7 @@ struct tgfx_config {
 	unsigned int nargs;
 };
 
-static struct tgfx_config tgfx_cfg[TGFX_MAX_PORTS] __initdata;
+static struct tgfx_config tgfx_cfg[TGFX_MAX_PORTS];
 
 module_param_array_named(map, tgfx_cfg[0].args, int, &tgfx_cfg[0].nargs, 0);
 MODULE_PARM_DESC(map, "Describes first set of devices (<parport#>,<js1>,<js2>,..<js7>");
@@ -81,6 +81,7 @@ static struct tgfx {
 	char phys[TGFX_MAX_DEVICES][32];
 	int sticks;
 	int used;
+	int parportno;
 	struct mutex sem;
 } *tgfx_base[TGFX_MAX_PORTS];
 
@@ -156,38 +157,46 @@ static void tgfx_close(struct input_dev *dev)
  * tgfx_probe() probes for tg gamepads.
  */
 
-static struct tgfx __init *tgfx_probe(int parport, int *n_buttons, int n_devs)
+static void tgfx_attach(struct parport *pp)
 {
 	struct tgfx *tgfx;
 	struct input_dev *input_dev;
-	struct parport *pp;
 	struct pardevice *pd;
 	int i, j;
-	int err;
+	int *n_buttons, n_devs;
+	struct pardev_cb tgfx_parport_cb;
+
+	for (i = 0; i < TGFX_MAX_PORTS; i++) {
+		if (tgfx_cfg[i].nargs == 0 || tgfx_cfg[i].args[0] < 0)
+			continue;
+		if (tgfx_cfg[i].args[0] == pp->number)
+			break;
+	}
 
-	pp = parport_find_number(parport);
-	if (!pp) {
-		printk(KERN_ERR "turbografx.c: no such parport\n");
-		err = -EINVAL;
-		goto err_out;
+	if (i == TGFX_MAX_PORTS) {
+		pr_debug("Not using parport%d.\n", pp->number);
+		return;
 	}
+	n_buttons = tgfx_cfg[i].args + 1;
+	n_devs = tgfx_cfg[i].nargs - 1;
 
-	pd = parport_register_device(pp, "turbografx", NULL, NULL, NULL, PARPORT_DEV_EXCL, NULL);
+	tgfx_parport_cb.flags = PARPORT_FLAG_EXCL;
+
+	pd = parport_register_dev_model(pp, "turbografx", &tgfx_parport_cb, i);
 	if (!pd) {
-		printk(KERN_ERR "turbografx.c: parport busy already - lp.o loaded?\n");
-		err = -EBUSY;
-		goto err_put_pp;
+		pr_err("parport busy already - lp.o loaded?\n");
+		return;
 	}
 
 	tgfx = kzalloc(sizeof(struct tgfx), GFP_KERNEL);
 	if (!tgfx) {
 		printk(KERN_ERR "turbografx.c: Not enough memory\n");
-		err = -ENOMEM;
 		goto err_unreg_pardev;
 	}
 
 	mutex_init(&tgfx->sem);
 	tgfx->pd = pd;
+	tgfx->parportno = pp->number;
 	init_timer(&tgfx->timer);
 	tgfx->timer.data = (long) tgfx;
 	tgfx->timer.function = tgfx_timer;
@@ -198,14 +207,12 @@ static struct tgfx __init *tgfx_probe(int parport, int *n_buttons, int n_devs)
 
 		if (n_buttons[i] > ARRAY_SIZE(tgfx_buttons)) {
 			printk(KERN_ERR "turbografx.c: Invalid number of buttons %d\n", n_buttons[i]);
-			err = -EINVAL;
 			goto err_unreg_devs;
 		}
 
 		tgfx->dev[i] = input_dev = input_allocate_device();
 		if (!input_dev) {
 			printk(KERN_ERR "turbografx.c: Not enough memory for input device\n");
-			err = -ENOMEM;
 			goto err_unreg_devs;
 		}
 
@@ -234,19 +241,17 @@ static struct tgfx __init *tgfx_probe(int parport, int *n_buttons, int n_devs)
 		for (j = 0; j < n_buttons[i]; j++)
 			set_bit(tgfx_buttons[j], input_dev->keybit);
 
-		err = input_register_device(tgfx->dev[i]);
-		if (err)
+		if (input_register_device(tgfx->dev[i]))
 			goto err_free_dev;
 	}
 
         if (!tgfx->sticks) {
 		printk(KERN_ERR "turbografx.c: No valid devices specified\n");
-		err = -EINVAL;
 		goto err_free_tgfx;
         }
 
-	parport_put_port(pp);
-	return tgfx;
+	tgfx_base[i] = tgfx;
+	return;
 
  err_free_dev:
 	input_free_device(tgfx->dev[i]);
@@ -258,15 +263,23 @@ static struct tgfx __init *tgfx_probe(int parport, int *n_buttons, int n_devs)
 	kfree(tgfx);
  err_unreg_pardev:
 	parport_unregister_device(pd);
- err_put_pp:
-	parport_put_port(pp);
- err_out:
-	return ERR_PTR(err);
 }
 
-static void tgfx_remove(struct tgfx *tgfx)
+static void tgfx_detach(struct parport *port)
 {
 	int i;
+	struct tgfx *tgfx;
+
+	for (i = 0; i < TGFX_MAX_PORTS; i++) {
+		if (tgfx_base[i] && tgfx_base[i]->parportno == port->number)
+			break;
+	}
+
+	if (i == TGFX_MAX_PORTS)
+		return;
+
+	tgfx = tgfx_base[i];
+	tgfx_base[i] = NULL;
 
 	for (i = 0; i < TGFX_MAX_DEVICES; i++)
 		if (tgfx->dev[i])
@@ -275,11 +288,17 @@ static void tgfx_remove(struct tgfx *tgfx)
 	kfree(tgfx);
 }
 
+static struct parport_driver tgfx_parport_driver = {
+	.name = "turbografx",
+	.match_port = tgfx_attach,
+	.detach = tgfx_detach,
+	.devmodel = true,
+};
+
 static int __init tgfx_init(void)
 {
 	int i;
 	int have_dev = 0;
-	int err = 0;
 
 	for (i = 0; i < TGFX_MAX_PORTS; i++) {
 		if (tgfx_cfg[i].nargs == 0 || tgfx_cfg[i].args[0] < 0)
@@ -287,38 +306,21 @@ static int __init tgfx_init(void)
 
 		if (tgfx_cfg[i].nargs < 2) {
 			printk(KERN_ERR "turbografx.c: at least one joystick must be specified\n");
-			err = -EINVAL;
-			break;
-		}
-
-		tgfx_base[i] = tgfx_probe(tgfx_cfg[i].args[0],
-					  tgfx_cfg[i].args + 1,
-					  tgfx_cfg[i].nargs - 1);
-		if (IS_ERR(tgfx_base[i])) {
-			err = PTR_ERR(tgfx_base[i]);
-			break;
+			return -EINVAL;
 		}
 
 		have_dev = 1;
 	}
 
-	if (err) {
-		while (--i >= 0)
-			if (tgfx_base[i])
-				tgfx_remove(tgfx_base[i]);
-		return err;
-	}
+	if (!have_dev)
+		return -ENODEV;
 
-	return have_dev ? 0 : -ENODEV;
+	return parport_register_driver(&tgfx_parport_driver);
 }
 
 static void __exit tgfx_exit(void)
 {
-	int i;
-
-	for (i = 0; i < TGFX_MAX_PORTS; i++)
-		if (tgfx_base[i])
-			tgfx_remove(tgfx_base[i]);
+	parport_unregister_driver(&tgfx_parport_driver);
 }
 
 module_init(tgfx_init);
-- 
1.9.1
