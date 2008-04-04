From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [patch]fix dma on stack in usbtouchscreen
Date: Fri, 4 Apr 2008 14:31:02 +0200
Message-ID: <200804041431.03398.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: daniel.ritz-OI3hZJvNYWs@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

DMA on the stack is not allowed. The buffer must be kmalloced.

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>

---

--- linux-2.6.25-rc7-vanilla/drivers/input/touchscreen/usbtouchscreen.c	2008-03-31 15:16:40.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/input/touchscreen/usbtouchscreen.c	2008-04-04 14:19:07.000000000 +0200
@@ -396,9 +396,12 @@ static int gunze_read_data(struct usbtou
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
@@ -406,9 +409,11 @@ static int dmc_tsc10_init(struct usbtouc
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
@@ -417,20 +422,22 @@ static int dmc_tsc10_init(struct usbtouc
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
