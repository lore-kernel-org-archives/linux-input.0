From: Oliver Neukum <dmitry.torokhov@gmail.com>
Subject: [PATCH 20/37] Input: usbtouchscreen - don't use DMA on stack
Date: Fri, 4 Apr 2008 15:31:47 -0400
Message-ID: <76d057ce5a48034c97f604a0a25a87093e072c71.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:8681 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760196AbYDUNTe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:34 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3106317waf.23
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:33 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

DMA on the stack is not allowed. The buffer must be kmalloced.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/usbtouchscreen.c |   31 +++++++++++++++++----------
 1 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 63f9664..3a0a8ca 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -396,9 +396,12 @@ static int gunze_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
 static int dmc_tsc10_init(struct usbtouch_usb *usbtouch)
 {
 	struct usb_device *dev = usbtouch->udev;
-	int ret;
-	unsigned char buf[2];
+	int ret = -ENOMEM;
+	unsigned char *buf;
 
+	buf = kmalloc(2, GFP_KERNEL);
+	if (!buf)
+		goto err_nobuf;
 	/* reset */
 	buf[0] = buf[1] = 0xFF;
 	ret = usb_control_msg(dev, usb_rcvctrlpipe (dev, 0),
@@ -406,9 +409,11 @@ static int dmc_tsc10_init(struct usbtouch_usb *usbtouch)
 	                      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 	                      0, 0, buf, 2, USB_CTRL_SET_TIMEOUT);
 	if (ret < 0)
-		return ret;
-	if (buf[0] != 0x06 || buf[1] != 0x00)
-		return -ENODEV;
+		goto err_out;
+	if (buf[0] != 0x06 || buf[1] != 0x00) {
+		ret = -ENODEV;
+		goto err_out;
+	}
 
 	/* set coordinate output rate */
 	buf[0] = buf[1] = 0xFF;
@@ -417,20 +422,22 @@ static int dmc_tsc10_init(struct usbtouch_usb *usbtouch)
 	                      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 	                      TSC10_RATE_150, 0, buf, 2, USB_CTRL_SET_TIMEOUT);
 	if (ret < 0)
-		return ret;
+		goto err_out;
 	if ((buf[0] != 0x06 || buf[1] != 0x00) &&
-	    (buf[0] != 0x15 || buf[1] != 0x01))
-		return -ENODEV;
+	    (buf[0] != 0x15 || buf[1] != 0x01)) {
+		ret = -ENODEV;
+		goto err_out;
+	}
 
 	/* start sending data */
 	ret = usb_control_msg(dev, usb_rcvctrlpipe (dev, 0),
 	                      TSC10_CMD_DATA1,
 	                      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 	                      0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+err_out:
+	kfree(buf);
+err_nobuf:
+	return ret;
 }
 
 
-- 
1.5.5.rc2.6.gf58d


