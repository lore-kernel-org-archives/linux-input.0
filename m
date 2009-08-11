From: Stephen Kitt <steve@sk2.org>
Subject: Re: Restoring joydev BTNMAP ioctl compatibility
Date: Wed, 12 Aug 2009 00:00:49 +0200
Message-ID: <20090812000049.4499fcb1@sk2.org>
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
Received: from smtp1-g21.free.fr ([212.27.42.1]:48379 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703AbZHKWA5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Aug 2009 18:00:57 -0400
In-Reply-To: <20090811075734.A12DE526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, 11 Aug 2009 00:26:53 -0700, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Aug 11, 2009 at 08:20:32AM +0200, Stephen Kitt wrote:
> > Here goes! I'm not too familiar with kernel memory handling, I'll send the
> > fixes for the FIXMEs later on as a separate patch once I've figured things
> > out; I'm thinking along these lines:
> > * vmalloc() a buffer
> > * return -ENOMEM if no memory is available
> > * copy_from_user the data into the temporary buffer
> > * validate the data
> > * on error vfree() the buffer and return -EINVAL
> > * copy the data from the temporary buffer to the destination array
> > * vfree() the buffer
> > 
> 
> Yep, exactly, except that don't bother with vmalloc, kmalloc will do
> nicely since the amout of memory needed is relatively small.

The following does just that (it applies on top of the previous patch).

The change to JSIOCGBTNMAP and JSIOCGAXMAP revealed a bug in the Debian and
Ubuntu versions of jscal (they reacted to any non-zero return value of
ioctl() as an error, not just negative values), but it will be fixed by the
time this makes it into the kernel... I checked any other code I could find
using those two ioctl requests, and I didn't find any other instance of the
bug.

Regards,

Stephen

 Input: validate axis and button maps before overwriting the driver's version

 Up to now axis and button map validation was done after the user-supplied
 values were copied over the driver's map. This patch copies the
 user-supplied values into temporary buffers and validated them before
 overwriting the driver's permanent maps.

 Signed-off-by: Stephen Kitt <steve@sk2.org>

 ---

 drivers/input/joydev.c |   52 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 15 deletions(-)


diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index c4a5e7b..ceaeb7b 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -459,6 +459,8 @@ static int joydev_ioctl_common(struct joydev *joydev,
 	size_t len;
 	int i, j;
 	const char *name;
+	__u8 *tmpabspam;
+	__u16 *tmpkeypam;
 
 	/* Process fixed-sized commands. */
 	switch (cmd) {
@@ -511,16 +513,26 @@ static int joydev_ioctl_common(struct joydev *joydev,
 
 	case (JSIOCSAXMAP & ~IOCSIZE_MASK):
 		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->abspam));
-		/*
-		 * FIXME: we should not copy into our axis map before
-		 * validating the data.
-		 */
-		if (copy_from_user(joydev->abspam, argp, len))
-			return -EFAULT;
 
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
@@ -531,17 +543,27 @@ static int joydev_ioctl_common(struct joydev *joydev,
 
 	case (JSIOCSBTNMAP & ~IOCSIZE_MASK):
 		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->keypam));
-		/*
-		 * FIXME: we should not copy into our keymap before
-		 * validating the data.
-		 */
-		if (copy_from_user(joydev->keypam, argp, len))
-			return -EFAULT;
 
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
 
