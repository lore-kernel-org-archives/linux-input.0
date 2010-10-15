From: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/7] IR: make sure we register the input device when it is
	safe to do so.
Date: Fri, 15 Oct 2010 17:07:48 +0200
Message-ID: <1287155273-16171-3-git-send-email-maximlevitsky@gmail.com>
References: <1287155273-16171-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lirc-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287155273-16171-1-git-send-email-maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/lirc-list>,
	<mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=lirc-list>
List-Post: <mailto:lirc-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/lirc-list>,
	<mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: lirc-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lirc-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

As soon as input device is registered, it might be accessed (and it is)
This can trigger a hardware interrupt that can access
not yet initialized ir->raw, (by sending a sample)

This can be reproduced by holding down a remote button and reloading the module.
And this always crashes the systems where hardware decides to send an interrupt
right at the moment it is enabled.

Signed-off-by: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/media/IR/ir-core-priv.h |    1 +
 drivers/media/IR/ir-keytable.c  |    2 ++
 drivers/media/IR/ir-sysfs.c     |   27 +++++++++++++++++----------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/media/IR/ir-core-priv.h b/drivers/media/IR/ir-core-priv.h
index 761e7f4..5d7e08f 100644
--- a/drivers/media/IR/ir-core-priv.h
+++ b/drivers/media/IR/ir-core-priv.h
@@ -116,6 +116,7 @@ static inline void decrease_duration(struct ir_raw_event *ev, unsigned duration)
  * Routines from ir-sysfs.c - Meant to be called only internally inside
  * ir-core
  */
+int ir_register_input(struct input_dev *input_dev);
 
 int ir_register_class(struct input_dev *input_dev);
 void ir_unregister_class(struct input_dev *input_dev);
diff --git a/drivers/media/IR/ir-keytable.c b/drivers/media/IR/ir-keytable.c
index a3f0af3..1997812 100644
--- a/drivers/media/IR/ir-keytable.c
+++ b/drivers/media/IR/ir-keytable.c
@@ -505,6 +505,8 @@ int __ir_input_register(struct input_dev *input_dev,
 				goto out_event;
 		}
 
+	rc = ir_register_input(input_dev);
+
 	IR_dprintk(1, "Registered input device on %s for %s remote%s.\n",
 		   driver_name, rc_tab->name,
 		   (ir_dev->props && ir_dev->props->driver_type == RC_DRIVER_IR_RAW) ?
diff --git a/drivers/media/IR/ir-sysfs.c b/drivers/media/IR/ir-sysfs.c
index 46d4246..ada2ec6 100644
--- a/drivers/media/IR/ir-sysfs.c
+++ b/drivers/media/IR/ir-sysfs.c
@@ -256,8 +256,6 @@ static struct device_type rc_dev_type = {
  */
 int ir_register_class(struct input_dev *input_dev)
 {
-	int rc;
-	const char *path;
 	struct ir_input_dev *ir_dev = input_get_drvdata(input_dev);
 	int devno = find_first_zero_bit(&ir_core_dev_number,
 					IRRCV_NUM_DEVICES);
@@ -266,17 +264,28 @@ int ir_register_class(struct input_dev *input_dev)
 		return devno;
 
 	ir_dev->dev.type = &rc_dev_type;
+	ir_dev->devno = devno;
 
 	ir_dev->dev.class = &ir_input_class;
 	ir_dev->dev.parent = input_dev->dev.parent;
+	input_dev->dev.parent = &ir_dev->dev;
 	dev_set_name(&ir_dev->dev, "rc%d", devno);
 	dev_set_drvdata(&ir_dev->dev, ir_dev);
-	rc = device_register(&ir_dev->dev);
-	if (rc)
-		return rc;
+	return  device_register(&ir_dev->dev);
+};
+
+/**
+ * ir_register_input - registers ir input device with input subsystem
+ * @input_dev:	the struct input_dev descriptor of the device
+ */
+
+int ir_register_input(struct input_dev *input_dev)
+{
+	struct ir_input_dev *ir_dev = input_get_drvdata(input_dev);
+	int rc;
+	const char *path;
 
 
-	input_dev->dev.parent = &ir_dev->dev;
 	rc = input_register_device(input_dev);
 	if (rc < 0) {
 		device_del(&ir_dev->dev);
@@ -292,11 +301,9 @@ int ir_register_class(struct input_dev *input_dev)
 		path ? path : "N/A");
 	kfree(path);
 
-	ir_dev->devno = devno;
-	set_bit(devno, &ir_core_dev_number);
-
+	set_bit(ir_dev->devno, &ir_core_dev_number);
 	return 0;
-};
+}
 
 /**
  * ir_unregister_class() - removes the sysfs for sysfs for
-- 
1.7.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
