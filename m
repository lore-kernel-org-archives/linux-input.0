From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v2] Input: drivers/joystick: use parallel port device
 model
Date: Sat, 8 Aug 2015 16:05:15 +0530
Message-ID: <20150808103515.GC1301@sudip-pc>
References: <1438698351-24604-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438698351-24604-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-input@vger.kernel.org

On Tue, Aug 04, 2015 at 07:55:51PM +0530, Sudip Mukherjee wrote:
> Modify db9 driver to use the new Parallel Port device model.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
> 
> v2: an extra check was removed. db9_base could not be removed. Already
> mailed you the reasons, reference is at:
> https://lkml.org/lkml/2015/8/3/403

Hi Dmitry,
I was telling you on the other thread that to remove db9_base we will
need to modify the parport code and then it has to be tested by everyone
again and that will also change the old behaviour of parport. The v2 to
which I am replying now is still having that db9_base.

Please see the following patch, this is the minimum change required to
update db9 driver. Personally I donot like this approach as in this
method if a parallel port is hotplugged after this driver is loaded then
it will not work. Please let me know your views on the posted v2 and
also on the following proposal.

regards
sudip


diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
index 8e7de5c..348e7d2 100644
--- a/drivers/input/joystick/db9.c
+++ b/drivers/input/joystick/db9.c
@@ -553,7 +553,7 @@ static void db9_close(struct input_dev *dev)
 	mutex_unlock(&db9->mutex);
 }
 
-static struct db9 __init *db9_probe(int parport, int mode)
+static struct db9 __init *db9_probe(int parport, int mode, int cnt)
 {
 	struct db9 *db9;
 	const struct db9_mode_data *db9_mode;
@@ -562,6 +562,7 @@ static struct db9 __init *db9_probe(int parport, int mode)
 	struct input_dev *input_dev;
 	int i, j;
 	int err;
+	struct pardev_cb db9_parport_cb;
 
 	if (mode < 1 || mode >= DB9_MAX_PAD || !db9_modes[mode].n_buttons) {
 		printk(KERN_ERR "db9.c: Bad device type %d\n", mode);
@@ -584,7 +585,9 @@ static struct db9 __init *db9_probe(int parport, int mode)
 		goto err_put_pp;
 	}
 
-	pd = parport_register_device(pp, "db9", NULL, NULL, NULL, PARPORT_DEV_EXCL, NULL);
+	db9_parport_cb.flags = PARPORT_FLAG_EXCL;
+
+	pd = parport_register_dev_model(pp, "db9", &db9_parport_cb, cnt);
 	if (!pd) {
 		printk(KERN_ERR "db9.c: parport busy already - lp.o loaded?\n");
 		err = -EBUSY;
@@ -671,11 +674,19 @@ static void db9_remove(struct db9 *db9)
 	kfree(db9);
 }
 
+static struct parport_driver db9_parport_driver = {
+	.name = "db9",
+	.devmodel = true,
+};
+
 static int __init db9_init(void)
 {
 	int i;
 	int have_dev = 0;
-	int err = 0;
+	int err = parport_register_driver(&db9_parport_driver);
+
+	if (err)
+		return err;
 
 	for (i = 0; i < DB9_MAX_PORTS; i++) {
 		if (db9_cfg[i].nargs == 0 || db9_cfg[i].args[DB9_ARG_PARPORT] < 0)
@@ -688,7 +699,7 @@ static int __init db9_init(void)
 		}
 
 		db9_base[i] = db9_probe(db9_cfg[i].args[DB9_ARG_PARPORT],
-					db9_cfg[i].args[DB9_ARG_MODE]);
+					db9_cfg[i].args[DB9_ARG_MODE], i);
 		if (IS_ERR(db9_base[i])) {
 			err = PTR_ERR(db9_base[i]);
 			break;
@@ -701,10 +712,15 @@ static int __init db9_init(void)
 		while (--i >= 0)
 			if (db9_base[i])
 				db9_remove(db9_base[i]);
+		parport_unregister_driver(&db9_parport_driver);
 		return err;
 	}
 
-	return have_dev ? 0 : -ENODEV;
+	if (have_dev)
+		return 0;
+
+	parport_unregister_driver(&db9_parport_driver);
+	return -ENODEV;
 }
 
 static void __exit db9_exit(void)
@@ -714,6 +730,7 @@ static void __exit db9_exit(void)
 	for (i = 0; i < DB9_MAX_PORTS; i++)
 		if (db9_base[i])
 			db9_remove(db9_base[i]);
+	parport_unregister_driver(&db9_parport_driver);
 }
 
 module_init(db9_init);
