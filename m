From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Restoring joydev BTNMAP ioctl compatibility
Date: Mon, 10 Aug 2009 01:14:12 -0700
Message-ID: <20090810084436.98FFA526EC9@mailhub.coreip.homeip.net>
References: <20090810085242.3676ebc6@sk2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:5141 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbZHJIOQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2009 04:14:16 -0400
Received: by rv-out-0506.google.com with SMTP id f6so937933rvb.1
        for <linux-input@vger.kernel.org>; Mon, 10 Aug 2009 01:14:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090810085242.3676ebc6@sk2.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Kitt <steve@sk2.org>
Cc: linux-input@vger.kernel.org

Hi Stephen,

On Mon, Aug 10, 2009 at 08:52:42AM +0200, Stephen Kitt wrote:
> Hi,
> 
> The KEY_MAX change in 2.6.28 changed the definitions of the button map
> joydev ioctls (JSIOCSBTNMAP and JSIOCGBTNMAP). Thus software built using
> pre-2.6.28 headers fails when retrieving or setting the button map on 2.6.28
> and greater kernels.
> 

Darn, this is bad...

> The attached patch reintroduced the old ioctl definitions to restore
> compatibility. It only copies as much information as was supported in
> previous versions, but since this still allows for devices with 256 buttons I
> doubt there's much chance of losing information, hence the lack of a printk()
> warning.
> 

However adding the "old" ioctls is not the right solution, we should be
just respecing the size encoded in the ioctl and limit the amount of
data sent/received if it is less than our internal buffers. Could you
please try the patch below?

Thanks!

-- 
Dmitry

Input: joydev - fix JSIOCSBTNMAP and JSIOCGBTNMAP ioctls

The KEY_MAX change in 2.6.28 changed the amount of data transmitted by
JSIOCSBTNMAP and JSIOCGBTNMAP joydev ioctls; unfortunately joydev driver
did not pay attention to the length of the request and thus caused
software that was compiled with old definitions fail. Change the
joydev driver to respect size parameter encoded in ioctl.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joydev.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)


diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 4cfd084..d15aaae 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -456,6 +456,7 @@ static int joydev_ioctl_common(struct joydev *joydev,
 				unsigned int cmd, void __user *argp)
 {
 	struct input_dev *dev = joydev->handle.dev;
+	size_t len;
 	int i, j;
 
 	switch (cmd) {
@@ -516,8 +517,12 @@ static int joydev_ioctl_common(struct joydev *joydev,
 			sizeof(__u8) * (ABS_MAX + 1)) ? -EFAULT : 0;
 
 	case JSIOCSBTNMAP:
-		if (copy_from_user(joydev->keypam, argp,
-				   sizeof(__u16) * (KEY_MAX - BTN_MISC + 1)))
+		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->keypam));
+		/*
+		 * FIXME: we should not copy into our keymap before
+		 * validating the data.
+		 */
+		if (copy_from_user(joydev->keypam, argp, len))
 			return -EFAULT;
 
 		for (i = 0; i < joydev->nkey; i++) {
@@ -530,12 +535,11 @@ static int joydev_ioctl_common(struct joydev *joydev,
 		return 0;
 
 	case JSIOCGBTNMAP:
-		return copy_to_user(argp, joydev->keypam,
-			sizeof(__u16) * (KEY_MAX - BTN_MISC + 1)) ? -EFAULT : 0;
+		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->keypam));
+		return copy_to_user(argp, joydev->keypam, len) ? -EFAULT : 0;
 
 	default:
 		if ((cmd & ~IOCSIZE_MASK) == JSIOCGNAME(0)) {
-			int len;
 			const char *name = dev->name;
 
 			if (!name)
