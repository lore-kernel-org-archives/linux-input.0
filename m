From: Stephen Kitt <steve@sk2.org>
Subject: Restoring joydev BTNMAP ioctl compatibility
Date: Mon, 10 Aug 2009 08:52:42 +0200
Message-ID: <20090810085242.3676ebc6@sk2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:43986 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbZHJGwu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2009 02:52:50 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 2BEC294013E
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2009 08:52:45 +0200 (CEST)
Received: from heffalump.sk2.org (gw.sk2.org [82.228.207.51])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 08F8694011B
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2009 08:52:43 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

The KEY_MAX change in 2.6.28 changed the definitions of the button map
joydev ioctls (JSIOCSBTNMAP and JSIOCGBTNMAP). Thus software built using
pre-2.6.28 headers fails when retrieving or setting the button map on 2.6.28
and greater kernels.

The attached patch reintroduced the old ioctl definitions to restore
compatibility. It only copies as much information as was supported in
previous versions, but since this still allows for devices with 256 buttons I
doubt there's much chance of losing information, hence the lack of a printk()
warning.

Signed-off-by: Stephen Kitt <steve@sk2.org>

 joydev.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 4cfd084..764700e 100644
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
@@ -529,10 +534,28 @@ static int joydev_ioctl_common(struct joydev *joydev,
 
 		return 0;
 
+	case OLD_JSIOCSBTNMAP:
+		if (copy_from_user(joydev->keypam, argp,
+				   sizeof(__u16) * (OLD_KEY_MAX - BTN_MISC + 1)))
+			return -EFAULT;
+
+		for (i = 0; i < joydev->nkey && i < OLD_KEY_MAX - BTN_MISC + 1; i++) {
+			if (joydev->keypam[i] > KEY_MAX ||
+			    joydev->keypam[i] < BTN_MISC)
+				return -EINVAL;
+			joydev->keymap[joydev->keypam[i] - BTN_MISC] = i;
+		}
+
+		return 0;
+
 	case JSIOCGBTNMAP:
 		return copy_to_user(argp, joydev->keypam,
 			sizeof(__u16) * (KEY_MAX - BTN_MISC + 1)) ? -EFAULT : 0;
 
+	case OLD_JSIOCGBTNMAP:
+		return copy_to_user(argp, joydev->keypam,
+				    sizeof(__u16) * (OLD_KEY_MAX - BTN_MISC + 1)) ? -EFAULT : 0;
+
 	default:
 		if ((cmd & ~IOCSIZE_MASK) == JSIOCGNAME(0)) {
 			int len;
