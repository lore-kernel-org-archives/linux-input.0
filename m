From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: [PATCH 3/8] V4L/DVB: rename sysfs remote controller devices from
 rcrcv to rc
Date: Thu, 8 Apr 2010 16:37:17 -0300
Message-ID: <20100408163717.1e55c862@pedra>
References: <cover.1270754989.git.mchehab@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1270754989.git.mchehab@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

=46rom: David H=E4rdeman <david@hardeman.nu>

When the remote controller class is anyway being renamed from ir to rc
this would be a good time to also rename the devices from rcrcvX to rcX=
=2E

I know we haven't reached any agreement on whether transmission will
eventually be handled by the same device, but this change will at
least make the device name non-receive-specific which will make it
possible in the future (and if a different approach is finally
agreed upon, the device name still works).

Signed-off-by: David H=E4rdeman <david@hardeman.nu>
Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>

diff --git a/drivers/media/IR/ir-sysfs.c b/drivers/media/IR/ir-sysfs.c
index 0b05c7b..e177140 100644
--- a/drivers/media/IR/ir-sysfs.c
+++ b/drivers/media/IR/ir-sysfs.c
@@ -39,7 +39,7 @@ static struct class ir_input_class =3D {
  * @buf:	a pointer to the output buffer
  *
  * This routine is a callback routine for input read the IR protocol t=
ype.
- * it is trigged by reading /sys/class/rc/rcrcv?/current_protocol.
+ * it is trigged by reading /sys/class/rc/rc?/current_protocol.
  * It returns the protocol name, as understood by the driver.
  */
 static ssize_t show_protocol(struct device *d,
@@ -74,7 +74,7 @@ static ssize_t show_protocol(struct device *d,
  * @len:	length of the input buffer
  *
  * This routine is a callback routine for changing the IR protocol typ=
e.
- * it is trigged by reading /sys/class/rc/rcrcv?/current_protocol.
+ * it is trigged by reading /sys/class/rc/rc?/current_protocol.
  * It changes the IR the protocol name, if the IR type is recognized
  * by the driver.
  * If an unknown protocol name is used, returns -EINVAL.
@@ -171,7 +171,7 @@ static struct device_type ir_dev_type =3D {
 };
=20
 /**
- * ir_register_class() - creates the sysfs for /sys/class/rc/rcrcv?
+ * ir_register_class() - creates the sysfs for /sys/class/rc/rc?
  * @input_dev:	the struct input_dev descriptor of the device
  *
  * This routine is used to register the syfs code for IR class
@@ -191,7 +191,7 @@ int ir_register_class(struct input_dev *input_dev)
 	ir_dev->dev.type =3D &ir_dev_type;
 	ir_dev->dev.class =3D &ir_input_class;
 	ir_dev->dev.parent =3D input_dev->dev.parent;
-	dev_set_name(&ir_dev->dev, "rcrcv%d", devno);
+	dev_set_name(&ir_dev->dev, "rc%d", devno);
 	dev_set_drvdata(&ir_dev->dev, ir_dev);
 	rc =3D device_register(&ir_dev->dev);
 	if (rc)
@@ -222,7 +222,7 @@ int ir_register_class(struct input_dev *input_dev)
=20
 /**
  * ir_unregister_class() - removes the sysfs for sysfs for
- *			   /sys/class/rc/rcrcv?
+ *			   /sys/class/rc/rc?
  * @input_dev:	the struct input_dev descriptor of the device
  *
  * This routine is used to unregister the syfs code for IR class
--=20
1.6.6.1
