From: Tero Saarni <tero.saarni@gmail.com>
Subject: [PATCH] Input: synaptics - add support for reporting x/y resolution
Date: Sat, 16 May 2009 11:08:18 +0300
Message-ID: <1242461298.10555.24.camel@hp>
References: <1241460369.29685.6.camel@hp> <1241461145.29685.13.camel@hp>
	 <20090507164859.GB6450@dtor-d630.eng.vmware.com>
	 <ad348feb0905071159i68138a6cyef0d98410fc752cb@mail.gmail.com>
	 <20090508030345.GD30616@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:35791 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbZEPIIW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 May 2009 04:08:22 -0400
Received: by bwz22 with SMTP id 22so2287349bwz.37
        for <linux-input@vger.kernel.org>; Sat, 16 May 2009 01:08:22 -0700 (PDT)
In-Reply-To: <20090508030345.GD30616@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Synaptics uses anisotropic coordinate system.  On some wide touchpads
vertical resolution can be twice as high as horizontal which causes
unequal sensitivity on x/y directions.  Add support for reading the
resolution with EVIOCGABS ioctl.

Signed-off-by: Tero Saarni <tero.saarni@gmail.com>
---

Here's a new version of the patch I posted last week.  I've revised
it according to comments from Dmitry.  Please comment if I got the
idea completely wrong or if there's something I could fine tune.

I had some doubts regarding my change in set_input_params() where the
parameters generally seemed to be set to input_dev by calling
input_set_abs_params() helper function.  I did not add new resolution
parameter to this function since its use was so wide spread.  I just
assign the resolution parameters directly which seemed more practical
for me.

 drivers/input/evdev.c           |    8 ++++++--
 drivers/input/mouse/synaptics.c |   28 ++++++++++++++++++++++++++++
 drivers/input/mouse/synaptics.h |    2 ++
 include/linux/input.h           |    2 ++
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 7a7a026..f2df97f 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -626,8 +626,10 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 				abs.maximum = dev->absmax[t];
 				abs.fuzz = dev->absfuzz[t];
 				abs.flat = dev->absflat[t];
+				abs.resolution = dev->absres[t];
 
-				if (copy_to_user(p, &abs, sizeof(struct input_absinfo)))
+				if (copy_to_user(p, &abs,
+						min(_IOC_SIZE(cmd), sizeof(struct input_absinfo))))
 					return -EFAULT;
 
 				return 0;
@@ -655,7 +657,7 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 				t = _IOC_NR(cmd) & ABS_MAX;
 
 				if (copy_from_user(&abs, p,
-						sizeof(struct input_absinfo)))
+						min(_IOC_SIZE(cmd), sizeof(struct input_absinfo))))
 					return -EFAULT;
 
 				/*
@@ -670,6 +672,8 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 				dev->absmax[t] = abs.maximum;
 				dev->absfuzz[t] = abs.fuzz;
 				dev->absflat[t] = abs.flat;
+				dev->absres[t] = (_IOC_SIZE(cmd) < sizeof(struct input_absinfo)) ?
+					0 : abs.resolution;
 
 				spin_unlock_irq(&dev->event_lock);
 
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index f3e4f7b..19984bf 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -180,6 +180,29 @@ static int synaptics_identify(struct psmouse *psmouse)
 	return -1;
 }
 
+/*
+ * Read touchpad resolution
+ * Resolution is left zero if touchpad does not support the query
+ */
+static int synaptics_resolution(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	unsigned char res[3];
+
+	if (SYN_ID_MAJOR(priv->identity) < 4)
+		return 0;
+
+	if (synaptics_send_cmd(psmouse, SYN_QUE_RESOLUTION, res))
+		return 0;
+
+	if ((res[0] != 0) && (res[1] & 0x80) && (res[2] != 0)) {
+		priv->x_res = res[0]; /* x resolution in units/mm */
+		priv->y_res = res[2]; /* y resolution in units/mm */
+	}
+
+	return 0;
+}
+
 static int synaptics_query_hardware(struct psmouse *psmouse)
 {
 	if (synaptics_identify(psmouse))
@@ -188,6 +211,8 @@ static int synaptics_query_hardware(struct psmouse *psmouse)
 		return -1;
 	if (synaptics_capability(psmouse))
 		return -1;
+	if (synaptics_resolution(psmouse))
+		return -1;
 
 	return 0;
 }
@@ -563,6 +588,9 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	clear_bit(EV_REL, dev->evbit);
 	clear_bit(REL_X, dev->relbit);
 	clear_bit(REL_Y, dev->relbit);
+
+	dev->absres[ABS_X] = priv->x_res;
+	dev->absres[ABS_Y] = priv->y_res;
 }
 
 static void synaptics_disconnect(struct psmouse *psmouse)
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 02aa4cf..3023821 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -97,6 +97,8 @@ struct synaptics_data {
 	unsigned long int capabilities;		/* Capabilities */
 	unsigned long int ext_cap;		/* Extended Capabilities */
 	unsigned long int identity;		/* Identification */
+	int x_res;				/* X resolution in units/mm */
+	int y_res;				/* Y resolution in units/mm */
 
 	unsigned char pkt_type;			/* packet type - old, new, etc */
 	unsigned char mode;			/* current mode byte */
diff --git a/include/linux/input.h b/include/linux/input.h
index 0e6ff5d..351638d 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -53,6 +53,7 @@ struct input_absinfo {
 	__s32 maximum;
 	__s32 fuzz;
 	__s32 flat;
+	__s32 resolution;
 };
 
 #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
@@ -1108,6 +1109,7 @@ struct input_dev {
 	int absmin[ABS_MAX + 1];
 	int absfuzz[ABS_MAX + 1];
 	int absflat[ABS_MAX + 1];
+	int absres[ABS_MAX + 1];
 
 	int (*open)(struct input_dev *dev);
 	void (*close)(struct input_dev *dev);
-- 
1.6.0.4



