From: Stephen Kitt <steve@sk2.org>
Subject: Re: Restoring joydev BTNMAP ioctl compatibility
Date: Mon, 17 Aug 2009 21:24:16 +0200
Message-ID: <20090817212416.5c5b0a8b@sk2.org>
References: <20090810085242.3676ebc6@sk2.org>
	<20090810084436.98FFA526EC9@mailhub.coreip.homeip.net>
	<20090810132905.546a95ba@sk2.org>
	<20090810211245.73a3b4e5@sk2.org>
	<20090810205758.C7D3B526EC9@mailhub.coreip.homeip.net>
	<20090811082032.2aa364eb@sk2.org>
	<20090811075734.A12DE526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:33743 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753902AbZHQTYY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Aug 2009 15:24:24 -0400
In-Reply-To: <20090811075734.A12DE526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Tue, 11 Aug 2009 00:26:53 -0700, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Yep, exactly, except that don't bother with vmalloc, kmalloc will do
> nicely since the amout of memory needed is relatively small.

Did you have a chance to look at the previous patch I sent? In case it's
easier to review in one go, here's a single patch grouping the changes to the
ioctls themselves as well as the map validation code!

Regards,

Stephen


 Input: handle map ioctls regardless of declared length, and validate maps

 The KEY_MAX change in 2.6.28 changed the values of the JSIOCSBTNMAP and
 JSIOCGBTNMAP constants; software compiled with the old values no longer
 works with kernels following 2.6.28, because the ioctl switch statement
 no longer matches the values given by the software. This patch handles
 these ioctls independently of the length of data specified, and applies the
 same treatment to JSIOCSAXMAP and JSIOCGAXMAP which currently depend on
 ABS_MAX.

 Furthermore the user-supplied maps are validated before being copied over
 the driver's stored values; previously an invalid map could result in the
 driver's copy being partially updated.

 Signed-off-by: Stephen Kitt <steve@sk2.org>

 ---

 drivers/input/joydev.c |  100 +++++++++++++++++++++++++++++++++---------------
 1 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 4cfd084..ceaeb7b 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -456,8 +456,13 @@ static int joydev_ioctl_common(struct joydev *joydev,
 				unsigned int cmd, void __user *argp)
 {
 	struct input_dev *dev = joydev->handle.dev;
+	size_t len;
 	int i, j;
+	const char *name;
+	__u8 *tmpabspam;
+	__u16 *tmpkeypam;
 
+	/* Process fixed-sized commands. */
 	switch (cmd) {
 
 	case JS_SET_CAL:
@@ -499,55 +504,88 @@ static int joydev_ioctl_common(struct joydev *joydev,
 		return copy_to_user(argp, joydev->corr,
 			sizeof(joydev->corr[0]) * joydev->nabs) ? -EFAULT : 0;
 
-	case JSIOCSAXMAP:
-		if (copy_from_user(joydev->abspam, argp,
-				   sizeof(__u8) * (ABS_MAX + 1)))
-			return -EFAULT;
+	}
+
+	/* Process variable-sized commands (the axis and button map commands
+	   are considered variable-sized to decouple them from the values of
+	   ABS_MAX and KEY_MAX). */
+	switch (cmd & ~IOCSIZE_MASK) {
 
+	case (JSIOCSAXMAP & ~IOCSIZE_MASK):
+		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->abspam));
+
+		/* Validate the map. */
+		tmpabspam = kmalloc(len, GFP_KERNEL);
+		if (!tmpabspam)
+			return -ENOMEM;
+		if (copy_from_user(tmpabspam, argp, len)) {
+			kfree(tmpabspam);
+			return -EFAULT;
+		}
 		for (i = 0; i < joydev->nabs; i++) {
-			if (joydev->abspam[i] > ABS_MAX)
+			if (tmpabspam[i] > ABS_MAX) {
+				kfree(tmpabspam);
 				return -EINVAL;
+			}
+		}
+
+		memcpy(joydev->abspam, tmpabspam, len);
+		kfree(tmpabspam);
+
+		for (i = 0; i < joydev->nabs; i++) {
 			joydev->absmap[joydev->abspam[i]] = i;
 		}
 		return 0;
 
-	case JSIOCGAXMAP:
-		return copy_to_user(argp, joydev->abspam,
-			sizeof(__u8) * (ABS_MAX + 1)) ? -EFAULT : 0;
+	case (JSIOCGAXMAP & ~IOCSIZE_MASK):
+		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->abspam));
+		return copy_to_user(argp, joydev->abspam, len) ? -EFAULT : len;
 
-	case JSIOCSBTNMAP:
-		if (copy_from_user(joydev->keypam, argp,
-				   sizeof(__u16) * (KEY_MAX - BTN_MISC + 1)))
-			return -EFAULT;
+	case (JSIOCSBTNMAP & ~IOCSIZE_MASK):
+		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->keypam));
 
+		/* Validate the map. */
+		tmpkeypam = kmalloc(len, GFP_KERNEL);
+		if (!tmpkeypam)
+			return -ENOMEM;
+		if (copy_from_user(tmpkeypam, argp, len)) {
+			kfree(tmpkeypam);
+			return -EFAULT;
+		}
 		for (i = 0; i < joydev->nkey; i++) {
-			if (joydev->keypam[i] > KEY_MAX ||
-			    joydev->keypam[i] < BTN_MISC)
+			if (tmpkeypam[i] > KEY_MAX ||
+			    tmpkeypam[i] < BTN_MISC) {
+				kfree(tmpkeypam);
 				return -EINVAL;
+			}
+		}
+
+		memcpy(joydev->keypam, tmpkeypam, len);
+		kfree(tmpkeypam);
+
+		for (i = 0; i < joydev->nkey; i++) {
 			joydev->keymap[joydev->keypam[i] - BTN_MISC] = i;
 		}
 
 		return 0;
 
-	case JSIOCGBTNMAP:
-		return copy_to_user(argp, joydev->keypam,
-			sizeof(__u16) * (KEY_MAX - BTN_MISC + 1)) ? -EFAULT : 0;
+	case (JSIOCGBTNMAP & ~IOCSIZE_MASK):
+		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->keypam));
+		return copy_to_user(argp, joydev->keypam, len) ? -EFAULT : len;
 
-	default:
-		if ((cmd & ~IOCSIZE_MASK) == JSIOCGNAME(0)) {
-			int len;
-			const char *name = dev->name;
-
-			if (!name)
-				return 0;
-			len = strlen(name) + 1;
-			if (len > _IOC_SIZE(cmd))
-				len = _IOC_SIZE(cmd);
-			if (copy_to_user(argp, name, len))
-				return -EFAULT;
-			return len;
-		}
+	case JSIOCGNAME(0):
+		name = dev->name;
+
+		if (!name)
+			return 0;
+		len = strlen(name) + 1;
+		if (len > _IOC_SIZE(cmd))
+			len = _IOC_SIZE(cmd);
+		if (copy_to_user(argp, name, len))
+			return -EFAULT;
+		return len;
 	}
+
 	return -EINVAL;
 }
 
