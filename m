From: Stephen Kitt <steve@sk2.org>
Subject: Re: Restoring joydev BTNMAP ioctl compatibility
Date: Mon, 10 Aug 2009 13:29:05 +0200
Message-ID: <20090810132905.546a95ba@sk2.org>
References: <20090810085242.3676ebc6@sk2.org>
	<20090810084436.98FFA526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:52987 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747AbZHJL3N (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2009 07:29:13 -0400
In-Reply-To: <20090810084436.98FFA526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 10 Aug 2009 01:14:12 -0700, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Aug 10, 2009 at 08:52:42AM +0200, Stephen Kitt wrote:
> > The attached patch reintroduced the old ioctl definitions to restore
> > compatibility. It only copies as much information as was supported in
> > previous versions, but since this still allows for devices with 256
> > buttons I doubt there's much chance of losing information, hence the lack
> > of a printk() warning.
> 
> However adding the "old" ioctls is not the right solution, we should be
> just respecing the size encoded in the ioctl and limit the amount of
> data sent/received if it is less than our internal buffers. Could you
> please try the patch below?

The more generic approach in your patch is indeed better, but it doesn't
solve the original problem. Because the ioctl command code encodes the
expected argument size, the case statements still only match the new ioctl
codes, and the old ones used before 2.6.28 aren't matched and result in
-EINVAL. For example, jstest built with the 2.6.27 headers will call
ioctl(..., 2181065268, ...) (2181065268 is the value corresponding to
JSIOCGBTNMAP before 2.6.28), but 2.6.28 kernels and later will be looking for
2214619700 which is the value corresponding to JSIOCGBTNMAP from 2.6.28
onwards.

The following merges both and handles all cases...

A cleaner approach with a single case statement would involve switching on
_IOC_NR(cmd) rather than cmd directly, and handling the length explicitly.
That would make the ioctl ABI backwards-compatible when KEY_MAX increases
without explicit handling! I can rewrite the patch in this way if you wish.

Regards,

Stephen

 Input: joydev - handle old values of JSIOCSBTNMAP and JSIOCGBTNMAP ioctls

 The KEY_MAX change in 2.6.28 changed the values of the JSIOCSBTNMAP and
 JSIOCGBTNMAP constants; software compiled with the old values no longer
 works with kernels following 2.6.28, because the ioctl switch statement no
 longer matches the values given by the software. This patch adds explicit
 handling of the old ioctl values.

 Signed-off-by: Stephen Kitt <steve@sk2.org>

 ---

 drivers/input/joydev.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 4cfd084..b26de29 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -35,6 +35,11 @@ MODULE_LICENSE("GPL");
 #define JOYDEV_MINORS		16
 #define JOYDEV_BUFFER_SIZE	64
 
+/* Support for old ioctls using the old value of KEY_MAX. */
+#define OLD_KEY_MAX		0x1ff
+#define OLD_JSIOCSBTNMAP	_IOW('j', 0x33, __u16[OLD_KEY_MAX - BTN_MISC + 1])
+#define OLD_JSIOCGBTNMAP	_IOR('j', 0x34, __u16[OLD_KEY_MAX - BTN_MISC + 1])
+
 struct joydev {
 	int exist;
 	int open;
@@ -456,6 +461,7 @@ static int joydev_ioctl_common(struct joydev *joydev,
 				unsigned int cmd, void __user *argp)
 {
 	struct input_dev *dev = joydev->handle.dev;
+	size_t len;
 	int i, j;
 
 	switch (cmd) {
@@ -516,8 +522,13 @@ static int joydev_ioctl_common(struct joydev *joydev,
 			sizeof(__u8) * (ABS_MAX + 1)) ? -EFAULT : 0;
 
 	case JSIOCSBTNMAP:
-		if (copy_from_user(joydev->keypam, argp,
-				   sizeof(__u16) * (KEY_MAX - BTN_MISC + 1)))
+	case OLD_JSIOCSBTNMAP:
+		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->keypam));
+		/*
+		 * FIXME: we should not copy into our keymap before
+		 * validating the data.
+		 */
+		if (copy_from_user(joydev->keypam, argp, len))
 			return -EFAULT;
 
 		for (i = 0; i < joydev->nkey; i++) {
@@ -530,12 +541,12 @@ static int joydev_ioctl_common(struct joydev *joydev,
 		return 0;
 
 	case JSIOCGBTNMAP:
-		return copy_to_user(argp, joydev->keypam,
-			sizeof(__u16) * (KEY_MAX - BTN_MISC + 1)) ? -EFAULT : 0;
+	case OLD_JSIOCGBTNMAP:
+		len = min_t(size_t, _IOC_SIZE(cmd), sizeof(joydev->keypam));
+		return copy_to_user(argp, joydev->keypam, len) ? -EFAULT : 0;
 
 	default:
 		if ((cmd & ~IOCSIZE_MASK) == JSIOCGNAME(0)) {
-			int len;
 			const char *name = dev->name;
 
 			if (!name)
