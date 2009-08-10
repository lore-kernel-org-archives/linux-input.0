From: Stephen Kitt <steve@sk2.org>
Subject: Re: Restoring joydev BTNMAP ioctl compatibility
Date: Mon, 10 Aug 2009 21:12:45 +0200
Message-ID: <20090810211245.73a3b4e5@sk2.org>
References: <20090810085242.3676ebc6@sk2.org>
	<20090810084436.98FFA526EC9@mailhub.coreip.homeip.net>
	<20090810132905.546a95ba@sk2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:54752 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbZHJTMx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2009 15:12:53 -0400
In-Reply-To: <20090810132905.546a95ba@sk2.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Kitt <steve@sk2.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, 10 Aug 2009 13:29:05 +0200, Stephen Kitt <steve@sk2.org> wrote:
> A cleaner approach with a single case statement would involve switching on
> _IOC_NR(cmd) rather than cmd directly, and handling the length explicitly.
> That would make the ioctl ABI backwards-compatible when KEY_MAX increases
> without explicit handling! I can rewrite the patch in this way if you wish.

Something like the following, which also makes explicit the handling of
JSIOCGNAME!

Regards,

Stephen

 Input: joydev - handle old values of JSIOCSBTNMAP and JSIOCGBTNMAP ioctls

 The KEY_MAX change in 2.6.28 changed the values of the JSIOCSBTNMAP and
 JSIOCGBTNMAP constants; software compiled with the old values no longer
 works with kernels following 2.6.28, because the ioctl switch statement no
 longer matches the values given by the software. This patch handles these
 ioctls independently of the length of data specified.

 Signed-off-by: Stephen Kitt <steve@sk2.org>

 ---

 drivers/input/joydev.c |   50 +++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 4cfd084..8bd9569 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -456,8 +456,10 @@ static int joydev_ioctl_common(struct joydev *joydev,
 				unsigned int cmd, void __user *argp)
 {
 	struct input_dev *dev = joydev->handle.dev;
+	size_t len;
 	int i, j;
 
+	/* Process fixed-sized commands. */
 	switch (cmd) {
 
 	case JS_SET_CAL:
@@ -514,10 +516,20 @@ static int joydev_ioctl_common(struct joydev *joydev,
 	case JSIOCGAXMAP:
 		return copy_to_user(argp, joydev->abspam,
 			sizeof(__u8) * (ABS_MAX + 1)) ? -EFAULT : 0;
+	}
 
-	case JSIOCSBTNMAP:
-		if (copy_from_user(joydev->keypam, argp,
-				   sizeof(__u16) * (KEY_MAX - BTN_MISC + 1)))
+	/* Process variable-sized commands (the button map commands are
+	   considered variable-sized for compatibility reasons, and to avoid
+	   problems with future changes to KEY_MAX). */
+	switch (cmd & ~IOCSIZE_MASK) {
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
@@ -529,25 +541,23 @@ static int joydev_ioctl_common(struct joydev *joydev,
 
 		return 0;
 
-	case JSIOCGBTNMAP:
-		return copy_to_user(argp, joydev->keypam,
-			sizeof(__u16) * (KEY_MAX - BTN_MISC + 1)) ? -EFAULT : 0;
+	case (JSIOCGBTNMAP & ~IOCSIZE_MASK):
+		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->keypam));
+		return copy_to_user(argp, joydev->keypam, len) ? -EFAULT : 0;
 
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
+		const char *name = dev->name;
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
 
