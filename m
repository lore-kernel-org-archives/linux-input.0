From: Stephen Kitt <steve@sk2.org>
Subject: Re: Restoring joydev BTNMAP ioctl compatibility
Date: Tue, 11 Aug 2009 08:20:32 +0200
Message-ID: <20090811082032.2aa364eb@sk2.org>
References: <20090810085242.3676ebc6@sk2.org>
	<20090810084436.98FFA526EC9@mailhub.coreip.homeip.net>
	<20090810132905.546a95ba@sk2.org>
	<20090810211245.73a3b4e5@sk2.org>
	<20090810205758.C7D3B526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:52681 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbZHKMTc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Aug 2009 08:19:32 -0400
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 26A122CFE7
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2009 08:21:22 +0200 (CEST)
In-Reply-To: <20090810205758.C7D3B526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Mon, 10 Aug 2009 13:27:26 -0700, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Actually I think we need to return "len" here to let userspace know how
> much data we produced. Also, could you please give the same treatment to
> JSIOCGAXMAP and JSIOCSAXMAP and I will apply it.

Here goes! I'm not too familiar with kernel memory handling, I'll send the
fixes for the FIXMEs later on as a separate patch once I've figured things
out; I'm thinking along these lines:
* vmalloc() a buffer
* return -ENOMEM if no memory is available
* copy_from_user the data into the temporary buffer
* validate the data
* on error vfree() the buffer and return -EINVAL
* copy the data from the temporary buffer to the destination array
* vfree() the buffer

Would that be OK?

Regards,

Stephen


 Input: joydev - decouple axis and button map ioctls from input constants

 The KEY_MAX change in 2.6.28 changed the values of the JSIOCSBTNMAP and
 JSIOCGBTNMAP constants; software compiled with the old values no longer
 works with kernels following 2.6.28, because the ioctl switch statement
 no longer matches the values given by the software. This patch handles
 these ioctls independently of the length of data specified, and applies the
 same treatment to JSIOCSAXMAP and JSIOCGAXMAP which currently depend on
 ABS_MAX.

 Signed-off-by: Stephen Kitt <steve@sk2.org>

 ---

 drivers/input/joydev.c |   70 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 4cfd084..c4a5e7b 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -456,8 +456,11 @@ static int joydev_ioctl_common(struct joydev *joydev,
 				unsigned int cmd, void __user *argp)
 {
 	struct input_dev *dev = joydev->handle.dev;
+	size_t len;
 	int i, j;
+	const char *name;
 
+	/* Process fixed-sized commands. */
 	switch (cmd) {
 
 	case JS_SET_CAL:
@@ -499,9 +502,20 @@ static int joydev_ioctl_common(struct joydev *joydev,
 		return copy_to_user(argp, joydev->corr,
 			sizeof(joydev->corr[0]) * joydev->nabs) ? -EFAULT : 0;
 
-	case JSIOCSAXMAP:
-		if (copy_from_user(joydev->abspam, argp,
-				   sizeof(__u8) * (ABS_MAX + 1)))
+	}
+
+	/* Process variable-sized commands (the axis and button map commands
+	   are considered variable-sized to decouple them from the values of
+	   ABS_MAX and KEY_MAX). */
+	switch (cmd & ~IOCSIZE_MASK) {
+
+	case (JSIOCSAXMAP & ~IOCSIZE_MASK):
+		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->abspam));
+		/*
+		 * FIXME: we should not copy into our axis map before
+		 * validating the data.
+		 */
+		if (copy_from_user(joydev->abspam, argp, len))
 			return -EFAULT;
 
 		for (i = 0; i < joydev->nabs; i++) {
@@ -511,13 +525,17 @@ static int joydev_ioctl_common(struct joydev *joydev,
 		}
 		return 0;
 
-	case JSIOCGAXMAP:
-		return copy_to_user(argp, joydev->abspam,
-			sizeof(__u8) * (ABS_MAX + 1)) ? -EFAULT : 0;
-
-	case JSIOCSBTNMAP:
-		if (copy_from_user(joydev->keypam, argp,
-				   sizeof(__u16) * (KEY_MAX - BTN_MISC + 1)))
+	case (JSIOCGAXMAP & ~IOCSIZE_MASK):
+		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->abspam));
+		return copy_to_user(argp, joydev->abspam, len) ? -EFAULT : len;
+
+	case (JSIOCSBTNMAP & ~IOCSIZE_MASK):
+		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->keypam));
+		/*
+		 * FIXME: we should not copy into our keymap before
+		 * validating the data.
+		 */
+		if (copy_from_user(joydev->keypam, argp, len))
 			return -EFAULT;
 
 		for (i = 0; i < joydev->nkey; i++) {
@@ -529,25 +547,23 @@ static int joydev_ioctl_common(struct joydev *joydev,
 
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
 
