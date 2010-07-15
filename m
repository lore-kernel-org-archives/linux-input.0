From: Oliver Neukum <oneukum@suse.de>
Subject: [PATCH 3/3] usbtouchscreen: Implement reset_resume()
Date: Thu, 15 Jul 2010 15:56:44 +0200
Message-ID: <201007151556.44045.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37858 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933231Ab0GON5a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jul 2010 09:57:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

>From c12539f30d0585056be37227a8d65976db49241f Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver@neukum.org>
Date: Thu, 24 Jun 2010 08:50:25 +0200
Subject: [PATCH 3/3] usbtouchscreen: Implement reset_resume()

This implements reset_resume() by splitting init into allocations
of private data structures and device initializations. Device initializations
are repeated upon reset_resume.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 drivers/input/touchscreen/usbtouchscreen.c |  108 +++++++++++++++++++--------
 1 files changed, 76 insertions(+), 32 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 3c57df8..9c21707 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -95,6 +95,7 @@ struct usbtouch_device_info {
 	int  (*get_pkt_len) (unsigned char *pkt, int len);
 
 	int  (*read_data)   (struct usbtouch_usb *usbtouch, unsigned char *pkt);
+	int  (*alloc)       (struct usbtouch_usb *usbtouch);
 	int  (*init)        (struct usbtouch_usb *usbtouch);
 	void (*exit)	    (struct usbtouch_usb *usbtouch);
 };
@@ -507,7 +508,7 @@ static int dmc_tsc10_init(struct usbtouch_usb *usbtouch)
 	int ret = -ENOMEM;
 	unsigned char *buf;
 
-	buf = kmalloc(2, GFP_KERNEL);
+	buf = kmalloc(2, GFP_NOIO);
 	if (!buf)
 		goto err_nobuf;
 	/* reset */
@@ -732,11 +733,43 @@ static void nexio_ack_complete(struct urb *urb)
 {
 }
 
+static int nexio_alloc(struct usbtouch_usb *usbtouch)
+{
+	struct nexio_priv *priv;
+	int ret = -ENOMEM;
+
+	usbtouch->priv = kmalloc(sizeof(struct nexio_priv), GFP_KERNEL);
+	if (!usbtouch->priv)
+		goto out_buf;
+
+	priv = usbtouch->priv;
+
+	priv->ack_buf = kmemdup(nexio_ack_pkt, sizeof(nexio_ack_pkt),
+				GFP_KERNEL);
+	if (!priv->ack_buf)
+		goto err_priv;
+
+	priv->ack = usb_alloc_urb(0, GFP_KERNEL);
+	if (!priv->ack) {
+		dbg("%s - usb_alloc_urb failed: usbtouch->ack", __func__);
+		goto err_ack_buf;
+	}
+
+	return 0;
+
+err_ack_buf:
+	kfree(priv->ack_buf);
+err_priv:
+	kfree(priv);
+out_buf:
+	return ret;
+}
+
 static int nexio_init(struct usbtouch_usb *usbtouch)
 {
 	struct usb_device *dev = interface_to_usbdev(usbtouch->interface);
 	struct usb_host_interface *interface = usbtouch->interface->cur_altsetting;
-	struct nexio_priv *priv;
+	struct nexio_priv *priv = usbtouch->priv;
 	int ret = -ENOMEM;
 	int actual_len, i;
 	unsigned char *buf;
@@ -755,7 +788,7 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
 	if (!input_ep || !output_ep)
 		return -ENXIO;
 
-	buf = kmalloc(NEXIO_BUFSIZE, GFP_KERNEL);
+	buf = kmalloc(NEXIO_BUFSIZE, GFP_NOIO);
 	if (!buf)
 		goto out_buf;
 
@@ -787,11 +820,11 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
 		switch (buf[0]) {
 		case 0x83:	/* firmware version */
 			if (!firmware_ver)
-				firmware_ver = kstrdup(&buf[2], GFP_KERNEL);
+				firmware_ver = kstrdup(&buf[2], GFP_NOIO);
 			break;
 		case 0x84:	/* device name */
 			if (!device_name)
-				device_name = kstrdup(&buf[2], GFP_KERNEL);
+				device_name = kstrdup(&buf[2], GFP_NOIO);
 			break;
 		}
 	}
@@ -802,36 +835,11 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
 	kfree(firmware_ver);
 	kfree(device_name);
 
-	/* prepare ACK URB */
-	ret = -ENOMEM;
-
-	usbtouch->priv = kmalloc(sizeof(struct nexio_priv), GFP_KERNEL);
-	if (!usbtouch->priv)
-		goto out_buf;
-
-	priv = usbtouch->priv;
-
-	priv->ack_buf = kmemdup(nexio_ack_pkt, sizeof(nexio_ack_pkt),
-				GFP_KERNEL);
-	if (!priv->ack_buf)
-		goto err_priv;
-
-	priv->ack = usb_alloc_urb(0, GFP_KERNEL);
-	if (!priv->ack) {
-		dbg("%s - usb_alloc_urb failed: usbtouch->ack", __func__);
-		goto err_ack_buf;
-	}
-
 	usb_fill_bulk_urb(priv->ack, dev, usb_sndbulkpipe(dev, output_ep),
 			  priv->ack_buf, sizeof(nexio_ack_pkt),
 			  nexio_ack_complete, usbtouch);
 	ret = 0;
-	goto out_buf;
 
-err_ack_buf:
-	kfree(priv->ack_buf);
-err_priv:
-	kfree(priv);
 out_buf:
 	kfree(buf);
 	return ret;
@@ -1120,6 +1128,7 @@ static struct usbtouch_device_info usbtouch_dev_info[] = {
 		.rept_size	= 1024,
 		.irq_always	= true,
 		.read_data	= nexio_read_data,
+		.alloc		= nexio_alloc,
 		.init		= nexio_init,
 		.exit		= nexio_exit,
 	},
@@ -1330,6 +1339,31 @@ static int usbtouch_resume(struct usb_interface *intf)
 	return result;
 }
 
+static int usbtouch_reset_resume(struct usb_interface *intf)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+	struct input_dev *input = usbtouch->input;
+	int err = 0;
+	
+	/* reinit the device */
+	if (usbtouch->type->init) {
+		err = usbtouch->type->init(usbtouch);
+		if (err) {
+			dbg("%s - type->init() failed, err: %d",
+			    __func__, err);
+			return err;
+		}
+	}
+
+	/* restart IO if needed */
+	mutex_lock(&input->mutex);
+	if (input->users)
+		err = usb_submit_urb(usbtouch->irq, GFP_NOIO);
+	mutex_unlock(&input->mutex);
+	
+	return err;
+}
+
 static void usbtouch_free_buffers(struct usb_device *udev,
 				  struct usbtouch_usb *usbtouch)
 {
@@ -1449,12 +1483,21 @@ static int usbtouch_probe(struct usb_interface *intf,
 	usbtouch->irq->transfer_dma = usbtouch->data_dma;
 	usbtouch->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
-	/* device specific init */
+	/* device specific allocations */
+	if (type->alloc) {
+		err = type->alloc(usbtouch);
+		if (err) {
+			dbg("%s - type->alloc() failed, err: %d", __func__, err);
+			goto out_free_urb;
+		}
+	}
+	
+	/* device specific initialisation*/ 
 	if (type->init) {
 		err = type->init(usbtouch);
 		if (err) {
 			dbg("%s - type->init() failed, err: %d", __func__, err);
-			goto out_free_urb;
+			goto out_do_exit;
 		}
 	}
 
@@ -1524,6 +1567,7 @@ static struct usb_driver usbtouch_driver = {
 	.disconnect	= usbtouch_disconnect,
 	.suspend	= usbtouch_suspend,
 	.resume		= usbtouch_resume,
+	.reset_resume	= usbtouch_reset_resume,
 	.id_table	= usbtouch_devices,
 	.supports_autosuspend = 1,
 };
-- 
1.7.1

